#provision redis

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "roboshop-${var.ENV}-redis"
  engine               = "memcached"
  node_type            = "cache.t3.small"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.4"
  port                 = 6379
  security_group_ids   = [aws_security_group.redis_sg.id]
  subnet_group_name    = aws_db_subnet_group.redis.name

}

resource "aws_elasticache_parameter_group" "redis_pg" {
  name                 = "roboshop-${var.ENV}-redispg"
  family               = "redis6.0"
}

resource "aws_db_subnet_group" "redis" {
  name                 = "roboshop-${var.ENV}-redis_subnetgroup"
  subnet_ids           = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS
    
}




# # provisions document db cluster
# resource "aws_docdb_cluster" "docdb" {
#   cluster_identifier      = "roboshop-${var.ENV}-docdb"
#   engine                  = "docdb"
#   master_username         = "admin1"
#   master_password         = "RoboShop1" 
# #   backup_retention_period = 5             # In Prod we would enable this 
# #   preferred_backup_window = "07:00-09:00" 
#   skip_final_snapshot     = true
#   vpc_security_group_ids  = [aws_security_group.docdb_sg.id]
#   db_subnet_group_name    = aws_docdb_subnet_group.docdb.name
# }

# # Creates a subnet-groups [ a groups of subnets that we supply to the cluster based resources ]
# resource "aws_docdb_subnet_group" "docdb" {
#   name                    = "roboshop-${var.ENV}-docdb"
#   subnet_ids              = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS
  

#   tags = {
#         Name = "roboshop-${var.ENV}-docdb"
#   }
# }

# #create instance and add it on docdb cluster
# resource "aws_docdb_cluster_instance" "cluster_instances" {
#   count              = var.DOCDB_INSTANCE_COUNT
#   identifier         = "roboshop-${var.ENV}-docdb"
#   cluster_identifier = aws_docdb_cluster.docdb.id
#   instance_class     = var.DOCDB_INSTANCE_TYPE
# }