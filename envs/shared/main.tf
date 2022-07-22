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
  env              = "shared"
  environment_code = substr(local.env, 0, 2)
  default_region1  = "us-central1"
  #default_region2  = "us-east1"
  
  /*
   * Base network ranges
   */
#   base_private_service_cidr = "10.42.0.0/24"
  base_subnet_primary_ranges = {
    (local.default_region1) = "10.100.0.0/22"
    #(local.default_region2) = "10.2.0.0/16"
    
  }
#   base_subnet_secondary_ranges = {
#     (local.default_region1) = [
        
#        {
#          range_name    = "sb-${module.base_env.base_network_name}-${local.default_region1}-gke-pod"
#          ip_cidr_range = "10.33.0.0/22"
#        },
#       {
#         range_name    = "sb-${module.base_env.base_network_name}-${local.default_region1}-gke-svc"
#         ip_cidr_range = "10.32.0.0/22"
#       }
#     ]
#     (local.default_region2) = [
#         {
#          range_name    = "sb-${module.base_env.base_network_name}-${local.default_region2}-gke-pod"
#          ip_cidr_range = "10.33.0.0/22"
#        },
#       {
#         range_name    = "sb-${module.base_env.base_network_name}-${local.default_region2}-gke-svc"
#         ip_cidr_range = "10.32.0.0/22"
#       }
#     ]
    
#   }
}

module "base_env" {
  source = "../../modules/base_env_shared"

  env                                = local.env
  environment_code                   = local.environment_code
  project_id                         = var.project_id
  org_id                             = var.org_id
  terraform_service_account          = var.terraform_service_account
  default_region1                    = local.default_region1
  #default_region2                    = local.default_region2
  domain                             = var.domain
  parent_folder                      = var.parent_folder
  enable_hub_and_spoke               = var.enable_hub_and_spoke
  enable_partner_interconnect        = false
  enable_hub_and_spoke_transitivity  = var.enable_hub_and_spoke_transitivity
#   base_private_service_cidr          = local.base_private_service_cidr
  base_subnet_primary_ranges         = local.base_subnet_primary_ranges
#   base_subnet_secondary_ranges       = local.base_subnet_secondary_ranges
  
}



/********************************************
 Extra subnet on us-east1 for shared project
**********************************************/

# resource "google_compute_subnetwork" "shared_service_subnet" {
#   #provider = google-beta

#   name          = "sb-${module.base_env.base_network_name}-us-east1"
#   ip_cidr_range = "10.30.0.0/16"
#   region        = "us-east1"
#   project       = var.project_id 
#   network       = module.base_env.base_network_name
# }





