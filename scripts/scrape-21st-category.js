#!/usr/bin/env node
/**
 * scrape-21st-category.js
 *
 * Scrapes a 21st.dev category page and extracts free/open component metadata.
 * Used by the frontend-components skill when local catalog has no match.
 *
 * Usage: node scrape-21st-category.js <category-slug> [max-results]
 * Example: node scrape-21st-category.js hero 10
 *
 * Requires: playwright (npx playwright install chromium)
 * Output: JSON array of component metadata to stdout
 */

const { chromium } = require('playwright');

const CATEGORY = process.argv[2];
const MAX = parseInt(process.argv[3] || '10', 10);

if (!CATEGORY) {
  console.error('Usage: node scrape-21st-category.js <category-slug> [max-results]');
  process.exit(1);
}

// Blocked component signals (paid/pro/premium)
const BLOCK_PATTERNS = [
  /\bpro\b/i, /\bpremium\b/i, /\bpaid\b/i, /\bsubscription\b/i,
  /\bupgrade\b/i, /\ball.?access\b/i, /\bpaywall\b/i,
  /members?\s+only/i, /login\s+required/i, /\btrial\b.*\bcard\b/i
];

function isBlocked(text) {
  return BLOCK_PATTERNS.some(p => p.test(text));
}

(async () => {
  const browser = await chromium.launch({ headless: true });
  const page = await browser.newPage();

  const categoryUrl = `https://21st.dev/community/components/s/${CATEGORY}`;

  try {
    await page.goto(categoryUrl, { waitUntil: 'networkidle', timeout: 20000 });

    // Extract component links from category page
    const componentUrls = await page.evaluate(() => {
      return Array.from(document.querySelectorAll('a'))
        .map(a => a.href)
        .filter(h => h.includes('21st.dev/community/components/') && !h.includes('/s/') && !h.includes('/community/') + h.split('/').length < 8)
        .slice(0, 15);
    });

    const uniqueUrls = [...new Set(componentUrls)].slice(0, MAX);

    if (uniqueUrls.length === 0) {
      console.error(JSON.stringify({ error: `No components found for category: ${CATEGORY}`, url: categoryUrl }));
      await browser.close();
      process.exit(0);
    }

    const results = [];

    for (const url of uniqueUrls) {
      try {
        await page.goto(url, { waitUntil: 'domcontentloaded', timeout: 15000 });

        // Click "View code" tab if present to reveal source
        try {
          const viewCodeBtn = await page.$('button:has-text("View code"), a:has-text("View code"), [aria-label="View code"]');
          if (viewCodeBtn) await viewCodeBtn.click();
          await page.waitForTimeout(800);
        } catch (_) {}

        const metadata = await page.evaluate(() => {
          const title = document.querySelector('h1')?.textContent?.trim() || '';
          const creator = document.querySelector('[class*="creator"], [class*="author"]')?.textContent?.trim() || '';
          const allCode = Array.from(document.querySelectorAll('code')).map(c => c.textContent?.trim() || '');
          const installCmd = allCode.find(c => c.includes('shadcn') || c.includes('npx')) || '';

          // Extract component source code — look for largest non-install code block
          const sourceCode = allCode
            .filter(c => !c.includes('npx') && !c.includes('shadcn') && c.length > 50)
            .sort((a, b) => b.length - a.length)[0] || '';

          const hasPromptBtn = !!(
            document.querySelector('[aria-label*="prompt"], [class*="prompt"]') ||
            Array.from(document.querySelectorAll('button')).find(b => /copy\s+(prompt|for\s+claude)/i.test(b.textContent))
          );

          // Try to get provider AI prompt text
          let providerPrompt = '';
          const promptBtn = Array.from(document.querySelectorAll('button')).find(b =>
            /copy\s+(prompt|for\s+claude|for\s+cursor|for\s+v0)/i.test(b.textContent)
          );
          if (promptBtn) {
            const promptArea = document.querySelector('textarea[class*="prompt"], pre[class*="prompt"], code[class*="prompt"]');
            providerPrompt = promptArea?.textContent?.trim() || '';
          }

          const pageText = document.body?.textContent || '';
          return { title, creator, installCmd, sourceCode, hasPromptBtn, providerPrompt, pageText: pageText.substring(0, 300) };
        });

        // Check if blocked
        if (isBlocked(metadata.pageText) || isBlocked(metadata.title)) {
          results.push({
            url,
            title: metadata.title,
            blocked: true,
            blocked_reason: 'paid/pro/premium indicator detected',
            free_tier_status: 'blocked_paid'
          });
          continue;
        }

        // Parse URL parts: /community/components/<author>/<name>/<variant>
        const parts = url.replace('https://21st.dev/community/components/', '').split('/');
        const author = parts[0] || '';
        const name = parts[1] || metadata.title;
        const variant = parts[2] || 'default';

        results.push({
          id: `21st-dev-${name}-${variant}`.toLowerCase().replace(/[^a-z0-9-]/g, '-'),
          name: metadata.title || name,
          creator: author,
          source: '21st.dev',
          source_url: url,
          category: CATEGORY,
          install_command: metadata.installCmd,
          import_method: metadata.installCmd.includes('shadcn') ? 'shadcn_cli' : 'copy_paste',
          free_tier_status: 'free_likely',
          has_code: metadata.sourceCode.length > 0,
          source_code: metadata.sourceCode || null,
          provider_prompt_available: metadata.hasPromptBtn,
          provider_prompt: metadata.providerPrompt || null,
          blocked: false,
          approval_status: 'discovered'
        });

      } catch (err) {
        // skip failed component pages
      }
    }

    const free = results.filter(r => !r.blocked);
    const blocked = results.filter(r => r.blocked);

    console.log(JSON.stringify({
      category: CATEGORY,
      url: categoryUrl,
      total_found: uniqueUrls.length,
      free_count: free.length,
      blocked_count: blocked.length,
      components: free,
      blocked_components: blocked
    }, null, 2));

  } catch (err) {
    console.error(JSON.stringify({ error: err.message, category: CATEGORY }));
    process.exit(1);
  } finally {
    await browser.close();
  }
})();
