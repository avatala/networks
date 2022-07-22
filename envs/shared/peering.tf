
data "google_compute_network" "vpc_base_net_prod" {
  #count   = var.mode == "spoke" ? 1 : 0
  name    = "vpc-p-shared-base"
  project = var.project_id
}

data "google_compute_network" "vpc_base_net_staging" {
  #count   = var.mode == "spoke" ? 1 : 0
  name    = "vpc-st-shared-base"
  project = var.project_id
}

data "google_compute_network" "vpc_base_net_dev" {
  #count   = var.mode == "spoke" ? 1 : 0
  name    = "vpc-d-shared-base"
  project = var.project_id
}



module "peering_shared_prod" {
  source                    = "terraform-google-modules/network/google//modules/network-peering"
  version                   = "~> 2.0"
 # count                     = var.mode == "spoke" ? 1 : 0
  prefix                    = "np"
  local_network             = module.base_env.base_network_self_link
  peer_network              = data.google_compute_network.vpc_base_net_prod.self_link
  export_peer_custom_routes = true
}

module "peering_shared_staging" {
  source                    = "terraform-google-modules/network/google//modules/network-peering"
  version                   = "~> 2.0"
  #count                     = var.mode == "spoke" ? 1 : 0
  prefix                    = "np"
  local_network             = module.base_env.base_network_self_link
  peer_network              = data.google_compute_network.vpc_base_net_staging.self_link
  export_peer_custom_routes = true
}

module "peering_shared_dev" {
  source                    = "terraform-google-modules/network/google//modules/network-peering"
  version                   = "~> 2.0"
  #count                     = var.mode == "spoke" ? 1 : 0
  prefix                    = "np"
  local_network             = module.base_env.base_network_self_link
  peer_network              = data.google_compute_network.vpc_base_net_dev.self_link
  export_peer_custom_routes = true
}