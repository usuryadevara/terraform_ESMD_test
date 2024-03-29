variable "region"{
  description = "Enter the region"
  type        = string
  default = "us-east-1"
}

variable "environment" {
  type    = string
  default = ""
}

variable "bucket" {
  type    = string
  default = ""
}

variable "key" {
  type    = string
  default = ""
}

## tagging ##
variable "env_type" {
  description = "One of the supported environment type values: Document URL: Server+Tagging+Policy"
  type        = string
  default     = ""
}

variable "product_line" {
  description = "Product line for which these resources are provided: Document URL: Server+Tagging+Policy"
  type        = string
  default     = "esmd"
}

# variable "product_component" {
#   description = "Product line components: Document URL: Server+Tagging+Policy"
#   type        = string
#   default = "esmd"
# }

variable "provisioner" {
  description = "One of the supported provisioner values: Document URL: Server+Tagging+Policy"
  type        = string
  default     = "terraform"
}

variable "owner_contact" {
  description = "Owner contact of resource"
  type        = string
  default     = "esmddevsecops"
}

variable "maintenance_contact" {
  description = "Maintenance contact of the resource"
  type        = string
  default     = "esmddevsecops@unissant.com"
}