#!/bin/bash

set -euo pipefail

# Função para instalar dependências
install_dependency() {
    if ! command -v "$1" &> /dev/null; then
        echo "Instalando $1..."
        sudo apt-get update
        sudo apt-get install -y "$1"
    fi
}

# Verificar e instalar dependências
echo "Verificando dependências..."
install_dependency curl
install_dependency jq

# Instalar GitHub CLI
if ! command -v gh &> /dev/null; then
    echo "Instalando GitHub CLI..."
    sudo apt-get install -y software-properties-common
    sudo add-apt-repository -y ppa:git-core/ppa
    sudo apt-get update
    sudo apt-get install -y gh
fi

# Verificar se já está logado no GitHub CLI
if ! gh auth status &> /dev/null; then
    echo "Configurando GitHub CLI..."
    gh auth login
else
    echo "Você já está autenticado no GitHub CLI."
fi

# Configurar Secrets no GitHub
echo "Configurando Secrets no GitHub..."
gh secret set DO_PAT -b"${DO_PAT:?DO_PAT is not set}"
gh secret set DO_SSH_KEY_FINGERPRINT -b"${DO_SSH_KEY_FINGERPRINT:?DO_SSH_KEY_FINGERPRINT is not set}"

# Verificar e instalar OpenTofu
if ! command -v tofu &> /dev/null; then
    echo "Instalando OpenTofu..."
    curl -Lo opentofu https://opentofu.org/install.sh
    chmod +x opentofu
    sudo mv opentofu /usr/local/bin/tofu
else
    echo "OpenTofu já está instalado."
fi

# Aplicar OpenTofu
echo "Inicializando OpenTofu..."
cd environments/dev || exit
TF_VAR_do_token="${DO_PAT}" tofu init
TF_VAR_do_token="${DO_PAT}" tofu apply -auto-approve -var-file=variables.tfvars