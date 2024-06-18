resource "aws_security_group" "redis_sg" {
  description = "redis_sg created from terraform"
  vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID

tags = {
    Name = "roboshop-${var.ENV}-redis-sg"
  }
  
 ingress {
    from_port       = var.PORT
    to_port         = var.PORT
    protocol        = "tcp"
    # cidr_blocks     = [data.terraform_remote_state.vpc.outputs.VPC_ID, data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]
    cidr_blocks     = [data.terraform_remote_state.vpc.outputs.VPC_CIDR]

  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }


}