# J.A.R.V.I.S. no estaleiro

Este estaleiro já tem uma trilha concreta para ativar o operador canônico `J.A.R.V.I.S.` sem colidir com o core que já está vivo.

## Papel no estaleiro

- domínio público previsto: `ops.ruptur.cloud`
- repositório canônico atual: `https://github.com/tiatendeai/J.A.R.V.I.S.`
- governança canônica acoplada: `https://github.com/tiatendeai/state.git`
- função no runtime: operador do estaleiro, webhook UAZAPI, health/readiness/status e telemetria

## Como entra no runtime

O `ruptur-lab` agora prepara um role `jarvis` no Ansible que:

1. sincroniza o repositório do `J.A.R.V.I.S.` no host;
2. sincroniza o `state` em modo somente leitura para o container;
3. gera o `jarvis.env` operacional fora do Git;
4. renderiza `compose/jarvis.yml`;
5. sobe o serviço quando `shipyard_jarvis_enabled=true` e `shipyard_compose_autostart=true`.

## Contrato mínimo para subida

Antes de subir o operador, o arquivo local de segredos precisa preencher:

- `shipyard_jarvis_uazapi_admin_token`
- `shipyard_jarvis_uazapi_instance_token`
- `shipyard_jarvis_allowed_user_ids`
- chave do provider selecionado:
  - `shipyard_jarvis_gemini_api_key`, ou
  - `shipyard_jarvis_openrouter_api_key`, ou
  - `shipyard_jarvis_groq_api_key`, ou
  - `shipyard_jarvis_deepseek_api_key`

## Leitura operacional atual

- o host já tem folga real para acomodar esse serviço;
- o bloqueio principal do estaleiro continua sendo a borda pública no Cloudflare;
- o operador pode ser preparado agora e ativado assim que os segredos + DNS estiverem coerentes.
