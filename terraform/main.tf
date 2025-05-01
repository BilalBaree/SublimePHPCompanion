provider "aws" {
  region = "us-east-1"
}

# ✅ Secure IAM Policy - follows least privilege principle
#resource "aws_iam_policy" "secure_policy" {
#  name        = "SecurePolicy"
#  description = "Policy with restricted actions and resources"
#
#  policy = jsonencode({
#    Version = "2012-10-17",
#    Statement = [
#      {
#        Effect   = "Allow"
#        Action   = [
#          "s3:ListBucket",
#          "s3:GetObject"
#        ]
#        Resource = [
#          "arn:aws:s3:::my-bucket",
#          "arn:aws:s3:::my-bucket/*"
#        ]
#      },
#      {
#        Effect   = "Allow"
#        Action   = [
#          "ec2:DescribeInstances",
#          "ec2:StartInstances"
#        ]
#        Resource = "*"
#      }
#    ]
#  })
#}


resource "aws_iam_policy" "secure_limited_policy" {
  name        = "SecureLimitedPolicy"
  description = "A policy with scoped permissions ."

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "ec2:DescribeInstances",
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Resource = [
          "arn:aws:s3:::my-bucket",
          "arn:aws:s3:::my-bucket/*",
          "arn:aws:ec2:us-east-1:123456789012:instance/*"
        ]
      }
    ]
  })
}



