# create default vpc if one does not exit
resource "aws_default_vpc" "default_vpc" {
  tags    = {
    Name  = "default vpc"
  }
}

resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main-vpc"
  }
}
