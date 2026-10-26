provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  lifecycle {
    prevent_destroy = true
    ignore_changes  = [tags]
  }

  tags = {
    Name = "Main-VPC"
  }
}

resource "aws_subnet" "subnet_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  lifecycle {
    prevent_destroy = true
    ignore_changes  = [tags]
  }

  tags = {
    Name = "SUBNET-A"
  }
}

resource "aws_subnet" "subnet_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  lifecycle {
    prevent_destroy = true
    ignore_changes  = [tags]
  }

  tags = {
    Name = "SUBNET-B"
  }
}


resource "aws_instance" "server_a" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_a.id

  lifecycle {
    prevent_destroy = true
    ignore_changes = [tags]
  }

  tags = {
    Name = "SERVER-A"
  }
}

resource "aws_instance" "server_b" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_b.id

  lifecycle {
    prevent_destroy = true
    ignore_changes = [tags]
  }

  tags = {
    Name = "SERVER-B"
  }
}