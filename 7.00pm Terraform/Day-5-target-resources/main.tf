resource "aws_instance" "name" {
  ami = "ami-0aacbf72109c53c0c"
  instance_type = "t2.micro"
  tags = {
    Name = "MyInstance"
  }
}
resource "aws_s3_bucket" "king" {
    bucket = "king"
  
}
#terraform plan -target=aws_s3_bucket.name #we can applying specific resource by useing target 