# Fichier à compléter avec la description du cluster Kubernetes dans Azure
# Doc: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster

resource "azurerm_kubernetes_cluster" "cl" {
  name                = "cl-nabilchebili"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  dns_prefix          = "dnsnabilchebili"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.cl.kube_config.0.client_certificate
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.cl.kube_config_raw

  sensitive = true
}
