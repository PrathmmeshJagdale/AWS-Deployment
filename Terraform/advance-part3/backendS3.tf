terraform {
  backend "s3" {
    bucket  = "terraform-state-flask-express"
    key     = "part3/terraform.tfstate"
    region  = "us-east-2"
  }
}

