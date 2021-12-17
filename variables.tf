variable "bucket" {
  type = string
  description = "Azure blob container name"
}

variable "resource_group_location" {
  type = string
  default = "centralus"
  description   = "Location of the resource group."
}

variable "CLIENT_ID" {
}

variable "CLIENT_SECRET" {
  
}