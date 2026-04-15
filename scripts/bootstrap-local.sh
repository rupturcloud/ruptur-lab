#!/usr/bin/env bash
set -euo pipefail

BEST_EFFORT=false
if [[ "${1:-}" == "--best-effort" ]]; then
  BEST_EFFORT=true
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VENV_DIR="$ROOT_DIR/.venv-ansible"
REQ_FILE="$ROOT_DIR/infra/ansible/requirements.txt"
COLLECTIONS_FILE="$ROOT_DIR/infra/ansible/collections/requirements.yml"

run_step() {
  if "$@"; then
    return 0
  fi

  if [[ "$BEST_EFFORT" == true ]]; then
    printf '[warn] etapa falhou em modo best-effort: %s
' "$*"
    return 0
  fi

  return 1
}

printf '[ruptur-lab] preparando toolchain local em %s
' "$VENV_DIR"
run_step python3 -m venv "$VENV_DIR"
run_step "$VENV_DIR/bin/python" -m pip install --upgrade pip setuptools wheel
run_step "$VENV_DIR/bin/pip" install -r "$REQ_FILE"
run_step "$VENV_DIR/bin/ansible-galaxy" collection install -r "$COLLECTIONS_FILE"

printf '[ruptur-lab] pronto. Use: source %s/bin/activate
' "$VENV_DIR"
