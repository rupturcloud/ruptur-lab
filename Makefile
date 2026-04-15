SHELL := /bin/bash

.PHONY: check-env bootstrap-local validate terraform-fmt-check terraform-validate ansible-syntax ansible-lint

check-env:
	bash scripts/check-env.sh

bootstrap-local:
	bash scripts/bootstrap-local.sh

validate:
	bash scripts/validate.sh

terraform-fmt-check:
	cd infra/terraform && terraform fmt -check -recursive

terraform-validate:
	cd infra/terraform && terraform init -backend=false && terraform validate

ansible-syntax:
	cd infra/ansible && ansible-playbook --syntax-check playbooks/site.yml

ansible-lint:
	cd infra/ansible && ansible-lint playbooks/site.yml
