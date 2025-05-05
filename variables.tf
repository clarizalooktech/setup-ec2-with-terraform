variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-southeast-2"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro" #free tier eligible
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0310483fb2b488153"  # Amazon Linux 2 AMI in ap-southeast-2
}

variable "key_name" {
  description = "Name of the key pair to use for SSH access"
  type        = string
  default     = "ec2-key-pair"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {
    Project = "terraform-ec2"
    Environment = "dev"
  }
}