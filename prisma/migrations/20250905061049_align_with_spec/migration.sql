/*
  Warnings:

  - The values [vendedor] on the enum `UsuarioRol` will be removed. If these variants are still used in the database, this will fail.
  - Made the column `telefono` on table `Cliente` required. This step will fail if there are existing NULL values in that column.
  - Made the column `telefono` on table `Empleado` required. This step will fail if there are existing NULL values in that column.
  - Made the column `email` on table `Empleado` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "public"."UsuarioRol_new" AS ENUM ('admin', 'user');
ALTER TABLE "public"."Usuario" ALTER COLUMN "rol" DROP DEFAULT;
ALTER TABLE "public"."Usuario" ALTER COLUMN "rol" TYPE "public"."UsuarioRol_new" USING ("rol"::text::"public"."UsuarioRol_new");
ALTER TYPE "public"."UsuarioRol" RENAME TO "UsuarioRol_old";
ALTER TYPE "public"."UsuarioRol_new" RENAME TO "UsuarioRol";
DROP TYPE "public"."UsuarioRol_old";
ALTER TABLE "public"."Usuario" ALTER COLUMN "rol" SET DEFAULT 'user';
COMMIT;

-- AlterTable
ALTER TABLE "public"."Cliente" ALTER COLUMN "telefono" SET NOT NULL;

-- AlterTable
ALTER TABLE "public"."Empleado" ALTER COLUMN "telefono" SET NOT NULL,
ALTER COLUMN "email" SET NOT NULL;

-- AlterTable
ALTER TABLE "public"."Usuario" ALTER COLUMN "rol" SET DEFAULT 'user';
