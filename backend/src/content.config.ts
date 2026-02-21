import {defineCollection, reference, z} from "astro:content";
import {glob} from 'astro/loaders';

const blog = defineCollection({
    loader: glob({base: './src/content/blog', pattern: '**/*.mdx'}),
    schema: ({image}) => z.object({
        title: z.string(),

        description: z.string().optional(),
        short_description: z.string().optional(),

        authors: z.array(reference('authors')),
        categories: z.array(reference('categories')),
        tags: z.array(reference('tags')).optional(),

        type: z.string().optional(),

        featured: z.boolean().optional(),
        image: z
            .object({
                url: image(),
                alt: z.string(),
            })
            .optional(),

        related_posts: z.array(reference('blog')).optional(),

        composition: z.object({
            news: z.object({
                column: z.number(),
                block: z.enum(['small', 'medium', 'big']),
            }),
        }).optional(),

        published_date: z.date(),
        updated_date: z.date().optional(),
    }),
});

const categories = defineCollection({
    loader: glob({base: './src/content/categories', pattern: '**/*.mdx'}),
    schema: ({image}) => z.object({
        title: z.string(),
        description: z.string().optional(),
        image: z
            .object({
                url: image(),
                alt: z.string(),
            })
            .optional(),
    })
});

const tags = defineCollection({
    loader: glob({base: './src/content/tags', pattern: '**/*.mdx'}),
    schema: ({image}) => z.object({
        title: z.string(),
        description: z.string().optional(),
        image: z
            .object({
                url: image(),
                alt: z.string(),
            })
            .optional(),
    })
});

const authors = defineCollection({
    loader: glob({base: './src/content/authors', pattern: '**/*.mdx'}),
    schema: ({image}) => z.object({
        title: z.string(),
        description: z.string().optional(),
        position: z.string().optional(),
        image: z
            .object({
                url: image(),
                alt: z.string(),
            })
            .optional(),
    })
});

export const collections = {blog, categories, tags, authors};