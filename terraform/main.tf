provider "aws" {
  region = "us-east-1"
}

# ✅ Secure IAM Policy - follows least privilege principle
resource "aws_iam_policy" "secure_policy" {
  name        = "SecurePolicy"
  description = "Least privilege access to a specific S3 bucket object"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["s3:GetObject"],
        Resource = "arn:aws:s3:::example-bucket/*"
      }
    ]
  })
}

# ❌ Insecure IAM Policy - overly permissive (for security scanning demonstration)
resource "aws_iam_policy" "insecure_policy" {
  name        = "InsecurePolicy"
  description = "Policy with wildcard actions and resources (violates least privilege)"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "*",
        Resource = "*"
      }
    ]
  })
}

# ❌ Hardcoded secret - violates secret management best practices
variable "api_key" {
  description = "API key (should not be hardcoded)"
  default     = "sk_test_1234567890abcdef" # Will trigger Checkov or tfsec
}
