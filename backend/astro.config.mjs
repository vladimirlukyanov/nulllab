import path, { dirname } from 'path'
import { fileURLToPath } from 'url'

const __filename = fileURLToPath(import.meta.url)
const __dirname = dirname(__filename)

import { defineConfig } from 'astro/config'
import { imageService } from '@unpic/astro/service'

import add_csh_nonce from './src/lib/utils/add_csh_nonce.ts'

import mdx from '@astrojs/mdx'
import sitemap from '@astrojs/sitemap'

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
  ],

  // scopedStyleStrategy: 'where',
  image: {
    service: imageService(),
  },
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
  },
})
