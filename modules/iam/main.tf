resource "aws_iam_role" "launch_role" {
  name = "service-catalog-launch-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "servicecatalog.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "servicecatalog_policy" {
  name = "servicecatalog_policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ec2:RunInstances",
          "ec2:DescribeInstances",
          "ssm:GetParameters",
          "s3:GetObject",
          "cloudformation:*"
        ],
        Resource = "*"
      }
    ]
  })
}