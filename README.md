# ruptur-lab

Base local do estaleiro operacional da Ruptur.

## Estrutura
- `.devcontainer/` ambiente padrão de abertura local
- `infra/terraform/` infraestrutura cloud
- `infra/ansible/` configuração de host/runtime
- `docs/` documentação viva
- `scripts/` utilitários locais
- `bootstrap/` material de ativação/bootstrap do estaleiro

## Princípios
- devcontainer-first
- infra e docs separados
- automação por CLI/API/MCP quando possível
- GCP como fundação do estaleiro
