module "dev" {
    source = "../Day-6_ec2-modules"
    ami_id = "ami-000d209a4fc9822c4"
    instance_type ="t2.micro"
    az = "us-east-1a"
    tags = "dev"
  
}