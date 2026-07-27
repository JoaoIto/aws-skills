#!/bin/bash
# =============================================================================
# setup-directories.sh
# =============================================================================
# Script para criar a estrutura de diretórios do curso AWS Technical Essentials.
# Executar a partir da pasta aws-essentials/:
#   ./setup-directories.sh
# =============================================================================

set -e

echo "🚀 Criando estrutura de diretórios do AWS Technical Essentials..."

# Diretório base (aws-essentials)
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$BASE_DIR"

# Lista de módulos
MODULES=(
  "module-01-introduction-to-aws"
  "module-02-aws-compute"
  "module-03-aws-networking"
  "module-04-aws-storage"
  "module-05-databases"
  "module-06-monitoring-optimization-and-serverless"
  "module-07-course-summary"
)

# Criar diretórios de módulos
for module in "${MODULES[@]}"; do
  if [ ! -d "$module" ]; then
    mkdir -p "$module"
    echo "  ✅ Criado: $module/"
  else
    echo "  ⏭️  Existe: $module/"
  fi
done

# Criar diretório de assets
if [ ! -d "assets" ]; then
  mkdir -p "assets"
  echo "  ✅ Criado: assets/"
else
  echo "  ⏭️  Existe: assets/"
fi

echo ""
echo "✅ Estrutura de diretórios criada com sucesso!"
echo ""
echo "Estrutura:"
echo "  aws-essentials/"
echo "  ├── README.md"
echo "  ├── setup-directories.sh"
echo "  ├── assets/"
echo "  ├── module-01-introduction-to-aws/"
echo "  ├── module-02-aws-compute/"
echo "  ├── module-03-aws-networking/"
echo "  ├── module-04-aws-storage/"
echo "  ├── module-05-databases/"
echo "  ├── module-06-monitoring-optimization-and-serverless/"
echo "  └── module-07-course-summary/"
