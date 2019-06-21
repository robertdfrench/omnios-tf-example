SHELL=bash
all: apply;

which=$(shell which $1 || echo ".error.$1")
.error.%:
	$(error $*)

terraform=$(call which, terraform)
jq=$(call which, jq)

apply: $(terraform) $(jq) init
	$(terraform) apply

init: .terraform/plugins/initialized

.terraform/plugins/initialized: $(terraform) providers.tf
	$(terraform) init
	@touch $@
