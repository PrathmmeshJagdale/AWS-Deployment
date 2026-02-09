variable "region" {
  default = "us-east-2"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "github_repo" {
  default = "https://github.com/PrathmmeshJagdale/AWS-Deployment.git"
}

variable "key_name" {
  description = "Existing EC2 key pair name"
  type        = string
  default     = "terraform-key"
}

