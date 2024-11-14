# wpb-infra-conf

```bash
ORG=ilm APP=opa ENV=$env make do-generate-conf-for-004-aws-iam
while read -r step ; do echo $step ; 

    echo ORG=ilm APP=opa ENV=$env make do-generate-conf-for-$step

done < <(ls -1 /opt/str/infra/src/terraform/|grep -v bucket|sort|grep -v modules)
for env in `echo dev tst prd`; do ORG=ilm APP=opa ENV=$env make do-generate-conf-for-004-aws-iam ; done ;
```


## GENERATE CONF FOR STEP

```bash
# run from the infra-conf project
export STEP=121-bas-gcp-wpb-vm; ORG=ilm APP=opa ENV=dev TPL_SRC=/opt/str/ilm-opa-infra-app/ SRC=/opt/str/ilm-opa-infra-conf TGT=/opt/str/ilm-opa-infra-app/ make do-generate-conf-for-step


while read -r step ; do echo ORG=ilm APP=opa ENV=dev STEP=$step make -C ../ilm-opa-utl do-generate-config-for-step; done < <(ls -1 ../ilm-opa-inf/src/terraform|grep -v modules|sort)

```
# ilm-opa-cnf
