resource "azurerm_linux_virtual_machine" "vm1" {
  name                = "myMachine-nabilchebili-1"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.ni1.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  provisioner "remote-exec" {
    connection {
          type = "ssh"
          host = azurerm_public_ip.pi1.ip_address
          user = self.admin_username
          private_key = file("~/.ssh/id_rsa")
      }
    inline = [
      "sudo apt update",
      "sudo apt-get install -y openjdk-8-jdk",
      "java -version",
      "git clone https://github.com/spring-projects/spring-petclinic.git",
      "cd spring-petclinic",
      "./mvnw package"
    ]
  }
}

resource "azurerm_virtual_network" "vn1" {
  name                = "myVnet-nabilchebili-1"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "sn" {
  name                 = "subnet-nabilchebili"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vn1.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "ni1" {
  name                = "myNetworkI-nabilchebili-1"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.sn.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pi1.id
  }
}

resource "azurerm_public_ip" "pi1" {
  name                = "public-ip-nabilchebili-1"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  allocation_method   = "Static"

}

resource "azurerm_network_security_group" "nsg1" {
  name                = "nsg-nabilchebili-1"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  security_rule {
    name                       = "st"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "nisg1" {
  network_interface_id      = azurerm_network_interface.ni1.id
  network_security_group_id = azurerm_network_security_group.nsg1.id
}




  
