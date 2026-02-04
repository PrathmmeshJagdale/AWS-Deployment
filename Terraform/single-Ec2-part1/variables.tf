variable "region" {
  default = "us-east-2"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "root_volume_size" {
  description = "Root EBS volume size in GB"
  type        = number
  default     = 20
}

variable "root_volume_type" {
  description = "Root EBS volume type"
  type        = string
  default     = "gp3"
}

variable "delete_root_volume_on_termination" {
  description = "Delete root volume when EC2 is terminated"
  type        = bool
  default     = true
}


  
variable "github_repo" {
  default = "https://github.com/PrathmmeshJagdale/AWS-Deployment.git"
}

