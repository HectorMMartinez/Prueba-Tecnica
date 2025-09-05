import "dotenv/config";
import { prisma } from "./config/prisma";

export async function healthCheckDB() {
  try {
    const r = await prisma.$queryRaw`SELECT 1 as ok`;
    return Array.isArray(r) && r[0]?.ok === 1;
  } catch {
    return false;
  }
}
