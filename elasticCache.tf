#provision redis

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "roboshop-${var.ENV}-redis"
  engine               = "redis"
  node_type            = var.NODE_TYPE
  num_cache_nodes      = var.NUMBER_OF_NODES
  parameter_group_name = aws_elasticache_parameter_group.redis_pg.name
  port                 = var.PORT
  engine_version       = var.ENGINE_VERSION
  security_group_ids   = [aws_security_group.redis_sg.id]
  subnet_group_name    = aws_elasticache_subnet_group.redis.name

}

resource "aws_elasticache_parameter_group" "redis_pg" {
  name                 = "roboshop-${var.ENV}-redispg"
  family               = var.REDIS_FAMILY
}

resource "aws_elasticache_subnet_group" "redis" {
  name                 = "roboshop-${var.ENV}-redis_subnetgroup"
  subnet_ids           = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS
    
}


