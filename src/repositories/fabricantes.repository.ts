import { prisma } from "../config/prisma";
import { IFabricanteCreate, IFabricanteUpdate } from "../interfaces/fabricantes.interface";

export const FabricantesRepo = {
  async list(params?: { q?: string; take?: number; skip?: number }) {
    const { q, take = 50, skip = 0 } = params ?? {};

    const where = q
      ? { nombre: { contains: q, mode: "insensitive" as const } }
      : {};

    const [items, total] = await Promise.all([
      prisma.fabricante.findMany({ where, orderBy: { id: "asc" }, take, skip }),
      prisma.fabricante.count({ where }),
    ]);

    return { total, items };
  },

  async create(data: IFabricanteCreate) {
    return prisma.fabricante.create({ data });
  },

  async update(id: bigint, data: IFabricanteUpdate) {
    return prisma.fabricante.update({ where: { id }, data });
  },

  async remove(id: bigint) {
    await prisma.fabricante.delete({ where: { id } });
  },
};
