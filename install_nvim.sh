#!/bin/bash

set -e

#Adicionada a instalacao do Node
echo "Baixando e instalando o NVM (Node Version Manager)..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

echo "Carregando NVM no shell atual..."
export NVM_DIR="$HOME/.nvm"
# shellcheck disable=SC1090
. "$NVM_DIR/nvm.sh"

echo "Instalando Node.js v22..."
nvm install 22

echo "Verificando versões instaladas:"
echo -n "Node.js: "; node -v
echo -n "NVM atual: "; nvm current
echo -n "npm: "; npm -v
#Fim da instalacao do Node

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
