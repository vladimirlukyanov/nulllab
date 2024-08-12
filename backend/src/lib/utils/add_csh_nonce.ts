import type { AstroIntegration } from "astro";
import * as fs from "fs";

export default function add_csh_nonce(): AstroIntegration {
  return {
    name: "add-csh-nonce",
    hooks: {
      "astro:build:done": async ({ dir }) => {
        const folder = dir.pathname;
        const files = fs.readdirSync(folder).reduce<string[]>((acc, f) => {
          const file = `${folder}${f}`;
          if (fs.statSync(file).isFile()) {
            acc.push(file);
          } else if (fs.statSync(file).isDirectory()) {
            acc = acc.concat(fs.readdirSync(file).map((f) => `${file}/${f}`));
          }
          return acc;
        }, []);

        function openFiles(fileType: "html") {
          return files
            .filter((i) => i.endsWith(`.${fileType}`))
            .map((path) => ({
              contents: fs.readFileSync(path, "utf8"),
              path,
              fileName: path.split("/").pop()!,
            }));
        }

        const htmlFiles = openFiles("html");

        for (const html of htmlFiles) {
          const regex = /<(link|style|script)/gi;
          const replacement = '<$1 nonce="X4UCHYnX"';
          html.contents = html.contents.replace(regex, replacement);

          fs.writeFileSync(html.path, html.contents);
        }
      },
    },
  };
}
