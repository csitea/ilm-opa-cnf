# Infra (v2.0.0)

> :information_source: Provisioned by Terraform 1.2.2
>
> Organization: `csi` \
> Application:  `wpb` \
> Environment:  `dev`

---

Configuration Block
===
These configurations are going to be exported and used by the steps when provisioning infrastructure.
## DNS
| variable name | description | value |
| -: | :-: | :- |
|`tld_domain` | The Top Level DNS (TLD) domain. |ilmatarbrain.com |
|`aws_subdomain` | The subdomain registered in Route53 | aws |
|`fqn_aws_subdomain`| The Fully Qualified Name (FQN) | ilmatarbrain.com |
|`env_subdomain` | The OAE subdomain (private zone)| ilm.opadev |
|`fqn_env_subdomain`| The FQN environment subdomain| ilm.opadev.ilmatarbrain.com |
## Github
Organization repository: https://github.com/csitea

## AWS CLI
| variable name | description | value |
| -: | :-: | :- |
|`AWS_SHARED_CREDENTIALS_FILE` | The aws credentials file | ~/.aws/.str/credentials |
|`AWS_CONFIG_FILE` | The aws configuration file | ~/.aws/.str/config |
|`AWS_PROFILE` | The root account profile | rtr_adm |
|`AWS_REGION` | The aws default region | eu-west-1 |

STEPS
===


002-aws-accounts
---

| variable name | description | value |
| -: | :-: | :- |
|`AWS_SHARED_CREDENTIALS_FILE` | The credentials file used | ~/.aws/.str/credentials|
|`AWS_CONFIG_FILE` | The configuation file used| ~/.aws/.str/config |
|`AWS_PROFILE` | The account to provision resources | rtr_adm |
|`AWS_REGION` | The region to provision resources| eu-west-1 |
|`admin_email_user` | The user who will be registered| yordan.georgiev@ilmatarbrain.com |
|`aws_account_types` | The OAE accounts created | `idy`, `rcr`, `log`|


003-aws-scps
---

| variable name | description | value |
| -: | :-: | :- |
|`AWS_PROFILE` | The account to provision resources | rtr_adm |
|`AWS_REGION` | The region to provision resources | eu-west-1  |
|`idy_profile` | The `dev` identity account | str.mpp_dev_idy |
|`rcr_profile` | The `dev` resource account | str.mpp_dev_rcr |
|`log_profile` | The `dev` logging account | str.mpp_dev_log |
|`allowed_regions` | Regions in which resources are allowed | `eu-west-1`, `eu-central-1` |


004-aws-iam
---

| variable name  | description | value |
| -: | :-: | :- |
|`AWS_PROFILE` | The account to provision resources | rtr_adm |
|`AWS_REGION` | The region to provision resources | eu-west-1 |
|`all_idy_profile` | The `all` identity account | str.mpp_all_idy |
|`idy_profile` | The `dev` identity account | str.mpp_dev_idy |
|`rcr_profile` | The `dev` resource account | str.mpp_dev_rcr |
|`log_profile` | The `dev` logging account | str.mpp_dev_log |


The CICD user credentials are going to be synced to:
  - CICD UI
      - https://github.com/csitea/ilm-opa-deployer
      - https://github.com/csitea/csi-e2e-mon
      - https://github.com/csitea/se-wpb-mobile
      - https://github.com/csitea/se-wpb-web
  - CICD Backend
      - https://github.com/csitea/ilm-opa-deployer
      - https://github.com/csitea/csi-e2e-mon
      - https://github.com/csitea/se-wpb-mobile
      - https://github.com/csitea/se-backend-default


007-dns
---

| variable name | description | value |
| -: | :-: | :- |
|`AWS_PROFILE` | The account to provision resources | str.mpp_dev_rcr |
|`AWS_REGION` | The region to provision resources | eu-west-1 |
|`root_domain_profile` | The `AWS_PROFILE` that owns the `tld_domain` | str.mpp_all_rcr |
|`domain` | Any entires will be a subdomain of this zone | `ilm.opadev.ilmatarbrain.com` |
|`create_private_zone` | Either to create a private DNS zone | True |


008-ecr
---

