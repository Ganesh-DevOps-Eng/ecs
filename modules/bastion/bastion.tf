resource "aws_instance" "bastion" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_name

  security_groups = [var.security_group]

  tags = {
    Name        = "${var.project_name}-bastion"
    Environment = var.env
  }
}