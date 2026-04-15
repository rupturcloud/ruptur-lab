#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

check_bin() {
  local name="$1"
  if command -v "$name" >/dev/null 2>&1; then
    printf '[ok] %s -> %s
' "$name" "$(command -v "$name")"
  else
    printf '[miss] %s -> não encontrado
' "$name"
  fi
}

printf '[ruptur-lab] raiz: %s
' "$ROOT_DIR"
check_bin git
check_bin ssh
check_bin terraform
check_bin gcloud
check_bin python3
check_bin node
check_bin docker

if [[ -x "$ROOT_DIR/.venv-ansible/bin/ansible" ]]; then
  printf '[ok] ansible -> %s
' "$ROOT_DIR/.venv-ansible/bin/ansible"
else
  check_bin ansible
fi

if [[ -x "$ROOT_DIR/.venv-ansible/bin/ansible-lint" ]]; then
  printf '[ok] ansible-lint -> %s
' "$ROOT_DIR/.venv-ansible/bin/ansible-lint"
else
  check_bin ansible-lint
fi

if [[ -x "$ROOT_DIR/.venv-ansible/bin/ansible" ]]; then
  printf '[ok] .venv-ansible -> disponível
'
else
  printf '[info] .venv-ansible -> ainda não preparada
'
fi
