import { defineCollection, z } from "astro:content";
import { file } from "astro/loaders";

const items = defineCollection({
  loader: file("src/items/items.json"),
  schema: z.object({
    name: z.string(),
    id: z.string(),
    time_taken: z.number(),
    requirements: z.record(z.string(), z.number()),
    steps: z.number(),
    type: z.enum([
      "raw-material",
      "regional-raw-material",
      "commercial-product",
      "seasonal-product",
    ]),
    production: z.enum([
      "building-supplies-store",
      "car-parts",
      "coconut-farm",
      "donut-shop",
      "eco-shop",
      "factory",
      "farmers-market",
      "fashion-store",
      "fast-food-restaurant",
      "fish-marketplace",
      "fishery",
      "furniture-store",
      "gardening-supplies",
      "green-factory",
      "hardware-store",
      "home-appliances",
      "mulberry-grove",
      "oil-plant",
      "santas-workshop",
      "silk-store",
      "tropical-products-store",
    ]),
  }),
});

export const collections = { items };
