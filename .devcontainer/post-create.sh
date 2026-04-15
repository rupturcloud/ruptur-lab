#!/usr/bin/env bash
set -euo pipefail

printf '
[ruptur-lab] devcontainer pronto.
'
printf '[ruptur-lab] bootstrap local em modo best-effort...
'

if [[ -x scripts/bootstrap-local.sh ]]; then
  bash scripts/bootstrap-local.sh --best-effort
fi

printf '[ruptur-lab] próximos passos: make check-env && make validate
'
