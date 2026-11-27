terraform {
  backend "s3" {
    bucket       = "dev-prod-sohel"
    key          = "env/dev/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
