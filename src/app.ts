import express from "express";
import morgan from "morgan";
import { apiRouter } from "./routes";
import { errorHandler } from "./middlewares/error.middleware";
import { notFound } from "./middlewares/notFound.middleware";

export function buildApp() {
  const app = express();

  app.use(express.json());
  app.use(morgan("dev")); 

  app.get("/health", (_req, res) => {
    res.json({ status: "ok", message: "API funcionando 🚀" });
  });

  app.use("/api", apiRouter);

  app.use(notFound);
  app.use(errorHandler);

  return app;
}
