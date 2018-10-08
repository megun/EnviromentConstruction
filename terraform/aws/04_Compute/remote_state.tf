data "terraform_remote_state" "vpc" {
  backend = "s3"

  config {
    bucket = "megun-system01-terraform-tfstate"
    key    = "env/${terraform.workspace}/terraform.tfstate/VPC"
    region = "ap-northeast-1"
  }
}

data "terraform_remote_state" "sg" {
  backend = "s3"

  config {
    bucket = "megun-system01-terraform-tfstate"
    key    = "env/${terraform.workspace}/terraform.tfstate/SecurityGroup"
    region = "ap-northeast-1"
  }
}

data "terraform_remote_state" "Storage" {
  backend = "s3"

  config {
    bucket = "megun-system01-terraform-tfstate"
    key    = "env/${terraform.workspace}/terraform.tfstate/Storage"
    region = "ap-northeast-1"
  }
}
