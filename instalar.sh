#!/bin/bash
# Activa las actualizaciones de D&A Global OS en un equipo ya instalado.
set -euo pipefail
[ "$(id -u)" -eq 0 ] || { echo "Ejecútalo con sudo" >&2; exit 1; }
curl -fsSL https://DavidAPF.github.io/D-A-Global-OS/dya-global.asc | gpg --dearmor > /usr/share/keyrings/dya-global.gpg
cat > /etc/apt/sources.list.d/dya-global.sources <<FIN
Types: deb
URIs: https://DavidAPF.github.io/D-A-Global-OS
Suites: resolute
Components: main
Signed-By: /usr/share/keyrings/dya-global.gpg
FIN
apt-get update
# confnew: los archivos de D&A sustituyen a los copiados a mano antes
apt-get install -y -o Dpkg::Options::=--force-confnew dya-global-os
echo "Listo: este equipo ya recibe las actualizaciones de D&A Global OS."
