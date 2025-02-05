resource "aws_instance" "ubuntu_instance" {
  ami                         = "ami-00c257e12d6828491"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.security_group.id]
  key_name                    = "host"
  associate_public_ip_address = true

  depends_on = [
    aws_security_group.security_group,
    aws_internet_gateway.igw
  ]

  user_data       = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y nginx

              # Create index.html with H1 tag in the default NGINX web directory
              echo "<h1>Hello From Ubuntu EC2 Instance!!!</h1>" | sudo tee /var/www/html/index.html

              # Update NGINX to listen on port 80
              sudo sed -i 's/listen 80 default_server;/listen 80 default_server;/g' /etc/nginx/sites-available/default

              # Restart NGINX to apply the changes
              sudo systemctl restart nginx
              EOF

  tags = {
    Name = "ubuntu-instance"
  }
}
