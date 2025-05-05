region       = "ap-southeast-2"
instance_type = "t2.micro"
ami_id       = "ami-0310483fb2b488153"  # Amazon Linux 2 AMI in ap-southeast-2
key_name     = "ec2-key-pair"          # Use existing key pair name

tags = {
  Project     = "terraform-ec2"
  Environment = "dev"
  Owner       = "clarius"
}