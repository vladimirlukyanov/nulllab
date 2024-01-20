import { defineConfig } from 'astro/config';
import mdx from '@astrojs/mdx';
import add_csh_nonce from './src/lib/utils/add_csh_nonce.ts';

import sitemap from '@astrojs/sitemap';

// https://astro.build/config
export default defineConfig({
  compressHTML: true,
  outDir: '../frontend/',
  site: 'https://nulllab.net',
  integrations: [mdx(), sitemap(), add_csh_nonce()],
});
