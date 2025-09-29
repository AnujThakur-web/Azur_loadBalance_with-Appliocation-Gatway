
variable "subnet_name" {
	description = "The name of the subnet."
	type        = string
}

variable "vnet_name" {
	description = "The name of the virtual network."
	type        = string
}

variable "rg_name" {
	description = "The name of the resource group."
	type        = string
}

variable "pip_name" {
	description = "The name of the public IP."
	type        = string
}

variable "bastion_name" {
	description = "The name of the Bastion host."
	type        = string
}

variable "location" {
	description = "The Azure region for resources."
	type        = string
}
