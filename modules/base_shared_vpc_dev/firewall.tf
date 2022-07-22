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

/******************************************
  Mandatory firewall rules
 *****************************************/

resource "google_compute_firewall" "allow_private_api_egress" {
  name      = "fw-${local.network_name}-65534-e-a-allow-google-apis-all-tcp-443"
  network   = module.main.network_name
  project   = var.project_id
  direction = "EGRESS"
  priority  = 65534

  dynamic "log_config" {
    for_each = var.firewall_enable_logging == true ? [{
      metadata = "INCLUDE_ALL_METADATA"
    }] : []

    content {
      metadata = log_config.value.metadata
    }
  }

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  destination_ranges = [local.private_googleapis_cidr]

  target_tags = ["allow-google-apis"]
}

resource "google_compute_firewall" "allow-iap-ssh-rdp" {
  name      = "fw-${local.network_name}-1000-i-allow-iap-ssh-rdp"
  network   = module.main.network_name
  project   = var.project_id
  direction = "INGRESS"
  priority  = 1000
  dynamic "log_config" {
    for_each = var.firewall_enable_logging == true ? [{
      metadata = "INCLUDE_ALL_METADATA"
    }] : []

    content {
      metadata = log_config.value.metadata
    }
  }
  allow {
    protocol = "icmp" 
  }

  allow {
    protocol = "tcp"
    ports    = ["3389", "22"]
  }
  source_ranges = ["35.235.240.0/20"]
  
}


# resource "google_compute_firewall" "allow_all_egress" {
#   count     = var.allow_all_egress_ranges != null ? 1 : 0
#   name      = "fw-${var.environment_code}-shared-base-1000-e-a-all"
#   network   = module.main.network_name
#   project   = var.project_id
#   direction = "EGRESS"
#   priority  = 1000

#   dynamic "log_config" {
#     for_each = var.firewall_enable_logging == true ? [{
#       metadata = "INCLUDE_ALL_METADATA"
#     }] : []

#     content {
#       metadata = log_config.value.metadata
#     }
#   }

#   allow {
#     protocol = "all"
#   }

#   destination_ranges = var.allow_all_egress_ranges
# }

# resource "google_compute_firewall" "allow_all_ingress" {
#   count     = var.allow_all_ingress_ranges != null ? 1 : 0
#   name      = "fw-${var.environment_code}-shared-base-1000-i-a-all"
#   network   = module.main.network_name
#   project   = var.project_id
#   direction = "INGRESS"
#   priority  = 1000

#   dynamic "log_config" {
#     for_each = var.firewall_enable_logging == true ? [{
#       metadata = "INCLUDE_ALL_METADATA"
#     }] : []

#     content {
#       metadata = log_config.value.metadata
#     }
#   }

#   allow {
#     protocol = "all"
#   }

#   source_ranges = var.allow_all_ingress_ranges
# }

/*resource "google_compute_firewall" "deny_all_egress" {
  name      = "fw-${var.environment_code}-shared-base-65535-e-d-all-all-all"
  network   = module.main.network_name
  project   = var.project_id
  direction = "EGRESS"
  priority  = 65535

  dynamic "log_config" {
    for_each = var.firewall_enable_logging == true ? [{
      metadata = "INCLUDE_ALL_METADATA"
    }] : []

    content {
      metadata = log_config.value.metadata
    }
  }

  deny {
    protocol = "all"
  }

  destination_ranges = ["0.0.0.0/0"]
}*/
