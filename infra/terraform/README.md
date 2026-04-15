# Terraform

Camada de infraestrutura cloud do estaleiro.

## Escopo da fase 1

- usar projeto GCP já existente
- habilitar APIs mínimas
- criar rede dedicada
- criar IP estático
- criar service account de runtime
- criar VM principal do estaleiro
- criar a estrutura inicial do Secret Manager

## O que não acontece automaticamente aqui

- criação de billing account
- gestão de DNS/Cloudflare nesta fase
- apply implícito
- injeção de valores de segredo

## Arquivos importantes

- `backend.tf.example` — backend GCS preparado, mas não ativo por padrão
- `terraform.tfvars.example` — valores-base para a fase 1
- `modules/network` — VPC, subnet e firewall
- `modules/shipyard_vm` — IP estático e VM principal
- `modules/secret_manager` — containers de segredos
