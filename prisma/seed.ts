import { PrismaClient, Prisma } from "@prisma/client";
const prisma = new PrismaClient();

async function main() {
  const acme = await prisma.fabricante.upsert({
    where: { nombre: "Acme" },
    update: {},
    create: { nombre: "Acme" },
  });

  const art = await prisma.articulo.upsert({
    where: { codigoBarras: "ABC123" },
    update: { stock: 10 },
    create: {
      codigoBarras: "ABC123",
      descripcion: "Widget",
      stock: 10,
      fabricanteId: acme.id,
    },
  });

  const ubic = await prisma.ubicacion.upsert({
    where: { nombre: "Góndola A" },
    update: {},
    create: { nombre: "Góndola A" },
  });

  const col = await prisma.colocacion.upsert({
    where: { articuloId_ubicacionId: { articuloId: art.id, ubicacionId: ubic.id } },
    update: {},
    create: {
      articuloId: art.id,
      ubicacionId: ubic.id,
      nombreExhibido: "Widget Pro",
      precio: new Prisma.Decimal(199.99),
    },
  });

  await prisma.cliente.upsert({
    where: { telefono: "809-000-0000" },
    update: {},
    create: { nombre: "Juan Pérez", telefono: "809-000-0000", tipo: "vip" },
  });

  console.log({ acme, art, ubic, col });
}

main()
  .then(async () => await prisma.$disconnect())
  .catch(async (e) => {
    console.error(e);
    await prisma.$disconnect();
    process.exit(1);
  });
