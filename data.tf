# datasource that reads the info from vpc statefile 
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "terraform-devops29master"
    key    = "dev/terrafile/vpc/terraform.tfstate"
    region = "us-east-1"
  }
}

