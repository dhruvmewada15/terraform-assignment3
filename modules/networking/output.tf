output "test_public_subnet1_id" {
  value = aws_subnet.test_public1.id
}

output "test_sg_id" {  
  value = aws_security_group.test_sg_allow_ssh.id
}

output "test_rds_sg_id" {  
  value = aws_security_group.test_sg_allow_postgres.id
}

output "test_db_subnet_group_id" {  
  value = aws_db_subnet_group.test_db_subnet_group.id
}
