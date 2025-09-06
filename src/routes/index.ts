import { Router } from "express";

import articulosRouter from "./articulos.routes";
import fabricantesRouter from "./fabricantes.routes";
import ubicacionesRouter from "./ubicaciones.routes";
import colocacionesRouter from "./colocaciones.routes";
import clientesRouter from "./clientes.routes";
import comprasRouter from "./compras.routes";
import empleadosRouter from "./empleados.routes";
import usuariosRouter from "./usuarios.routes";

export const apiRouter = Router();

apiRouter.use("/articulos", articulosRouter);
apiRouter.use("/fabricantes", fabricantesRouter);
apiRouter.use("/ubicaciones", ubicacionesRouter);
apiRouter.use("/colocaciones", colocacionesRouter);
apiRouter.use("/clientes", clientesRouter);
apiRouter.use("/compras", comprasRouter);
apiRouter.use("/empleados", empleadosRouter);
apiRouter.use("/usuarios", usuariosRouter);
