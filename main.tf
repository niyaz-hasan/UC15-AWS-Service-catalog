module "instance_catalog" {
  source = "./modules/service_catalog"

  portfolio_name                 = var.portfolio_name
  portfolio_description          = var.portfolio_description
  provider_name                  = var.provider_name
  product_name                   = var.product_name
  product_owner                  = var.product_owner
  template_url                   = var.template_url
  provisioning_name              = var.provisioning_name
  template_constraint_parameters = var.template_constraint_parameters
  tag_key                        = var.tag_key
  tag_value                      = var.tag_value
  user_arn                       = var.user_arn
}