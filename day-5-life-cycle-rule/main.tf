resource "aws_instance" "name" {
  ami = "ami-0aacbf72109c53c0c"
  instance_type = "t2.micro"
  tags = {
    Name = "MyInstance"
  }

#lifecycle {
#  ignore_changes = [ tags ]
#}
#lifecycle {
#create_before_destroy = true
#}

#    lifecycle {
 #   prevent_destroy = true
  #  }

}

