


# 1. Create IAM User
resource "aws_iam_user" "dev_user" {
  name = "terraform-dev-user"
}

# 2. Create IAM Role
resource "aws_iam_role" "dev_role" {
  name = "terraform-dev-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        AWS = aws_iam_user.dev_user.arn
      }
      Action = "sts:AssumeRole"
    }]
  })
}

# 3. Create S3 Policy
resource "aws_iam_policy" "s3_policy" {
  name = "terraform-s3-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "s3:ListAllMyBuckets"
      ]
      Resource = "*"
    }]
  })
}

# 4. Attach S3 Policy to Role
resource "aws_iam_role_policy_attachment" "role_attach" {
  role       = aws_iam_role.dev_role.name
  policy_arn = aws_iam_policy.s3_policy.arn
}

# 5. Create Assume Role Policy
resource "aws_iam_policy" "assume_policy" {
  name = "terraform-assume-role-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = "sts:AssumeRole"
      Resource = aws_iam_role.dev_role.arn
    }]
  })
}

# 6. Attach Policy to IAM User
resource "aws_iam_user_policy_attachment" "user_attach" {
  user       = aws_iam_user.dev_user.name
  policy_arn = aws_iam_policy.assume_policy.arn
}

# 7. Outputs
output "iam_user_name" {
  value = aws_iam_user.dev_user.name
}

output "iam_role_arn" {
  value = aws_iam_role.dev_role.arn
}

output "iam_policy_arn" {
  value = aws_iam_policy.s3_policy.arn
}
