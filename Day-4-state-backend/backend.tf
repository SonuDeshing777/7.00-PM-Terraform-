
terraform {
  backend "s3" {
    bucket = "sohel-prod-test"
    key    = "sohel/terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true #s3 native locking supported version 
    dynamodb_table = "value"
  }
}