| variable name | description | value |
| -: | :-: | :- |
|`AWS_PROFILE` | The account to provision resources | str.mpp_dev_rcr |
|`AWS_REGION` | The region to provision resources  | eu-west-1 |
|`ecr_name` | The default, general purpose, ECR  | ilm-opa-dev-ecr-general-purpose |

\
The following custom ECR's are going to be provisoned:

| ECR name | Force destroy | # untagged images |
| -: | :-: | :- |
| ilm-opa-dev-testing | `True` | 1 |


009-budgets
---

| variable name | description | value |
| -: | :-: |:-|
|`AWS_REGION` | The region to provision resources  | eu-west-1 |
| subscribers | The emails who will be notifies    |`renato.guimaraes@ilmatarbrain.com`,`yordan.georgiev@ilmatarbrain.com`|
| idy_account | The identity account profile       |str.mpp_dev_idy  |
| rcr_account | The resource account profile       |str.mpp_dev_rcr  |
| log_account | The logging account profile        |str.mpp_dev_log  |

> Budgets are active for the Identity account
>
> **Budget**: `USD 100 `
>
> Notifications are send `MONTHLY` \
> Condition: Budget `GREATER_THAN` threshold `USD 100` in `ABSOLUTE_VALUE` \
> Notification type: `FORECASTED`

> Budgets are active for the Logging account
>
> **Budget**: `USD 30 `
>
> Notifications are send `MONTHLY` \
> Condition: Budget `GREATER_THAN` threshold `USD 30` in `ABSOLUTE_VALUE` \
> Notification type: `FORECASTED`

> Budgets are active for the Resource account
>
> **Budget**: `USD 30 `
>
> **Periodicity**: `MONTHLY` \
> **Condition**: Budget `GREATER_THAN` threshold `USD 30` in `ABSOLUTE_VALUE` \
> **Notification type**: `FORECASTED`


020-rds
---

> The DB password is either passed through environment variables or randomly generated if empty.
> The master credentials are found in `str.mpp_dev_idy` and `str.mpp_all_idy` accounts in ASM as : `creds-postgres-iam_master`
> The microservice credentials created can also be found in `str.mpp_dev_rcr` account.

| variable name | description | value |
| -: | :-: |:-:|
|`AWS_PROFILE`                 | The account to provision resources                | str.mpp_dev_rcr |
|`AWS_REGION`                  | The region to provision resources                 | eu-west-1 |
|`idy_account`                 | The indentity profile to sync secrets in ASM      | str.mpp_dev_idy |
|`all_idy_account`             | The `all` identity profile to sync secrets in ASM |  |
|`env_subdomain`               | The private zone to provision `rds` internal DNS  | ilm.opadev |
|`vpc_name`                    | The name of the RDS VPC                           | vpc-rds-ilm-opa-dev |
|`db_instance_name`            | The name of the RDS Instance                      | postgres-ilm-opa-dev |
|`db_instance_class`           | The type of instance                              | db.t3.medium |
|`db_family`                   | DB family                                         | postgres14 |
|`db_name`                     | the default DB base                               | wpb |
|`db_username`                 | The master RDS user                               | postgres |
|`db_secret_name`              | The root name of the master credentials           | creds-postgres-iam_master |
|`db_secret_prefix`            | The prefix to store the miroservice dbs in ASM    |  |
|`db_secret_suffix`            | The suffix to store the miroservice dbs in ASM    |  |
|`ip_prefix`                   | The CIDR prefix (`/16`) of RDS VPC                | 10.30 |
|`db_port`                     | The port                                          | 5432 |
|`enable_nat_gateway`          | either to use a NAT gateway                       | True |
|`single_nat_gateway`          | either to use a single NAT gateway                | True |
|`skip_final_snapshot`         | either to skip final snapshot                     | True |
|`snapshot_identifier`         | the name of the snapshop to restore RDS from      |  |
|`final_snapshot_identifier`   | when destroyed create snapshop with this name     | postgres-ilm-opa-dev-20300000001 |

\
The following microservice secrets will be synced to `str.mpp_dev_idy`, `str.mpp_dev_rcr` and `str.mpp_all_idy` accounts.
  - rds_view_creds
  - rds_access_control_creds
  - rds_device_creds
  - rds_experiment_creds
  - rds_history_creds
  - rds_mlflow_creds
  - rds_model_registry_creds
  - rds_audit_trail_creds


