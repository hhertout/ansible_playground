resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "lab-ssh-key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "architecture"
    values = ["arm64"]
  }

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-arm64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_security_group" "sg" {
  name = "sg_ssh"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t4g.small"

  security_groups = [aws_security_group.sg.name]

  key_name = aws_key_pair.ssh_key.key_name

  instance_market_options {
    market_type = "spot"
    spot_options {
      instance_interruption_behavior = "stop"
      spot_instance_type             = "persistent"
    }
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              hostnamectl set-hostname lnx001
              echo "127.0.1.1 lnx001" >> /etc/hosts
              EOF

  tags = {
    Name = "test-lab"
  }
}

# terraform output -raw private_key > ~/.ssh/id_rsa_azlab
# chmod 600 ~/.ssh/id_rsa_azlab
# ssh -i ~/.ssh/id_rsa_azlab ubuntu@<public_ip>
