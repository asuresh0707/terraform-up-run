provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "app" {
  ami           = "ami-0cff7528ff583bf9a"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.app-sg.id]
  user_data = <<-EOF
      #!/bin/bash
      sudo yum update -y
      sudo yum install httpd -y
      sudo systemctl enable httpd
      sudo systemctl start httpd
      echo "hello world from terraform" > /var/www/html/index.html"
      sudo systemctl restart httpd
      EOF

  tags = {
    name = "terraform-web-server"
  }
}

resource "aws_security_group" "app-sg" {
  name = "terraform app-security-group"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "the firewall rule allows incomming traffic on port 80"
    from_port = 80
    protocol = "tcp"
    to_port = 80
  } 
}

