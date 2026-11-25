resource "aws_vpc" "dev" {
    cidr_block = "10.0.0.0/24"
    tags = {
      Name = "dev-vpc"
    }
  
}
resource "aws_subnet" "test" {
    vpc_id = aws_vpc.dev.id
    cidr_block =var.subnet_cidir
    tags = {
        Name = "dev.subnet"
    }
  
}
