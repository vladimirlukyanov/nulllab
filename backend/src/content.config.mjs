import {defineCollection, reference, z} from "astro:content";

import {glob} from 'astro/loaders';

const blog = defineCollection({
  loader: glob({ base: './src/content/blog', pattern: '**/*.*' }),
  schema: ({image}) => z.object({
        title: z.string(),
        description: z.string().optional(),

        category: z.string(),

        type: z.string().optional(),
        tags: z.array(z.string()).optional(),

        featured: z.boolean().optional(),

        cover: image().optional(),

        image: z
            .object({
                url: image(),
                alt: z.string(),
            })
            .optional(),

        related_posts : z.array(reference('blog')).optional(),

        published_date: z.date(),
        updated_date: z.date().optional(),
    }),
});

const categories = defineCollection({
  loader: glob({ pattern: '**/[^_]*.json', base: "./src/content/categories" }),
  schema: z.object({
    name: z.string(),
    portfolio: z.string().url(),
  })
});

const tags = defineCollection({
  loader: glob({ pattern: '**/[^_]*.json', base: "./src/content/tags" }),
  schema: z.object({
    name: z.string(),
    portfolio: z.string().url(),
  })
});

const authors = defineCollection({
  loader: glob({ pattern: '**/[^_]*.json', base: "./src/content/authors" }),
  schema: z.object({
    name: z.string(),
    portfolio: z.string().url(),
  })
});

export const collections = {blog, categories, tags, authors};