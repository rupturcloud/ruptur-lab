# Bootstrap Runbook

## Objetivo

Preparar o ambiente local e o repositório para execução segura, sem provisionar infraestrutura por engano.

## Passo 1 — validar ferramentas locais

```bash
make check-env
```

## Passo 2 — preparar toolchain opcional do Ansible

```bash
bash scripts/bootstrap-local.sh --best-effort
```

## Passo 3 — revisar contratos antes de preencher variáveis

1. `docs/architecture-phase1.md`
2. `docs/operational-contract.md`
3. `infra/terraform/terraform.tfvars.example`
4. `infra/ansible/inventories/production/group_vars/all.yml`
5. `infra/ansible/examples/production/secrets.example.yml`

## Passo 4 — preparar arquivos locais não versionados

```bash
cp infra/terraform/backend.tf.example infra/terraform/backend.tf
cp infra/terraform/terraform.tfvars.example infra/terraform/terraform.tfvars
cp infra/ansible/examples/production/secrets.example.yml \
  infra/ansible/inventories/production/group_vars/secrets.yml
```

> `backend.tf`, `terraform.tfvars` e `secrets.yml` ficam fora do Git.

> No Ansible desta fase, `secrets.yml` é carregado explicitamente pelo playbook; não depende de autoload implícito do `group_vars`.

## Passo 5 — rodar validações estáticas

```bash
make validate
```

### Validação completa do Terraform

Requer acesso de rede para baixar provider:

```bash
bash scripts/validate.sh --terraform-init
```

## O que este runbook não faz

- não cria recursos no GCP
- não aplica DNS no Cloudflare
- não sobe containers no host remoto
- não injeta segredos reais

## Observação de borda/TLS

- na primeira entrada pública, use `n8n.ruptur.cloud`, `portainer.ruptur.cloud` e `traefik.ruptur.cloud` em **DNS only**
- o Traefik desta fase usa `Let's Encrypt` via `httpChallenge` na porta `80`
- depois da emissão inicial do certificado, a política de proxy do Cloudflare pode ser revista
