#!/usr/bin/env bash
set -euo pipefail

RUN_TERRAFORM_INIT=false
if [[ "${1:-}" == "--terraform-init" ]]; then
  RUN_TERRAFORM_INIT=true
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TERRAFORM_DIR="$ROOT_DIR/infra/terraform"
ANSIBLE_DIR="$ROOT_DIR/infra/ansible"

printf '[ruptur-lab] validação estática iniciada
'
bash "$ROOT_DIR/scripts/check-env.sh"

if command -v terraform >/dev/null 2>&1; then
  printf '
[terraform] fmt -check
'
  terraform -chdir="$TERRAFORM_DIR" fmt -check -recursive

  if [[ "$RUN_TERRAFORM_INIT" == true ]]; then
    printf '
[terraform] init -backend=false
'
    terraform -chdir="$TERRAFORM_DIR" init -backend=false
    printf '
[terraform] validate
'
    terraform -chdir="$TERRAFORM_DIR" validate
  else
    printf '
[terraform] validate -> pulado (use --terraform-init para baixar providers)
'
  fi
else
  printf '
[terraform] pulado -> terraform não encontrado
'
fi

ANSIBLE_PLAYBOOK="ansible-playbook"
ANSIBLE_LINT="ansible-lint"
if [[ -x "$ROOT_DIR/.venv-ansible/bin/ansible-playbook" ]]; then
  ANSIBLE_PLAYBOOK="$ROOT_DIR/.venv-ansible/bin/ansible-playbook"
fi
if [[ -x "$ROOT_DIR/.venv-ansible/bin/ansible-lint" ]]; then
  ANSIBLE_LINT="$ROOT_DIR/.venv-ansible/bin/ansible-lint"
fi

if command -v "$ANSIBLE_PLAYBOOK" >/dev/null 2>&1; then
  printf '
[ansible] syntax-check
'
  (cd "$ANSIBLE_DIR" && "$ANSIBLE_PLAYBOOK" --syntax-check playbooks/site.yml)
else
  printf '
[ansible] syntax-check -> pulado (ansible não encontrado)
'
fi

if command -v "$ANSIBLE_LINT" >/dev/null 2>&1; then
  printf '
[ansible] lint
'
  (cd "$ANSIBLE_DIR" && "$ANSIBLE_LINT" playbooks/site.yml)
else
  printf '
[ansible] lint -> pulado (ansible-lint não encontrado)
'
fi

printf '
[ruptur-lab] validação estática concluída
'
