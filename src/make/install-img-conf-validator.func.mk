# src/make/clean-install-dockers.func.mk
# Keep all (clean and regular) docker install functions in here.

.PHONY: setup-conf-validator  ## @-> setup the whole local conf-validator environment for python no cache
setup-conf-validator:
	$(call build-img,conf-validator,--no-cache,${TPL_GEN_PORT})
	make start-conf-validator

.PHONY: setup-conf-validator-cached  ## @-> setup the whole local conf-validator environment for python
setup-conf-validator-cached:
	$(call build-img,conf-validator,,${TPL_GEN_PORT})
	make start-conf-validator

.PHONY: build-conf-validator  ## @-> build the whole local conf-validator environment for python no cache
build-conf-validator:
	$(call build-img,conf-validator,--no-cache,${TPL_GEN_PORT})

.PHONY: start-conf-validator  ## @-> start the whole local conf-validator environment for python no cache
start-conf-validator:
	$(call start-img,conf-validator,--no-cache,${TPL_GEN_PORT})

.PHONY: stop-conf-validator
stop-conf-validator:
	CONTAINER_NAME=conf-validator
	$(call stop-and-remove-docker-container)
