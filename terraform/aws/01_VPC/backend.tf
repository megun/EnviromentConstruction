terraform {
  backend "s3" {
    bucket = "megun-system01-terraform-tfstate"
    key    = "terraform.tfstate/VPC"
    workspace_key_prefix = "env"
    region = "ap-northeast-1"
  }
}
