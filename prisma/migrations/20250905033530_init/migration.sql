-- CreateEnum
CREATE TYPE "public"."ClienteTipo" AS ENUM ('regular', 'vip');

-- CreateEnum
CREATE TYPE "public"."UsuarioRol" AS ENUM ('admin', 'vendedor');

-- CreateTable
CREATE TABLE "public"."Fabricante" (
    "id" BIGSERIAL NOT NULL,
    "nombre" VARCHAR(120) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Fabricante_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Articulo" (
    "id" BIGSERIAL NOT NULL,
    "fabricanteId" BIGINT NOT NULL,
    "codigoBarras" VARCHAR(64) NOT NULL,
    "descripcion" TEXT,
    "stock" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Articulo_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Ubicacion" (
    "id" BIGSERIAL NOT NULL,
    "nombre" VARCHAR(120) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Ubicacion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Colocacion" (
    "id" BIGSERIAL NOT NULL,
    "articuloId" BIGINT NOT NULL,
    "ubicacionId" BIGINT NOT NULL,
    "nombreExhibido" VARCHAR(200) NOT NULL,
    "precio" DECIMAL(12,2) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Colocacion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Cliente" (
    "id" BIGSERIAL NOT NULL,
    "nombre" VARCHAR(150) NOT NULL,
    "telefono" VARCHAR(30),
    "tipo" "public"."ClienteTipo" NOT NULL DEFAULT 'regular',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Cliente_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Compra" (
    "id" BIGSERIAL NOT NULL,
    "clienteId" BIGINT NOT NULL,
    "colocacionId" BIGINT NOT NULL,
    "unidades" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Compra_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Empleado" (
    "id" BIGSERIAL NOT NULL,
    "nombres" VARCHAR(120) NOT NULL,
    "apellidos" VARCHAR(120) NOT NULL,
    "cedula" VARCHAR(40) NOT NULL,
    "tipoSangre" VARCHAR(5),
    "telefono" VARCHAR(30),
    "email" VARCHAR(120),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Empleado_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Usuario" (
    "id" BIGSERIAL NOT NULL,
    "username" VARCHAR(60) NOT NULL,
    "passwordHash" VARCHAR(255) NOT NULL,
    "rol" "public"."UsuarioRol" NOT NULL DEFAULT 'vendedor',
    "empleadoId" BIGINT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Usuario_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Fabricante_nombre_key" ON "public"."Fabricante"("nombre");

-- CreateIndex
CREATE UNIQUE INDEX "Articulo_codigoBarras_key" ON "public"."Articulo"("codigoBarras");

-- CreateIndex
CREATE INDEX "Articulo_fabricanteId_idx" ON "public"."Articulo"("fabricanteId");

-- CreateIndex
CREATE UNIQUE INDEX "Ubicacion_nombre_key" ON "public"."Ubicacion"("nombre");

-- CreateIndex
CREATE INDEX "Colocacion_articuloId_idx" ON "public"."Colocacion"("articuloId");

-- CreateIndex
CREATE INDEX "Colocacion_ubicacionId_idx" ON "public"."Colocacion"("ubicacionId");

-- CreateIndex
CREATE UNIQUE INDEX "Colocacion_articuloId_ubicacionId_key" ON "public"."Colocacion"("articuloId", "ubicacionId");

-- CreateIndex
CREATE UNIQUE INDEX "Cliente_telefono_key" ON "public"."Cliente"("telefono");

-- CreateIndex
CREATE INDEX "Compra_clienteId_idx" ON "public"."Compra"("clienteId");

-- CreateIndex
CREATE INDEX "Compra_colocacionId_idx" ON "public"."Compra"("colocacionId");

-- CreateIndex
CREATE UNIQUE INDEX "Compra_clienteId_colocacionId_key" ON "public"."Compra"("clienteId", "colocacionId");

-- CreateIndex
CREATE UNIQUE INDEX "Empleado_cedula_key" ON "public"."Empleado"("cedula");

-- CreateIndex
CREATE UNIQUE INDEX "Empleado_email_key" ON "public"."Empleado"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Usuario_username_key" ON "public"."Usuario"("username");

-- CreateIndex
CREATE UNIQUE INDEX "Usuario_empleadoId_key" ON "public"."Usuario"("empleadoId");

-- AddForeignKey
ALTER TABLE "public"."Articulo" ADD CONSTRAINT "Articulo_fabricanteId_fkey" FOREIGN KEY ("fabricanteId") REFERENCES "public"."Fabricante"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Colocacion" ADD CONSTRAINT "Colocacion_articuloId_fkey" FOREIGN KEY ("articuloId") REFERENCES "public"."Articulo"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Colocacion" ADD CONSTRAINT "Colocacion_ubicacionId_fkey" FOREIGN KEY ("ubicacionId") REFERENCES "public"."Ubicacion"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Compra" ADD CONSTRAINT "Compra_clienteId_fkey" FOREIGN KEY ("clienteId") REFERENCES "public"."Cliente"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Compra" ADD CONSTRAINT "Compra_colocacionId_fkey" FOREIGN KEY ("colocacionId") REFERENCES "public"."Colocacion"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Usuario" ADD CONSTRAINT "Usuario_empleadoId_fkey" FOREIGN KEY ("empleadoId") REFERENCES "public"."Empleado"("id") ON DELETE SET NULL ON UPDATE CASCADE;
