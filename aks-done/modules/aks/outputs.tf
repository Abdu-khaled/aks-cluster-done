output "cluster_id" {
  description = "The ID of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.id
}

output "cluster_name" {
  description = "The name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "kube_config" {
  description = "Kubernetes configuration for kubectl"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}

output "kube_config_host" {
  description = "The Kubernetes cluster server host"
  value       = azurerm_kubernetes_cluster.aks.kube_config.0.host
}

output "client_certificate" {
  description = "Base64 encoded client certificate"
  value       = azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate
  sensitive   = true
}

output "client_key" {
  description = "Base64 encoded client key"
  value       = azurerm_kubernetes_cluster.aks.kube_config.0.client_key
  sensitive   = true
}

output "cluster_ca_certificate" {
  description = "Base64 encoded cluster CA certificate"
  value       = azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate
  sensitive   = true
}

output "node_resource_group" {
  description = "The auto-generated resource group which contains the resources for this managed Kubernetes cluster"
  value       = azurerm_kubernetes_cluster.aks.node_resource_group
}

output "principal_id" {
  description = "The principal ID of the system assigned identity"
  value       = azurerm_kubernetes_cluster.aks.identity.0.principal_id
}

output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.aks.name
}

output "resource_group_id" {
  description = "The ID of the resource group"
  value       = azurerm_resource_group.aks.id
}

output "fqdn" {
  description = "The FQDN of the Azure Kubernetes Managed Cluster"
  value       = azurerm_kubernetes_cluster.aks.fqdn
}
