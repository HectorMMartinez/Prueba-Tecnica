import { buildApp } from "./app";
import { ENV } from "./config/env";

const app = buildApp();

app.listen(ENV.PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${ENV.PORT}`);
});
