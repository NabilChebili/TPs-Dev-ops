data "azurerm_resource_group" "rg" {
  name = "rg-${var.resource-group}"
}