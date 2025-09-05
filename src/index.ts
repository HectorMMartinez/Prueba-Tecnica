import express from "express";
import { healthCheckDB } from "./db";

const app = express();
const PORT = Number(process.env.PORT || 3000);

app.get("/", (_req, res) => {
  res.json({ message: "API funcionando 🚀" });
});

app.get("/health", async (_req, res) => {
  const db = await healthCheckDB();
  res.json({ status: "ok", db: db ? "up" : "down" });
});

app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});
