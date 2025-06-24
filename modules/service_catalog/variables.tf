variable "portfolio_name" {
  description = "Name of the Service Catalog portfolio"
  type        = string
}

variable "portfolio_description" {
  description = "Description of the Service Catalog portfolio"
  type        = string
}

variable "provider_name" {
  description = "Name of the provider creating the portfolio"
  type        = string
}

variable "product_name" {
  description = "Name of the product in the portfolio"
  type        = string
}

variable "product_owner" {
  description = "Owner of the product"
  type        = string
}

variable "template_url" {
  description = "S3 URL to the CloudFormation template"
  type        = string
}

variable "provisioning_name" {
  description = "Name for the provisioning artifact"
  type        = string
}


variable "template_constraint_parameters" {
  description = "JSON-encoded parameters for the template constraint"
  type        = map(any)
  default     = {}
}



variable "tag_key" {
  description = "TagOption key"
  type        = string
  default     = "env"
}

variable "tag_value" {
  description = "TagOption value"
  type        = string
  default     = "dev"
}

variable "user_arn" {
  description = "IAM principal ARN to associate with the portfolio"
  type        = string
}

variable "launch_role_arn" {
  description = "IAM role ARN to be used for product launch"
  type        = string
  default     = ""
}

#variable "launch_role_arn"{
#}