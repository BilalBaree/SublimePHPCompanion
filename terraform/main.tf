provider "aws" {
  region = "us-east-1"
}

# ✅ Secure IAM Policy - follows least privilege principle
resource "aws_iam_policy" "insecure_policy" {
  name        = "InsecurePolicy"
  description = "Policy with specific actions and resources (improved least privilege)"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "s3:GetObject",  # Limit actions to GetObject on S3
          "s3:ListBucket"  # Limit actions to ListBucket on S3
        ],
        Resource = [
          "arn:aws:s3:::example-bucket",  # Specify exact bucket
          "arn:aws:s3:::example-bucket/*"  # Specify exact objects within the bucket
        ]
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
  type        = string
  default     = ""  # This should be securely managed via environment variables or AWS Secrets Manager
}
