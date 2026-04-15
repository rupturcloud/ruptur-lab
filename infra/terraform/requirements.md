# Requisitos de execução

Este diretório não faz `apply` por conta própria.

Antes do primeiro `terraform apply`:
- preencher `terraform.tfvars`
- criar `backend.tf` a partir de `backend.tf.example`
- confirmar ranges de SSH
- confirmar chave pública de acesso à VM
- confirmar se o runtime deve usar apenas IP público estático ou outro desenho de acesso
