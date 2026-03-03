variable "resource_group_name" {
  description = "Name of the resource group for AKS cluster"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be deployed"
  type        = string
}

variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for the AKS cluster"
  type        = string
  default     = "1.33.6"
}

variable "default_node_pool" {
  description = "Configuration for the default node pool"
  type = object({
    name                = string
    node_count          = number
    vm_size             = string
    enable_auto_scaling = bool
    min_count           = optional(number)
    max_count           = optional(number)
    os_disk_size_gb     = number
    availability_zones  = list(string)
  })
}

variable "additional_node_pools" {
  description = "Map of additional node pools to create"
  type = map(object({
    name                = string
    vm_size             = string
    node_count          = number
    enable_auto_scaling = bool
    min_count           = optional(number)
    max_count           = optional(number)
    os_disk_size_gb     = number
    availability_zones  = list(string)
  }))
  default = {}
}

variable "network_profile" {
  description = "Network profile configuration for AKS"
  type = object({
    network_plugin    = string
    network_policy    = string
    dns_service_ip    = string
    service_cidr      = string
    load_balancer_sku = string
  })
  default = {
    network_plugin    = "azure"
    network_policy    = "azure"
    dns_service_ip    = "10.0.0.10"
    service_cidr      = "10.0.0.0/16"
    load_balancer_sku = "standard"
  }
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
