
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}


### Flask Backend EC2 Instance

resource "aws_instance" "flask" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.flask_sg.id]

  user_data = templatefile("user_data_flask.sh", {
    github_repo = var.github_repo
  })

  tags = {
    Name = "Flask-Backend-EC2"
  }
}



### Express Frontend EC2 Instance

resource "aws_instance" "express" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.express_sg.id]

  user_data = templatefile("user_data_express.sh", {
    backend_ip = aws_instance.flask.private_ip
    github_repo = var.github_repo
  })

  tags = {
    Name = "Express-Frontend-EC2"
  }
}



