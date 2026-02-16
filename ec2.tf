resource "aws_instance" "app_server" {
  ami           = "ami-0c7217cdde317cfec" # Amazon Linux 2023
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public.id

  # This script installs Apache (Middleware) automatically
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Middleware Server Active</h1>" > /var/www/html/index.html
              EOF

  tags = { Name = "Middleware-Server" }
}