030-eks
---

| variable name | description | value |
| -: | :-: |:-:|
|`AWS_PROFILE` | The account to provision resources | str.mpp_dev_rcr |
|`AWS_REGION` | The region to provision resources  | eu-west-1 |
|`env_subdomain`| The private zone to create `eks` DNS entry | ilm.opadev |
|`cluster_name` | The name of the EKS Cluster | eks-cluster-ilm-opa-dev |
|`vpc_name` | The name of the EKS VPC |  vpc-eks-ilm-opa-dev |
|`ip_prefix` | The CIDR prefix (`/16`) of RDS VPC |  10.31 |
| `alb_inline_policy` | The access policy for the ALB  |  `cnf/env/str.mpp/dev/030-eks/alb-worker-inline-policy.json` |
| `single_nat_gateway` | Either to use a single NAT gateway |  True |
| `deploy_dashboard` | Either to deploy `kubernetes-dashboard` helm chart |  True |
| `k8s_namespaces` | Kubernetes namespaces to create | `monitor`, `ilm-opa-dev-ns`, `apiv2-mlflow-train` |
| `cluster_endpoint_public_access_cidrs` | |type |



Workers
| variable name | description | value |
| -: | :-: |:-:|
| `capacity_type` | Either to use `SPOT` or `ON_DEMAND` instances | SPOT|
| `desired_size`| The desired size of workers | 8 |
| `max_size`| The maximum size of workers | 12 |
| `min_size`| The minimum size of workers | 5 |
| `instance_types` | The type of instances to spawn workers |type |

Redis instance is provisioned within EKS VPC

> :information_source: The redis can be accesses by `redis.ilm.opadev` endpoint.
> If more than one node is spawned, a round robin is configure for top-level DNS and each one is registered for `redis-#.ilm.opadev`.

| variable name | description | value |
| -: | :-: |:-:|
| `redis_cluster_name` | The name of the redis cluster | redis|
| `redis_num_cache_nodes` || 1|
| `redis_node_type` || cache.t3.small|
| `engine` ||redis|
| `engine_version` ||6.2|
| `redis_port` ||6379|
| `redis_parameter_group_name` ||default.redis6.x|


033-jenkins-x
---
The following repository will be/was created:
https://github.com/csitea/ilm-opa-dev-jx-gitops

> :warning: It is necessary, prior to provisioning JenkinsX, to create a bot user under the organization
> and issue a PAT for the bot, with the following privileges:
> https://github.com/settings/tokens/new?scopes=repo,read:user,read:org,user:email,admin:repo_hook,write:packages,read:packages,write:discussion,workflow


| variable name | description | value |
| -: | :-: |:-:|
|`AWS_PROFILE` | The account to provision resources | str.mpp_dev_rcr |
|`AWS_REGION` | The region to provision resources  | eu-west-1 |
| `log_account` | The logging account profile |  str.mpp_dev_log |
| `idy_account` | the identity account profile |  str.mpp_dev_idy |
| `jx_bot_username` | The JX bot username |  ilm-opa-dev-jx-bot |
| `cluster_name` | The EKS cluster name to install JX operator|  eks-cluster-ilm-opa-dev |
| `fqn_aws_subdomain` | Used to by ALB |  ilmatarbrain.com |
| `env_subdomain` |  Used to by ALB |  ilm.opadev |
| `tls_email` | |  sys+ilm-opa-dev-jx@ilmatarbrain.com |
| `enable_spot_instances` | Either to enable JX pods to run on SPOT instances |  True |


050-wireguard
---

| variable name | description | value |
| -: | :-: |:-:|
|`AWS_PROFILE` | The account to provision resources | str.mpp_dev_rcr |
|`AWS_REGION` | The region to provision resources  | eu-west-1 |
| `wg_instance_name` | The name of the wireguard EC2 instance |  ilm-opa-dev-wireguard-instance |
| `vpc_name` | The name of the wireguard VPC|  vpc-wireguard-ilm-opa-dev |
| `fqn_env_subdomain` | FQN environment subdomain to create external endpoint |  ilm.opadev.ilmatarbrain.com |
| `env_subdomain` | The private zone to create entry |  ilm.opadev |
| `ssh_key_name` | The name of the key to store in ASM and locally when provisioning |  050-wireguard-key-pair.pem |
| `ip_prefix` | The CIDR prefix (`/16`) of RDS VPC |  10.32 |
| `wg_server_net` | The wireguard VPN network range |  10.32.101.128/26 |
| `wg_server_port` | The wireguard publicly available `udp` port |  51820 |
| `wg_persistent_keepalive` | Delay for VPN keepalive signal |  25 |
| `wg_client_peers_public_keys` | The file where to find peers configuration |  dev/050-wireguard/peers.yaml |


