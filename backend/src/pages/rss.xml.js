import rss from "@astrojs/rss";
import { getCollection } from "astro:content";
import { SITE_TITLE, SITE_DESCRIPTION } from "../consts";

export async function GET(context) {
  const posts = await getCollection("blog");
  return rss({
    title: SITE_TITLE,
    description: SITE_DESCRIPTION,
    site: context.site,
    items: posts.map((post) => {
      console.log(post);
      return {
        ...post.data,
        pubDate: post?.data?.published_date
          ? post?.data?.published_date
          : new Date("now"),
        link: `/blog/${post.slug}/`,
      };
    }),
  });
}
