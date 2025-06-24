module "s3_catalog" {
  source = "../modules/service_catalog"

  portfolio_name                 = var.portfolio_name
  portfolio_description          = var.portfolio_description
  provider_name                  = var.provider_name

  product_name                   = var.product_name
  product_owner                  = var.product_owner
  template_url                   = var.template_url
  provisioning_name              = var.provisioning_name

  enable_template_constraint     = var.enable_template_constraint
  template_constraint_parameters = var.template_constraint_parameters

  enable_launch_constraint       = var.enable_launch_constraint
  launch_role_arn                = var.launch_role_arn

  create_tag_option              = var.create_tag_option
  tag_key                        = var.tag_key
  tag_value                      = var.tag_value

  user_arn                       = var.user_arn
}