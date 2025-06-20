import { defineCollection, z } from "astro:content";
import { glob } from 'astro/loaders';

const blog = defineCollection({
    loader: glob({ pattern: "**/*.mdx", base: "./src/content" }),
    schema: ({ image }) =>
    z.object({
      title: z.string(),
      description: z.string().optional(),
      // Transform string to Date object
      published_date: z.date(),
      updatedDate: z.date().optional(),
      heroImage: z.string().optional(),
      category: z.string(),
      type: z.string().optional(),
      tags: z.array(z.string()).optional(),
      image: z
        .object({
          url: image(),
          alt: z.string(),
        })
        .optional(),
    }),
});

export const collections = { blog };
