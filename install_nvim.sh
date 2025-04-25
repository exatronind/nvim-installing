#!/bin/bash

set -e

DEB_FILE="nvim-linux-armv7l.deb"
PACKAGE_NAME="nvim"

# Verifica se o .deb está no mesmo diretório
if [ ! -f "$DEB_FILE" ]; then
    echo "Arquivo $DEB_FILE não encontrado no diretório atual."
    exit 1
fi

# Pega a versão do pacote .deb
DEB_VERSION=$(dpkg-deb -f "$DEB_FILE" Version)

# Verifica se o Neovim já está instalado e pega a versão
# Verifica se o Neovim já está instalado e pega a versão
if command -v nvim > /dev/null; then
    INSTALLED_VERSION=$(nvim --version | head -n 1 | sed -E 's/^NVIM v([0-9]+\.[0-9]+\.[0-9]+).*/\1/')
    echo "Neovim instalado: $INSTALLED_VERSION"
    echo "Neovim do pacote: $DEB_VERSION"

    if [ "$INSTALLED_VERSION" = "$DEB_VERSION" ]; then
        echo "✅ Já está na versão correta. Nenhuma ação necessária."
        exit 0
    else
        echo "Versão diferente detectada. Reinstalando Neovim..."
    fi
else
    echo "Neovim não está instalado. Instalando..."
fi

# Instala com dpkg
sudo dpkg -i "$DEB_FILE" || true
sudo apt-get install -f -y

echo "✅ Instalação concluída:"
nvim --version | head -n 1