# Reserva de Horas Médicas – Proyecto DevOps Integrador

Servicio web estático para la reserva de horas médicas de una empresa del rubro salud (*Clínica Salud Integral*, ficticia). La página se sirve con **Nginx** dentro de un contenedor **Docker** y se levanta localmente con **Docker Compose** en el puerto **8080**.

> Proyecto académico. No contiene API, base de datos, credenciales reales ni datos personales.

## Estructura

```
reserva-horas-devops/
├── .github/workflows/devops-automation.yml   # Validación automática (complementaria)
├── src/
│   ├── index.html                            # Formulario de reserva, datos de atención y estado
│   └── styles.css                            # Hoja de estilos
├── .env.example                              # Plantilla de variables (valores ficticios)
├── .gitignore                                # Excluye .env, claves, logs, etc.
├── docker-compose.yml                        # Servicio "web" en el puerto 8080
├── Dockerfile                                # Imagen basada en nginx:alpine
└── README.md
```

## Requisitos

- Git y una cuenta de GitHub
- Docker Desktop instalado e iniciado
- Navegador web

## Instalación

```bash
git clone https://github.com/<su-usuario>/reserva-horas-devops.git
cd reserva-horas-devops
cp .env.example .env        # En Windows PowerShell: Copy-Item .env.example .env
```

El archivo `.env` es opcional: si no existe, se usan los valores por defecto (puerto 8080).

## Ejecución

```bash
docker compose up -d --build
```

## Verificación

```bash
docker compose ps                   # Estado del contenedor
docker ps                           # Contenedores en ejecución
curl http://localhost:8080          # O abrir la URL en el navegador
docker logs reserva-horas-web       # Logs de acceso de Nginx
docker stats --no-stream            # Uso de CPU y memoria
```

Abrir **http://localhost:8080** en el navegador. Debe verse el formulario de reserva, los datos de atención y el estado del servicio.

## Detención

```bash
docker compose down
```

## Buenas prácticas de seguridad

- El archivo `.env` real **nunca** se sube al repositorio (está en `.gitignore`); solo se publica `.env.example` con valores ficticios.
- No se publican tokens, contraseñas, claves ni certificados (`*.pem`, `*.key` también están excluidos).
- El formulario es una simulación: no almacena ni envía datos personales; los ejemplos usan datos ficticios.
- Antes de cada commit se revisa con `git status` y `git diff --staged` que no se incluyan archivos sensibles.
- El flujo de GitHub Actions verifica que no exista un archivo `.env` en el repositorio.
- Imagen base liviana y oficial (`nginx:alpine`) para reducir la superficie de ataque.

## Flujo de trabajo Git

1. Crear una rama de trabajo: `git checkout -b feature/formulario-reserva`
2. Commits pequeños y descriptivos (`feat:`, `fix:`, `docs:`).
3. `git push -u origin feature/formulario-reserva`
4. Abrir un Pull Request hacia `main`, revisar y fusionar.

## Automatización (complementaria)

El flujo `.github/workflows/devops-automation.yml` se ejecuta en cada *push* o *pull request* hacia `main`: verifica la estructura, comprueba que no se publique `.env`, valida `docker-compose.yml`, construye la imagen y prueba que el servicio responda.
