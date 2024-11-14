# src/make/clean-install-dockers.func.mk
# only the clean install dockers calls here ...
# TODO: figure a more elegant and generic way to avoid this copy paste ...
#

SHELL = bash
PROJ := $(shell basename $$PWD)
ORG := $(shell export ORG=$${ORG:-csi}; echo $${ORG})


APP_PORT=""


.PHONY: setup-user-group-automate  ## @-> setup the whole local devops environment no cache
setup-user-group-automate:
	$(call install-img,user-group-automate,--no-cache,${APP_PORT})
	

.PHONY: setup-user-group-automate-cached  ## @-> setup the whole local devops environment
setup-user-group-automate-cached:
	$(call install-img,user-group-automate,,${APP_PORT})
