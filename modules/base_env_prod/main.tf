/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */



locals {

  mode                      = var.enable_hub_and_spoke ? "spoke" : null
  bgp_asn_number            = var.enable_partner_interconnect ? "16550" : "64514"
  enable_transitivity       = var.enable_hub_and_spoke && var.enable_hub_and_spoke_transitivity
  
}



/******************************************
 Base shared VPC
*****************************************/

module "base_shared_vpc" {
  source               = "../base_shared_vpc_prod"
  project_id           = var.project_id ##host project ID
  environment_code     = var.environment_code
  private_service_cidr = var.base_private_service_cidr
  org_id               = var.org_id
  parent_folder        = var.parent_folder
  default_region1      = var.default_region1
 #default_region2      = var.default_region2
  domain               = var.domain
  bgp_asn_subnet       = local.bgp_asn_number
  mode                 = local.mode

  subnets = [
    {
      subnet_name           = "sb-${module.base_shared_vpc.network_name}-${var.default_region1}"
      subnet_ip             = var.base_subnet_primary_ranges[var.default_region1]
      subnet_region         = var.default_region1
      subnet_private_access = "true"
      subnet_flow_logs      = true
      description           = "First ${var.env} subnet."
    },
    # {
    #   subnet_name           = "sb-${module.base_shared_vpc.network_name}-${var.default_region2}"
    #   subnet_ip             = var.base_subnet_primary_ranges[var.default_region2]
    #   subnet_region         = var.default_region2
    #   subnet_private_access = "true"
    #   subnet_flow_logs      = true
    #   description           = "First ${var.env} subnet."
    # }
   
  ]
  secondary_ranges = {
    "sb-${module.base_shared_vpc.network_name}-${var.default_region1}" = var.base_subnet_secondary_ranges[var.default_region1],
   # "sb-${module.base_shared_vpc.network_name}-${var.default_region2}" = var.base_subnet_secondary_ranges[var.default_region2]

  }
  
}
