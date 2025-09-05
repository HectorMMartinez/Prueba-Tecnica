ALTER TABLE "Articulo"
  ADD CONSTRAINT "Articulo_stock_check" CHECK ("stock" >= 0);

ALTER TABLE "Colocacion"
  ADD CONSTRAINT "Colocacion_precio_check" CHECK ("precio" >= 0);

ALTER TABLE "Compra"
  ADD CONSTRAINT "Compra_unidades_check" CHECK ("unidades" > 0);
