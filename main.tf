module "test_vpc" {
  source = "./modules/networking"
}

module "test_compute" {
  source                          = "./modules/computing"
  instance_vpc_security_group_ids = [module.test_vpc.test_sg_id]
  instance_subnet_id              = module.test_vpc.test_public_subnet1_id
}
module "test_rds" {
  source                     = "./modules/database"
  db_subnet_group_name       = module.test_vpc.test_db_subnet_group_id
  rds_vpc_security_group_ids = [module.test_vpc.test_rds_sg_id]
}