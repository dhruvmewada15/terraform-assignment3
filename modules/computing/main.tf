resource "aws_instance" "compute_instance" {
  ami                         = var.instance_ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.instance_subnet_id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.compute_connect_key.key_name
  vpc_security_group_ids      = var.instance_vpc_security_group_ids

  tags = {
    Name = "dhruv_terraform_assignment"
  }

}

resource "aws_key_pair" "compute_connect_key" {
  key_name = "dhruv_compute_connect_key"
  public_key = file("/home/infracloud/dhruv/aws_keys/dhruv_compute_connect_key.pub")
}