resource "aws_db_instance" "default" {
  allocated_storage    = var.db_allocated_storage
  engine               = var.db_engine
  instance_class       = var.db_instance_class
  name                 = var.db_name
  username             = var.db_username
  password             = var.db_password  
  skip_final_snapshot  = true
  db_subnet_group_name = var.db_subnet_group_name
  vpc_security_group_ids = var.rds_vpc_security_group_ids  

  tags = {
    Name = "dhruv_terraform_assignment"
  }

}