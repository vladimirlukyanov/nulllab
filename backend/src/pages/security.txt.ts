import type { APIRoute } from "astro";

const expiresDate = new Date();
expiresDate.setFullYear(expiresDate.getFullYear() + 1);
const expires = expiresDate.toISOString();

const securityTXT = `
# Required: When this file expires (ISO 8601 format, within 1 year)
Expires: ${expires}

# Preferred languages for security reports
Preferred-Languages: en

# Link to security policy page
Policy: ${import.meta.env.SITE}/privacy-policy

`.trim();

export const GET: APIRoute = () => {
    return new Response(securityTXT, {
        headers: {
            'Content-Type': 'text/plain; charset=utf-8',
        },
    });
};