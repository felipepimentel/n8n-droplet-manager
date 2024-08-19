#!/bin/bash

# Verificar e instalar dependências
echo "Verificando dependências..."
if ! command -v curl &> /dev/null
then
    echo "Instalando curl..."
    sudo apt-get update
    sudo apt-get install -y curl
fi

if ! command -v jq &> /dev/null
then
    echo "Instalando jq..."
    sudo apt-get install -y jq
fi

if ! command -v gh &> /dev/null
then
    echo "Instalando GitHub CLI..."
    sudo apt-get install -y software-properties-common
    sudo add-apt-repository -y ppa:git-core/ppa
    sudo apt-get update
    sudo apt-get install -y gh
fi

# Verificar se já está logado no GitHub CLI
if ! gh auth status &> /dev/null
then
    echo "Configurando GitHub CLI..."
    gh auth login
else
    echo "Você já está autenticado no GitHub CLI."
fi

# Configurar Secrets no GitHub
echo "Configurando Secrets no GitHub..."
gh secret set DO_PAT -b"$DO_PAT"
gh secret set DO_SSH_KEY_FINGERPRINT -b"$DO_SSH_KEY_FINGERPRINT"


# Verificar e instalar OpenTofu
if ! command -v tofu &> /dev/null
then
    echo "Instalando OpenTofu..."
    curl -Lo opentofu https://opentofu.org/install.sh
    chmod +x opentofu
    sudo mv opentofu /usr/local/bin/tofu
else
    echo "OpenTofu já está instalado."
fi

# Aplicar OpenTofu
echo "Inicializando OpenTofu..."
cd environments/dev
TF_VAR_do_token="$DO_PAT" tofu init || { echo "Erro ao inicializar o OpenTofu"; exit 1; }
TF_VAR_do_token="$DO_PAT" tofu apply -auto-approve -var-file=variables.tfvars || { echo "Erro ao aplicar a configuração do OpenTofu"; exit 1; }

tofu init || { echo "Erro ao inicializar o OpenTofu"; exit 1; }
tofu apply -auto-approve -var-file=variables.tfvars || { echo "Erro ao aplicar a configuração do OpenTofu"; exit 1; }
