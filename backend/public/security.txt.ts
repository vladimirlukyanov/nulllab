import type { APIRoute } from "astro";

const securityTXT = `
tt: tt
`.trim();

export const GET: APIRoute = () => {
    return new Response(securityTXT, {
        headers: {
            "Content-Type": "text/plain; charset=utf-8",
        },
    });
};