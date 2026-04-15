# ruptur-lab

Estaleiro operacional inicial da Ruptur no GCP.

> Status atual: **fundação pronta para implementação segura, sem apply automático**.

## Objetivo

Este repositório concentra a fundação técnica do estaleiro:
- **Terraform** para cloud/infrastructure no GCP
- **Ansible** para host/runtime na VM principal
- **documentação viva** para arquitetura, contratos e handoffs
- **scripts locais** para bootstrap e validação estática

## Defaults travados da fase 1

- projeto GCP: `midyear-forest-493400-s3`
- região: `southamerica-east1`
- zona padrão: `southamerica-east1-b`
- VM principal: `n2-standard-4`
- disco: `250 GiB pd-ssd`
- sistema operacional: `Debian 11`
- borda/DNS: `Cloudflare`
- integração WhatsApp: `Uazapi externa -> n8n`
- runtime: `docker compose` em VM única
- Hermes: **fora da fase 1**, apenas preparado/reservado
- operador canônico disponível para ativação posterior: `J.A.R.V.I.S.` em `ops.ruptur.cloud`

> Observação operacional: o alvo inicial era N4, mas a execução real deste projeto em `southamerica-east1` precisou usar `n2-standard-4` porque a quota regional de N4 está em `0` no projeto atual.

## Estrutura

- `.devcontainer/` ambiente de abertura local
- `.github/` baseline operacional e validação em CI
- `infra/terraform/` infraestrutura GCP
- `infra/ansible/` configuração do host e serviços
- `docs/` arquitetura, contratos e runbook
- `bootstrap/` diretrizes de bootstrap seletivo e handoff do operador técnico
- `scripts/` wrappers de bootstrap e validação

## Princípios de operação

- `Terraform = cloud`, `Ansible = host/runtime`
- nenhuma credencial real entra no Git
- exemplos de segredos ficam fora de `group_vars` para evitar carga acidental pelo Ansible
- nenhum `apply` é implícito neste repo
- `Cloudflare` fica na borda, não no runtime interno
- `Uazapi` permanece externa nesta fase
- `Orion` é referência seletiva, nunca arquitetura inteira

## Começo rápido

```bash
make check-env
make validate
```

Para preparar o ambiente local/devcontainer com Ansible:

```bash
bash scripts/bootstrap-local.sh --best-effort
```

## Documentos que definem a fase 1

- `docs/architecture-phase1.md`
- `docs/operational-contract.md`
- `docs/bootstrap-runbook.md`
- `bootstrap/orion-bootstrap-policy.md`
- `bootstrap/claude-code-operator-brief.md`
- `docs/jarvis-operator-path.md`
