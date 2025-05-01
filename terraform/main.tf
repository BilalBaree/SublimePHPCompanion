provider "aws" {
  region = "us-east-1"
}

# ✅ Secure IAM Policy (least privilege)
resource "aws_iam_policy" "secure_policy" {
  name        = "SecurePolicy"
  description = "Policy with least privilege"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "s3:GetObject"
        ]
        Resource = "arn:aws:s3:::example-bucket/*"
      }
    ]
  })
}

# ❌ Insecure IAM Policy (will trigger OPA Conftest)
resource "aws_iam_policy" "insecure_policy" {
  name        = "InsecurePolicy"
  description = "Policy with wildcards and over-permissive access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "*"
        Resource = "*"
      }
    ]
  })
}

# ❌ Hardcoded secret (will trigger Checkov)
variable "api_key" {
  default = "sk_test_1234567890abcdef"
}
