# Arquitetura da Fase 1

## Objetivo

Subir a fundação do estaleiro da Ruptur em uma VM única no GCP, com separação rígida entre provisão cloud e configuração do host.

## Desenho alvo

```text
Cloudflare (DNS + borda)
  ├── ops.ruptur.cloud         [reservado]
  ├── api.ruptur.cloud         [reservado]
  ├── hermes.ruptur.cloud      [reservado]
  ├── n8n.ruptur.cloud         -> Traefik -> n8n
  ├── portainer.ruptur.cloud   -> Traefik -> Portainer
  └── traefik.ruptur.cloud     -> Traefik dashboard

GCP / southamerica-east1
  └── VM única (Debian 11 / n2-standard-4 / 250 GiB pd-ssd)
      ├── Docker Engine
      ├── Traefik
      ├── Portainer
      ├── Postgres
      ├── Redis
      ├── n8n
      └── MinIO

Externo
  └── Uazapi (fora da VM) -> webhook -> n8n
```

## Observação operacional

O baseline efetivamente aplicado neste projeto ficou em `n2-standard-4` com `pd-ssd`, porque a quota regional de N4 em `southamerica-east1` está zerada para o projeto atual. A topologia e os contratos da fase 1 permanecem os mesmos.

## Fronteiras obrigatórias

- **Terraform** cria e descreve recursos do GCP.
- **Ansible** configura o host Debian e o runtime em containers.
- **Cloudflare** continua fora do runtime; nesta fase ele é só borda/DNS.
- **Uazapi** continua externa; o estaleiro consome, não hospeda.

## Serviços que entram agora

- Traefik
- Portainer
- Postgres
- Redis
- n8n
- MinIO

## Serviços explicitamente fora

- Hermes ativo
- Supabase completo
- Dify / Flowise / Langflow / AnythingLLM
- observabilidade pesada (Prometheus/Grafana/Loki)
- HA / multi-VM

## Estratégia de execução

1. preparar o repo e os contratos
2. validar estrutura localmente/CI
3. preencher variáveis e segredos fora do Git
4. aplicar Terraform
5. usar outputs do Terraform para alimentar o inventory do Ansible
6. configurar host e renderizar os serviços
7. só depois ligar runtime público
