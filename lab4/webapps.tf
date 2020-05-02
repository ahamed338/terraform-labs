provider "azurerm" {
  version = "=2.0.0"
  features {}
}

resource "azurerm_resource_group" "webapps" {
   name         = "webapps"
   location     = "${var.loc}"
   tags         = "${var.tags}"
}

resource "random_string" "webapprnd" {
  length  = 8
  lower   = true
  number  = true
  upper   = false
  special = false
}

resource "azurerm_app_service_plan" "free" {
    name                = "plan-free-${var.loc}"
    location            = "${var.loc}"
    resource_group_name = "${azurerm_resource_group.webapps.name}"
    tags                = "${azurerm_resource_group.webapps.tags}"

    kind                = "Linux"
    reserved            = true
    sku {
        tier = "Free"
        size = "F1"
    }
}

resource "azurerm_app_service" "citadel" {
    name                = "webapp-${random_string.webapprnd.result}-${var.loc}"
    location            = "${var.loc}"
    resource_group_name = "${azurerm_resource_group.webapps.name}"
    tags                = "${azurerm_resource_group.webapps.tags}"

    app_service_plan_id = "${azurerm_app_service_plan.free.id}"
}