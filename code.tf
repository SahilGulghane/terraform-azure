

# Create virtual network
resource "azurerm_virtual_network" "my_terraform_network" {
  name                = "my-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create subnets
resource "azurerm_subnet" "my_terraform_subnet_a" {
  name                 = "my-subnet-A"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.my_terraform_network.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "my_terraform_subnet_b" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.my_terraform_network.name
  address_prefixes     = ["10.0.1.0/28"]
}

# Create Windows Virtual Machine
resource "azurerm_windows_virtual_machine" "my_windows_vm" {
  name                  = "my-windows-vm"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = "Standard_DS2_v2"
  admin_username        = "adminuser"
  admin_password        = "Password123!"  # Replace with a secure password

  network_interface_ids = [azurerm_network_interface.my_windows_vm_nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

# Create Network Interface for the Windows VM
resource "azurerm_network_interface" "my_windows_vm_nic" {
  name                      = "my-windows-vm-nic"
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location

  ip_configuration {
    name                          = "my-windows-vm-ipconfig"
    subnet_id                     = azurerm_subnet.my_terraform_subnet_a.id
    private_ip_address_allocation = "Dynamic"
  }
}
