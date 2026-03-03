variable "resource_group_name" {
  description = "Name of the resource group for AKS cluster"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be deployed"
  type        = string
  default     = "uaenorth"
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

# Default Node Pool Variables
variable "default_node_pool_name" {
  description = "Name of the default node pool"
  type        = string
  default     = "default"
}

variable "default_node_pool_node_count" {
  description = "Number of nodes in the default node pool"
  type        = number
  default     = 2
}

variable "default_node_pool_vm_size" {
  description = "VM size for the default node pool"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "default_node_pool_enable_auto_scaling" {
  description = "Enable auto-scaling for the default node pool"
  type        = bool
  default     = true
}

variable "default_node_pool_min_count" {
  description = "Minimum number of nodes when auto-scaling is enabled"
  type        = number
  default     = 1
  nullable    = true
}

variable "default_node_pool_max_count" {
  description = "Maximum number of nodes when auto-scaling is enabled"
  type        = number
  default     = 5
  nullable    = true
}

variable "default_node_pool_os_disk_size_gb" {
  description = "OS disk size in GB for default node pool"
  type        = number
  default     = 50
}

variable "default_node_pool_availability_zones" {
  description = "Availability zones for default node pool"
  type        = list(string)
  default     = ["1"]
}

# Additional Node Pools
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

# Network Profile
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

# Tags
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}
