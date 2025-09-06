import { Router, Request, Response } from "express";

export function createCrudRouter(entity: string) {
  const r = Router();
  r.post("/", (req: Request, res: Response) => res.status(501).json({ entity, action: "create", body: req.body }));
  r.get("/", (_req, res) => res.json({ entity, action: "list", items: [] }));
  r.get("/:id", (req, res) => res.json({ entity, action: "get", id: req.params.id, item: null }));
  r.put("/:id", (req, res) => res.status(501).json({ entity, action: "update", id: req.params.id, body: req.body }));
  r.delete("/:id", (req, res) => res.status(501).json({ entity, action: "delete", id: req.params.id }));
  return r;
}
