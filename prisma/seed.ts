import "dotenv/config";
import { readFileSync } from "fs";
import { join } from "path";
import pg from "pg";

const { Client } = pg;

async function main() {
  console.log("Seeding database with Northwind data...");

  const sql = readFileSync(join(import.meta.dirname, "northwind.sql"), "utf-8");

  const client = new Client({
    connectionString: process.env.DATABASE_URL,
    ssl: { rejectUnauthorized: false },
  });

  await client.connect();

  try {
    await client.query(sql);
    console.log("Database seeded successfully!");
  } catch (err) {
    console.error("Failed to seed database:", err);
    process.exit(1);
  } finally {
    await client.end();
  }
}

main();
