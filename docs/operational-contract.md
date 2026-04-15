# Contrato Operacional da Fase 1

## Subdomínios

| Subdomínio | Estado na fase 1 | Destino | Observação |
| --- | --- | --- | --- |
| `ops.ruptur.cloud` | reservado | futuro painel operacional | não sobe agora |
| `api.ruptur.cloud` | reservado | futura API do estaleiro | não sobe agora |
| `hermes.ruptur.cloud` | reservado | Hermes | não sobe agora |
| `n8n.ruptur.cloud` | ativo | n8n via Traefik | primeiro receptor de webhook |
| `portainer.ruptur.cloud` | ativo | Portainer via Traefik | administração de containers |
| `traefik.ruptur.cloud` | ativo | dashboard Traefik | proteger com auth |

## Responsabilidades

| Interface/camada | Responsável | Papel |
| --- | --- | --- |
| Estratégia, GO/NOGO, aprovação crítica | Diego | autoridade final |
| Provisionamento e organização técnica inicial | Claude Code | engenheiro principal do estaleiro |
| Execução paralela delimitada | Codex | subtarefas específicas |
| Exploração browser/UI/investigação | Antigravity | apoio operacional |
| Orquestração determinística | n8n | webhooks, timers, retries, handoffs |
| Operação 24/7 posterior | Hermes | intake, cobrança, status, checklist |

## Segredos

### Fonte de verdade por estágio

- **Infisical**: gestão humana/equipe/ambientes
- **GCP Secret Manager**: execução/produção
- **Ansible**: consome segredos já materializados fora do Git, via `inventories/production/group_vars/secrets.yml`

### Contrato mínimo de segredos

- `shipyard-postgres-password`
- `shipyard-redis-password`
- `shipyard-n8n-db-password`
- `shipyard-n8n-encryption-key`
- `shipyard-minio-root-user`
- `shipyard-minio-root-password`
- `shipyard-traefik-dashboard-basicauth`
- `shipyard-portainer-admin-password-hash`
- `shipyard-uazapi-api-token`
- `shipyard-uazapi-webhook-secret`

## Fluxo inicial de eventos

```text
Uazapi externa
  -> webhook em n8n
  -> filtros anti-loop e normalização
  -> persistência em Postgres
  -> estado transitório/eventos em Redis
  -> handoff futuro para Hermes
```

## Regras de segurança operacional

- nenhuma credencial real em `.env` de produção versionado
- nenhum apply implícito
- dashboard Traefik e Portainer sempre atrás de auth
- `excludeMessages: ["wasSentByApi"]` é obrigatório na integração Uazapi
- a primeira emissão TLS deve acontecer com os registros críticos em **DNS only** apontando para a VM, para o desafio HTTP do Let's Encrypt funcionar sem ambiguidade
