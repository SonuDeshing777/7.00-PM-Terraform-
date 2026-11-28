#creation of vpc 
resource "aws_vpc" "custome_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      name = " custome_vpc"
    }
  

}
#subnet creation 

resource "aws_subnet" "sub-1" {
    cidr_block = "10.0.0.0/24"
    vpc_id = aws_vpc.custome_vpc.id
    tags = {
      name = "sub-1"
    }

  
}
#cfreation internet gatway

resource "aws_internet_gateway" "dev_igw" {
    vpc_id = aws_vpc.custome_vpc.id

    tags = {
      name = "dev_igw"
    }
  
}
#creation route table 

resource "aws_route_table" "dev_rt" {
    vpc_id = aws_vpc.custome_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.dev_igw.id
    }
   
}
# rt associations 

resource "aws_route_table_association" "dev" {
    subnet_id = aws_subnet.sub-1.id
    route_table_id = aws_route_table.dev_rt.id
  
}

#creation security 

resource "aws_security_group" "name" {
    
  name        = "public-security-group"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.custome_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["49.36.120.50/32"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0 #any port 
    to_port     = 0 
    protocol    = "-1" #any protocol
    cidr_blocks = ["0.0.0.0/0"] #any source
  }

  
}
resource "aws_instance" "name" {
    ami = "ami-0aacbf72109c53c0c"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.sub-1.id
    vpc_security_group_ids = [aws_security_group.name.id]
   
  
}
