data "aws_availability_zones" "azs" {

}

resource "aws_vpc" "wp_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "wordpress_vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.wp_vpc.id

  tags = {
    Name = "wp_igw"
  }
}

resource "aws_subnet" "wp_public_subnet_1" {
  vpc_id            = aws_vpc.wp_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "wp_public_subnet_1"
  }
}

resource "aws_subnet" "wp_public_subnet_2" {
  vpc_id     = aws_vpc.wp_vpc.id
  cidr_block = "10.0.2.0/24"

  availability_zone = "us-east-1b"

  tags = {
    Name = "wp_public_2"
  }
}

resource "aws_eip" "eip" {

  vpc = true

  tags = {
    Name = "wp_nat_ip"
  }
}

resource "aws_subnet" "wp_private_subnet_1" {
  vpc_id     = aws_vpc.wp_vpc.id
  cidr_block = "10.0.3.0/24"

  availability_zone = "us-east-1a"

  tags = {
    Name = "wp_private_subnet_1"
  }
}

resource "aws_subnet" "wp_private_subnet_2" {
  vpc_id     = aws_vpc.wp_vpc.id
  cidr_block = "10.0.4.0/24"

  availability_zone = "us-east-1b"

  tags = {
    Name = "wp_private_subnet_2"
  }
}

resource "aws_subnet" "wp_private_subnet_3" {
  vpc_id            = aws_vpc.wp_vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "wp_private_subnet_3"
  }
}

resource "aws_nat_gateway" "nat" {
  subnet_id     = aws_subnet.wp_public_subnet_1.id
  allocation_id = aws_eip.eip.id

  tags = {
    Name = "wp_nat_gateway"
  }
}

resource "aws_route_table" "wp_private_rt" {
  vpc_id = aws_vpc.wp_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "wp_private_rt"
  }
}

resource "aws_route_table" "wp_public_rt" {
  vpc_id = aws_vpc.wp_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "wp_public_rt"
  }
}

resource "aws_route_table_association" "wp_private_rta_1" {
  route_table_id = aws_route_table.wp_private_rt.id
  subnet_id = aws_subnet.wp_private_subnet_1.id
}

resource "aws_route_table_association" "wp_private_rta_2" {
  route_table_id = aws_route_table.wp_private_rt.id
  subnet_id      = aws_subnet.wp_private_subnet_2.id
}

resource "aws_route_table_association" "wp_private_rta_3" {
  route_table_id = aws_route_table.wp_private_rt.id
  subnet_id      = aws_subnet.wp_private_subnet_3.id
}

resource "aws_route_table_association" "wp_public_rta_1" {
  route_table_id = aws_route_table.wp_public_rt.id
  subnet_id = aws_subnet.wp_public_subnet_1.id
}

resource "aws_route_table_association" "public2" {
  route_table_id = aws_route_table.wp_public_rt.id
  subnet_id      = aws_subnet.wp_public_subnet_2.id
}

resource "aws_db_subnet_group" "mysql" {
  name       = "mysql_subnet_group"
  subnet_ids = [aws_subnet.wp_private_subnet_1.id, aws_subnet.wp_private_subnet_2.id, aws_subnet.wp_private_subnet_3.id]

  tags = {
    Name = "mysql_subnet_group"
  }
}