The wireguard instance will store logs using the following configuration:

| variable name | description | value |
| -: | :-: |:-:|
| `log_account` | The logging account profile |  str.mpp_dev_log |
| `log_s3_name` | The name of the logging S3 in the `log` account|  ilm-opa-dev-logs |
| `log_rotation_cron_schedule` | A cron schedule to rotate logs|  0 * * * * |

### Wireguard tunnel configuration - Peers
[Documentation reference](https://github.com/pirate/wireguard-docs)






Send this configuration to:
### `yordan.georgiev+mac02@ilmatarbrain.com @ ilm-opa-dev vpn `
```
[Interface]
PrivateKey = <@user ::: replace your private key>
Address = 10.32.101.131/32
DNS = 10.32.0.2, 1.1.1.1, 1.0.0.1

[Peer]
PublicKey =
AllowedIPs = 10.30.0.0/16, 10.31.0.0/16, 10.32.0.0/16
Endpoint = wireguard.ilm.opadev.ilmatarbrain.com:51820
PersistentKeepalive = 5
```




051-splunk
---
| variable name | description | value |
| -: | :-: |:-:|
|`AWS_PROFILE` | The account to provision resources | str.mpp_dev_rcr |
|`AWS_REGION` | The region to provision resources  | eu-west-1 |
| `log_account` | The logging account profile |  str.mpp_dev_log |
| `log_s3_name` | The name of the s3 bucket to allow fetching logs|  ilm-opa-dev-logs |
| `dmz_vpc_name` | The DMZ VPC to spawn splunk instance |  vpc-wireguard-ilm-opa-dev |


060-location-service
---
| variable name | description | value |
| -: | :-: |:-:|
|`AWS_PROFILE` | The account to provision resources | str.mpp_dev_rcr |
|`AWS_REGION` | The region to provision resources  | eu-west-1 |
| `identity_account` | The identity account |   |


070-coupling
---
| variable name | description | value |
| -: | :-: |:-:|
|`AWS_PROFILE` | The account to provision resources | str.mpp_dev_rcr |
|`AWS_REGION` | The region to provision resources  | eu-west-1 |
| `identity_profile` | The identity account profile |  str.mpp_dev_idy |
| `rds` | Either to couple RDS VPC |  True |
| `rds_vpc_name` | The name of the VPC where RDS is located |  vpc-rds-ilm-opa-dev |
| `db_instance_identifier` | The name of the RDS instance |  postgres-ilm-opa-dev |
| `eks` | Either to couple EKS VPC |  True |
| `eks_vpc_name` | The name of the VPC where EKS is located |  vpc-eks-ilm-opa-dev |
| `cluster_name` | The name of the EKS cluster |  eks-cluster-ilm-opa-dev |
| `redis` | Either to couple redis VPC |  True |
| `redis_name` | The name of the redis instance |  redis |
| `redis_port` | The redis port to allow communication on WG security group |  6379 |
| `wg` | Either to couple Wireguard VPC |  True |
| `wg_vpc_name` | The name of the VPC where Wireguard is located |  vpc-wireguard-ilm-opa-dev |
| `wg_instance_name` | The name of the wireguard EC2 instance |  ilm-opa-dev-wireguard-instance |

The RDS master credentials are synced to the kubernetes namespace `kube-system`.

- Secret name: `rds`

The following secrets are going to be synced to the kubernetes namespace `kube-system`:
- `rds_view_creds`
- `rds_access_control_creds`
- `rds_device_creds`
- `rds_experiment_creds`
- `rds_history_creds`
- `rds_mlflow_creds`
- `rds_model_registry_creds`
- `rds_audit_trail_creds`

---
