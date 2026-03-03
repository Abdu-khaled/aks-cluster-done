module "aks_cluster" {
  source = "./modules/aks"

  resource_group_name = var.resource_group_name
  location            = var.location
  cluster_name        = var.cluster_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  default_node_pool = {
    name                = var.default_node_pool_name
    node_count          = var.default_node_pool_node_count
    vm_size             = var.default_node_pool_vm_size
    enable_auto_scaling = var.default_node_pool_enable_auto_scaling
    min_count           = var.default_node_pool_enable_auto_scaling ? var.default_node_pool_min_count : null
    max_count           = var.default_node_pool_enable_auto_scaling ? var.default_node_pool_max_count : null
    os_disk_size_gb     = var.default_node_pool_os_disk_size_gb
    availability_zones  = var.default_node_pool_availability_zones
  }

  additional_node_pools = var.additional_node_pools
  network_profile       = var.network_profile
  tags                  = var.tags
}
