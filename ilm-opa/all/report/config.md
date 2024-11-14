# Infra (v1.7.5)

> :information_source: Provisioned by Terraform 1.2.2
>
> Organization: `csi` \
> Application:  `sms` \
> Environment:  `all`

---

Configuration Block
===
These configurations are going to be exported and used by the steps when provisioning infrastructure.
## DNS
| variable name | description | value |
| -: | :-: | :- |
|`tld_domain` | The Top Level DNS (TLD) domain. |ilmatarbrain.com |
|`aws_subdomain` | The subdomain registered in Route53 |  |
|`fqn_aws_subdomain`| The Fully Qualified Name (FQN) | ilmatarbrain.com |
|`env_subdomain` | The OAE subdomain (private zone)| csi.sms.all |
|`fqn_env_subdomain`| The FQN environment subdomain| csi.sms.all.ilmatarbrain.com |
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
|`idy_profile` | The `all` identity account | csi_sms_all_idy |
|`rcr_profile` | The `all` resource account | csi_sms_all_rcr |
|`log_profile` | The `all` logging account | csi_sms_all_log |
|`allowed_regions` | Regions in which resources are allowed | `eu-west-1`, `us-east-1` |

006-individual-users
---


The following individual users are provisioned along with membership to groups:


```
- {
  username: uliana.burdina@ilmatarbrain.com,
  groups: [
    csi_sms_dev_developers,
    csi_sms_dev_data_scientists,
  ]
}
- {
  username: jukka.pippuri@ilmatarbrain.com,
  groups: [
    csi_sms_dev_developers,
    csi_sms_tst_developers,
  ]
}
- {
  username: yordan.georgiev@ilmatarbrain.com,
  groups: [
    csi_sms_dev_developers,
    csi_sms_tst_developers,
    csi_sms_prd_developers,
  ]
}
```


008-ecr
---

| variable name | description | value |
| -: | :-: | :- |
|`AWS_PROFILE` | The account to provision resources | csi_sms_all_rcr |
|`AWS_REGION` | The region to provision resources  | eu-west-1 |
|`ecr_name` | The default, general purpose, ECR  | csi-sms-all-ecr-general-purpose |

\

---


[//]: # (Template for adding more steps)
<!--
000-step
---
| variable name | description | value |
| -: | :-: |:-:|
|`AWS_PROFILE` | The account to provision resources | {{ steps["000"]["AWS_PROFILE"] }} |
|`AWS_REGION` | The region to provision resources  | {{ steps["000"]["AWS_REGION"] }} |
| `000` | |  {{ steps["000"]["000"] }} |
| `000` | |  {{ steps["000"]["000"] }} |
-->
