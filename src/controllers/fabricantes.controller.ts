import { Router } from "express";
import { FabricantesService } from "../services/fabricantes.service";
import { fabricanteCreateSchema, fabricanteUpdateSchema } from "../schemas/fabricantes.schema";

const router = Router();

/** GET /api/fabricantes?q=&take=&skip= */
router.get("/", async (req, res, next) => {
  try {
    const q = (req.query.q as string) || undefined;
    const take = req.query.take ? Number(req.query.take) : undefined;
    const skip = req.query.skip ? Number(req.query.skip) : undefined;
    const result = await FabricantesService.list(q, take, skip);
    res.json(result);
  } catch (err) { next(err); }
});

/** POST /api/fabricantes { nombre } */
router.post("/", async (req, res, next) => {
  try {
    const parse = fabricanteCreateSchema.safeParse(req.body);
    if (!parse.success) return res.status(400).json({ error: parse.error.flatten() });
    const created = await FabricantesService.create(parse.data);
    res.status(201).json(created);
  } catch (err) { next(err); }
});

/** PUT /api/fabricantes/:id { nombre? } */
router.put("/:id", async (req, res, next) => {
  try {
    const id = Number(req.params.id);
    if (Number.isNaN(id)) return res.status(400).json({ error: "id inválido" });

    const parse = fabricanteUpdateSchema.safeParse(req.body);
    if (!parse.success) return res.status(400).json({ error: parse.error.flatten() });

    const updated = await FabricantesService.update(id, parse.data);
    res.json(updated);
  } catch (err) { next(err); }
});

/** DELETE /api/fabricantes/:id */
router.delete("/:id", async (req, res, next) => {
  try {
    const id = Number(req.params.id);
    if (Number.isNaN(id)) return res.status(400).json({ error: "id inválido" });

    await FabricantesService.remove(id);
    res.status(204).send();
  } catch (err) { next(err); }
});

export default router;
