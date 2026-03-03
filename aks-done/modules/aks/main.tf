# Resource Group
resource "azurerm_resource_group" "aks" {
  name     = var.resource_group_name
  location = var.location

  tags = var.tags
}

# AKS Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name                       = var.default_node_pool.name
    node_count                 = var.default_node_pool.enable_auto_scaling ? null : var.default_node_pool.node_count
    vm_size                    = var.default_node_pool.vm_size
    enable_auto_scaling        = var.default_node_pool.enable_auto_scaling
    min_count                  = var.default_node_pool.enable_auto_scaling ? var.default_node_pool.min_count : null
    max_count                  = var.default_node_pool.enable_auto_scaling ? var.default_node_pool.max_count : null
    os_disk_size_gb            = var.default_node_pool.os_disk_size_gb
    type                       = "VirtualMachineScaleSets"
    zones                      = var.default_node_pool.availability_zones
    temporary_name_for_rotation = "defaulttemp"
    
    tags = var.tags
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin     = var.network_profile.network_plugin
    network_policy     = var.network_profile.network_policy
    dns_service_ip     = var.network_profile.dns_service_ip
    service_cidr       = var.network_profile.service_cidr
    load_balancer_sku  = var.network_profile.load_balancer_sku
  }

  tags = var.tags
}

# Additional Node Pool (Optional)
resource "azurerm_kubernetes_cluster_node_pool" "additional" {
  for_each = var.additional_node_pools

  name                  = each.value.name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = each.value.vm_size
  node_count            = each.value.enable_auto_scaling ? null : each.value.node_count
  enable_auto_scaling   = each.value.enable_auto_scaling
  min_count             = each.value.enable_auto_scaling ? each.value.min_count : null
  max_count             = each.value.enable_auto_scaling ? each.value.max_count : null
  os_disk_size_gb       = each.value.os_disk_size_gb
  zones                 = each.value.availability_zones

  tags = var.tags
}
