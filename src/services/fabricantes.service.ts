import { FabricantesRepo } from "../repositories/fabricantes.repository";
import { IFabricanteCreate, IFabricanteUpdate } from "../interfaces/fabricantes.interface";

export const FabricantesService = {
  async list(q?: string, take?: number, skip?: number) {
    return FabricantesRepo.list({ q, take, skip });
  },

  async create(payload: IFabricanteCreate) {
    return FabricantesRepo.create(payload);
  },

  async update(idNum: number, payload: IFabricanteUpdate) {
    const id = BigInt(idNum);
    return FabricantesRepo.update(id, payload);
  },

  async remove(idNum: number) {
    const id = BigInt(idNum);
    await FabricantesRepo.remove(id);
    return;
  },
};
