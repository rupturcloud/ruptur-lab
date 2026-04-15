# Política de Bootstrap do Orion

## Regra-mãe

O Orion entra **somente** como fonte seletiva de bootstrap. Ele não define a arquitetura inteira do estaleiro.

## Permitido nesta fase

- Traefik
- Portainer
- Postgres
- Redis
- n8n
- MinIO

## Fora nesta fase

- Dify
- Flowise
- Langflow
- AnythingLLM
- Supabase completo
- stacks redundantes de IA

## Critério de uso

Qualquer artefato trazido do Orion deve passar por três filtros:
1. aderência ao contrato da fase 1
2. ausência de dependências ocultas
3. compatibilidade com Terraform + Ansible + docker compose
