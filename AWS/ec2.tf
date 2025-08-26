# Creating EC2 instances into az 1a & 1b for public
resource "aws_instance" "local_demo" {
  ami           = "ami-060e277c0d4cce553"
  instance_type = var.instance_type
  count         = 2
  subnet_id =  element(aws_subnet.dev-public[*].id, count.index)
  availability_zone = element(var.azs, count.index)
  
  tags = {
    Name = "${local.local_setup}- ec2 - ${count.index + 1}"
  }
}



