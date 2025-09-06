import { z } from "zod";

export const fabricanteCreateSchema = z.object({
  nombre: z.string().min(1, "nombre es requerido"),
});

export const fabricanteUpdateSchema = z.object({
  nombre: z.string().min(1).optional(),
});

export type FabricanteCreateInput = z.infer<typeof fabricanteCreateSchema>;
export type FabricanteUpdateInput = z.infer<typeof fabricanteUpdateSchema>;
