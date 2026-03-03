# AKS Module

This module creates an Azure Kubernetes Service (AKS) cluster with configurable options.

## Resources Created

- `azurerm_resource_group` - Resource group for AKS cluster
- `azurerm_kubernetes_cluster` - AKS cluster with system-assigned managed identity
- `azurerm_kubernetes_cluster_node_pool` - Additional node pools (optional)

## Usage

```hcl
module "aks_cluster" {
  source = "./modules/aks"

  resource_group_name = "aks-prod-rg"
  location            = "uaenorth"
  cluster_name        = "aks-prod-cluster"
  dns_prefix          = "aks-prod"
  kubernetes_version  = "1.28"

  default_node_pool = {
    name                = "default"
    node_count          = 2
    vm_size             = "Standard_D2s_v3"
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 5
    os_disk_size_gb     = 50
    availability_zones  = ["1", "2", "3"]
  }

  network_profile = {
    network_plugin    = "azure"
    network_policy    = "azure"
    dns_service_ip    = "10.0.0.10"
    service_cidr      = "10.0.0.0/16"
    load_balancer_sku = "standard"
  }

  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | Name of the resource group | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| cluster_name | Name of the AKS cluster | `string` | n/a | yes |
| dns_prefix | DNS prefix for the cluster | `string` | n/a | yes |
| kubernetes_version | Kubernetes version | `string` | `"1.28"` | no |
| default_node_pool | Default node pool configuration | `object` | n/a | yes |
| additional_node_pools | Additional node pools | `map(object)` | `{}` | no |
| network_profile | Network configuration | `object` | see variables.tf | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster_id | The ID of the AKS cluster |
| cluster_name | The name of the AKS cluster |
| kube_config | Kubernetes configuration (sensitive) |
| kube_config_host | Kubernetes cluster server host |
| client_certificate | Base64 encoded client certificate (sensitive) |
| client_key | Base64 encoded client key (sensitive) |
| cluster_ca_certificate | Base64 encoded cluster CA certificate (sensitive) |
| node_resource_group | Auto-generated resource group for cluster resources |
| principal_id | System-assigned identity principal ID |
| resource_group_name | The name of the resource group |
| resource_group_id | The ID of the resource group |
| fqdn | The FQDN of the AKS cluster |

## Features

### Auto-scaling

Enable auto-scaling by setting `enable_auto_scaling = true` and providing `min_count` and `max_count` in the node pool configuration.

### Multiple Node Pools

Add additional node pools using the `additional_node_pools` variable:

```hcl
additional_node_pools = {
  worker = {
    name                = "worker"
    vm_size             = "Standard_D4s_v3"
    node_count          = 3
    enable_auto_scaling = true
    min_count           = 2
    max_count           = 10
    os_disk_size_gb     = 100
    availability_zones  = ["1", "2", "3"]
  }
}
```

### Availability Zones

High availability across availability zones is supported by specifying zones in the node pool configuration.

### Networking

The module supports Azure CNI networking with Azure Network Policy by default. Customize the network configuration using the `network_profile` variable.
