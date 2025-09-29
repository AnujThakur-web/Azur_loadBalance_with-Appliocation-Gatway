# यह Terraform कॉन्फ़िगरेशन Azure संसाधनों को प्रबंधित करने के लिए AzureRM प्रदाता सेट करता है।
# इसमें आवश्यक प्रदाता संस्करण निर्दिष्ट किया गया है और सब्सक्रिप्शन आईडी के साथ प्रदाता को कॉन्फ़िगर किया गया है।

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.32.0"
    }
  }
}

# terraform {
# backend "azurerm" {
# resource_group_name  = "instant-rg"
#      storage_account_name = "pipelinestorage202"
#      container_name       = "pipelinecont"
#      key                  = "dev.tfstate"
#    }
# }


provider "azurerm" {
  features {}
  subscription_id = "3c0d3e39-55e3-464c-b220-26aee31cecb9"
}