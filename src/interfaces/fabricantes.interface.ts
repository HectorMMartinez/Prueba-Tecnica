export interface IFabricanteCreate {
  nombre: string;
}

export interface IFabricanteUpdate {
  nombre?: string;
}

export interface IFabricante {
  id: bigint;
  nombre: string;
  createdAt: Date;
}
