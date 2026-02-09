terraform {
  backend "s3" {
    bucket         = "terraform-state-flask-express"
    key            = "part2/terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
    use_lockfile   = true
  }
}

