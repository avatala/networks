# 3-networks/production

The purpose of this step is to set up base  shared VPCs  NAT , Private Service networking, server less vpc connector,  baseline firewall rules for environment production.

## Prerequisites

1. bootstrap executed successfully.
1. org executed successfully.
1. environments/envs/production executed successfully.
1. networks/envs/shared executed successfully.


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|

| domain | The DNS name of peering managed zone, for instance 'ideanomics.com.'. Must end with a period. | `string` | n/a | yes |
| enable\_hub\_and\_spoke | Enable Hub-and-Spoke architecture. | `bool` | `false` | no |
| enable\_hub\_and\_spoke\_transitivity | Enable transitivity via gateway VMs on Hub-and-Spoke architecture. | `bool` | `false` | no |
| folder\_prefix | Name prefix to use for folders created. Should be the same in all steps. | `string` | `"fldr"` | no |
| org\_id | Organization ID | `string` | n/a | yes |
| parent\_folder | It will place all the foundation resources under the provided folder instead of the root organization. The value is the numeric folder ID. The folder must already exist.| `string` | `""` | no |
| terraform\_service\_account | Service account email of the account to impersonate to run Terraform. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| base\_host\_project\_id | The base host project ID |
| base\_network\_name | The name of the VPC being created |
| base\_network\_self\_link | The URI of the VPC being created |
| base\_subnets\_ips | The IPs and CIDRs of the subnets being created |
| base\_subnets\_names | The names of the subnets being created |
| base\_subnets\_secondary\_ranges | The secondary ranges associated with these subnets |
| base\_subnets\_self\_links | The self-links of subnets being created |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
