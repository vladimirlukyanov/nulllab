import type { APIRoute } from "astro";

const robotsTxt = `392886a6669b40a09d6e6a73eaa47960`.trim();

export const GET: APIRoute = () => {
    return new Response(robotsTxt, {
        headers: {
            'Content-Type': 'text/plain; charset=utf-8',
        },
    });
};