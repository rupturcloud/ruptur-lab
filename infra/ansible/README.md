# Ansible

Camada de configuração do host Debian e renderização do runtime em containers.

## Escopo da fase 1

- preparar host Debian 11
- instalar Docker Engine
- criar diretórios e redes do runtime
- renderizar compose/configuração para:
  - Traefik
  - Portainer
  - Postgres
  - Redis
  - n8n
  - MinIO

## Contrato operacional

- `site.yml` prepara o host inteiro
- `shipyard_compose_autostart` é `false` por padrão
- segredos reais entram por override local (`secrets.yml`) ou extra-vars externos
- Uazapi permanece fora da VM
