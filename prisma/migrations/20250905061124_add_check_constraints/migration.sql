ALTER TABLE "Articulo"
  ADD CONSTRAINT "ck_articulo_stock_nonnegative" CHECK ("stock" >= 0);

ALTER TABLE "Colocacion"
  ADD CONSTRAINT "ck_colocacion_precio_nonnegative" CHECK ("precio" >= 0);

ALTER TABLE "Compra"
  ADD CONSTRAINT "ck_compra_unidades_positive" CHECK ("unidades" > 0);
