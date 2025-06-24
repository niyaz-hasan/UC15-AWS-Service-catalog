#resource "aws_iam_role" "launch_role" {
#  name = "service-catalog-launch-role"
#
#  assume_role_policy = jsonencode({
#    Version = "2012-10-17"
#    Statement = [
#      {
#        Effect = "Allow"
#        Principal = {
#          Service = "servicecatalog.amazonaws.com"
#        }
#        Action = "sts:AssumeRole"
#      }
#    ]
#  })
#}
#
#resource "aws_iam_policy" "servicecatalog_policy" {
#  name = "servicecatalog_policy"
#
#  policy = jsonencode({
#    Version = "2012-10-17",
#    Statement = [
#      {
#        Effect = "Allow",
#        Action = [
#          "ec2:RunInstances",
#          "ec2:DescribeInstances",
#          "ssm:GetParameters",
#          "s3:GetObject",
#          "cloudformation:*"
#        ],
#        Resource = "*"
#      }
#    ]
#  })
#}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.launch_role.name
  policy_arn = aws_iam_policy.servicecatalog_policy.arn
}

resource "aws_servicecatalog_portfolio" "this" {
  name          = var.portfolio_name
  description   = var.portfolio_description
  provider_name = var.provider_name
}

resource "aws_servicecatalog_product" "this" {
  name  = var.product_name
  owner = var.product_owner
  type  = "CLOUD_FORMATION_TEMPLATE"

  provisioning_artifact_parameters {
    name         = var.provisioning_name
    type         = "CLOUD_FORMATION_TEMPLATE"
    template_url = var.template_url
  }
}

resource "aws_servicecatalog_product_portfolio_association" "this" {
  portfolio_id = aws_servicecatalog_portfolio.this.id
  product_id   = aws_servicecatalog_product.this.id
}

resource "aws_servicecatalog_constraint" "template_constraint" {
  portfolio_id = aws_servicecatalog_portfolio.this.id
  product_id   = aws_servicecatalog_product.this.id
  type         = "TEMPLATE"
  parameters   = jsonencode(var.template_constraint_parameters)
}

#resource "aws_servicecatalog_constraint" "launch_constraint" {
#  portfolio_id = aws_servicecatalog_portfolio.this.id
#  product_id   = aws_servicecatalog_product.this.id
#  type         = "LAUNCH"
#  parameters   = jsonencode({ RoleArn = aws_iam_role.launch_role.arn })
#
#  depends_on = [
#    aws_iam_role.launch_role,
#    aws_iam_role_policy_attachment.attach_policy
#  ]
#}

resource "aws_servicecatalog_constraint" "launch_constraint" {
  portfolio_id = aws_servicecatalog_portfolio.this.id
  product_id   = aws_servicecatalog_product.this.id
  type         = "LAUNCH"

  parameters = jsonencode({
    RoleArn = var.launch_role_arn
  })

  depends_on = [
    aws_iam_role.launch_role,
    aws_iam_role_policy_attachment.attach_policy
  ]
}


resource "aws_servicecatalog_tag_option" "this" {
  key   = var.tag_key
  value = var.tag_value
}

resource "aws_servicecatalog_tag_option_resource_association" "this" {
  resource_id   = aws_servicecatalog_product.this.id
  tag_option_id = aws_servicecatalog_tag_option.this.id
}

resource "aws_servicecatalog_principal_portfolio_association" "this" {
  portfolio_id   = aws_servicecatalog_portfolio.this.id
  principal_arn  = var.user_arn
  principal_type = "IAM"
}
