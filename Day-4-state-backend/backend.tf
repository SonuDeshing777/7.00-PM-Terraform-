
terraform {
  backend "s3" {
    bucket = "sohel-prod-test"
    key    = "sohel/terraform.tfstate"
    region = "us-east-1"
  }
}
