import path, { dirname } from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

import { defineConfig } from 'astro/config';
import { imageService } from '@unpic/astro/service';

import add_csh_nonce from './src/lib/utils/add_csh_nonce.ts'
import {indexNow} from './src/lib/integration';

import mdx from '@astrojs/mdx';
import sitemap from '@astrojs/sitemap';

// https://astro.build/config
export default defineConfig({
  compressHTML: true,
  outDir: './dist/',
  site: 'https://nulllab.net',
  markdown: {
    syntaxHighlight: false,
  },
  integrations: [
    mdx(),
    sitemap(),
    indexNow({
      key: process.env.INDEXNOW_KEY,
      location : 'indexnow'
    }),
    (await import("astro-compress")).default({
      Image: false,
    }),
  ],

  // scopedStyleStrategy: 'where',
  image: {
    service: imageService(),
  },
  scopedStyleStrategy: 'where',
  server: {
    host: true,
  },
  security: {
    checkOrigin: true,
  },
  vite: {
    resolve: {
      alias: {
        '~': path.resolve(__dirname, './src'),
      },
    },
  }
});