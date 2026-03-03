output "aks_cluster_id" {
  description = "The ID of the AKS cluster"
  value       = module.aks_cluster.cluster_id
}

output "aks_cluster_name" {
  description = "The name of the AKS cluster"
  value       = module.aks_cluster.cluster_name
}

output "aks_cluster_fqdn" {
  description = "The FQDN of the Azure Kubernetes Managed Cluster"
  value       = module.aks_cluster.fqdn
}

output "kube_config" {
  description = "Kubernetes configuration for kubectl"
  value       = module.aks_cluster.kube_config
  sensitive   = true
}

output "kube_config_host" {
  description = "The Kubernetes cluster server host"
  value       = module.aks_cluster.kube_config_host
  sensitive   = true
}

output "node_resource_group" {
  description = "The auto-generated resource group which contains the resources for this managed Kubernetes cluster"
  value       = module.aks_cluster.node_resource_group
}

output "principal_id" {
  description = "The principal ID of the system assigned identity"
  value       = module.aks_cluster.principal_id
}

output "resource_group_name" {
  description = "The name of the resource group"
  value       = module.aks_cluster.resource_group_name
}

output "resource_group_id" {
  description = "The ID of the resource group"
  value       = module.aks_cluster.resource_group_id
}
