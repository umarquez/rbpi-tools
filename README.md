# Raspberry Pi Tools (rbpi-tools)

Colección de scripts y *Makefile* para configurar rápidamente una Raspberry Pi (Bookworm, ARM64) como estación de desarrollo multimedia.

## Características

* Instalación automatizada de:
  * Dependencias de compilación comunes (build-essential, cmake, git-delta…).
  * [Fastfetch](https://github.com/fastfetch-cli/fastfetch) – System info CLI.
  * [Go](https://go.dev/) con versión y arquitectura parametrizables.
  * [Sonic Pi](https://sonic-pi.net/) 4.5.1.
  * [Starship](https://starship.rs/) prompt + integración con `~/.bashrc` o `~/.zshrc`.
* Scripts idempotentes y portables – `set -euo pipefail`, clonado *shallow*, limpieza tras compilación.
* Lint (`make lint`) con **shellcheck** y **shfmt**.
* Tests (`make test`) basados en **Bats**.
* Flujo CI listo para GitHub Actions.

## Requisitos

* Raspberry Pi con Raspberry Pi OS Bookworm 64-bit.
* Usuario con permisos `sudo` sin contraseña.
* Acceso a internet.

## Instalación rápida

```bash
# Clonar el repo
$ git clone https://github.com/tu-usuario/rbpi-tools.git
$ cd rbpi-tools

# Ejecutar instalación completa
$ make setup
```

> **Nota:** `make setup` puede tardar varios minutos — compila *Fastfetch* desde el código fuente.

### Instalar componentes individuales

```bash
# Solo dependencias base
make deps

# Solo Starship
make starship
```

## Uso

Una vez completado `make setup`, abre una nueva terminal o ejecuta:

```bash
source ~/.bashrc   # o ~/.zshrc
```

Deberías ver Fastfetch y el prompt de Starship al iniciar sesión.

## Desarrollo

* Lint: `make lint`
* Tests: `make test`
* Limpiar artefactos: `make clean`

Instala *pre-commit* hooks:

```bash
pip install pre-commit
pre-commit install
```

## Contribuir

Se aceptan PRs con nuevas utilidades o mejoras. Por favor, abre un *issue* antes para discutir cambios mayores.

## Licencia

Este proyecto se distribuye bajo la licencia **MIT**. Consulta el archivo `LICENSE` para más información.
