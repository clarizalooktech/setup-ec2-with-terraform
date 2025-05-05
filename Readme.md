# Terraform AWS EC2 Deployment

This project provides Terraform configurations to deploy an EC2 instance in AWS with all necessary networking components.

## Architecture

The infrastructure provisions the following resources:

![AWS Infrastructure Diagram](https://github.com/clarizalooktech/setup-ec2-with-terraform/blob/main/assets/design.jpg)

*Note: The image above is a visual representation of the infrastructure this Terraform code creates.*

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed (v1.0+)
- AWS account and credentials configured
- SSH key pair for EC2 access

## File Structure

```
terraform-ec2-project/
├── main.tf           # Main configuration file with all resources
├── variables.tf      # Variable declarations with descriptions and defaults
├── terraform.tfvars  # Variable values customized for your environment
└── README.md         # This file
```

## Resources Created

- VPC with CIDR 10.0.0.0/16
- Public subnet with CIDR 10.0.1.0/24
- Internet Gateway
- Route Table
- Security Group (SSH, HTTP, HTTPS)
- EC2 instance with Apache web server

## Authentication

Terraform uses AWS credentials configured through one of these methods:

1. **Environment variables**:
   ```
   export AWS_ACCESS_KEY_ID="your_access_key"
   export AWS_SECRET_ACCESS_KEY="your_secret_key"
   ```

2. **AWS CLI configuration** (Recommended):
   ```
   aws configure
   ```
   
3. **AWS profiles** (for multiple accounts):
   ```hcl
   # In main.tf
   provider "aws" {
     region  = var.region
     profile = "my-profile-name"
   }
   ```

## Usage

1. **Clone this repository**:
   ```bash
   git clone <repository-url>
   cd terraform-ec2-project
   ```

2. **Update terraform.tfvars**:
   Customize the variables for your environment, including:
   - AWS region
   - Instance type
   - AMI ID
   - SSH key name
   - Tags

3. **Update SSH key path**:
   In `main.tf`, ensure the path to your public SSH key is correct:
   ```hcl
   resource "aws_key_pair" "deployer" {
     key_name   = "ec2-key-pair"
     public_key = file("~/.ssh/id_rsa.pub")  # Update this path
   }
   ```

4. **Initialize Terraform**:
   ```bash
   terraform init
   ```

5. **Plan the deployment**:
   ```bash
   terraform plan
   ```

6. **Apply the configuration**:
   ```bash
   terraform apply
   ```

7. **Access your EC2 instance**:
   ```bash
   ssh -i ~/.ssh/id_rsa ec2-user@<instance_public_ip>
   ```
   The instance public IP will be displayed in the output after successful deployment.

8. **View the web server**:
   Open a browser and navigate to `http://<instance_public_ip>`

## Cleanup

To destroy all created resources:

```bash
terraform destroy
```

## Customization Options

- **Change the instance type**: Update the `instance_type` variable in `terraform.tfvars`
- **Modify security groups**: Edit the ingress/egress rules in `main.tf`
- **Change AMI**: Update the `ami_id` variable in `terraform.tfvars`
- **Additional tags**: Add more tags in the `tags` variable in `terraform.tfvars`

## Security Considerations

- The current security group allows SSH access from anywhere (0.0.0.0/0). For production, restrict this to specific IPs.
- Consider using AWS Systems Manager Session Manager instead of direct SSH access.
- Implement proper IAM roles and policies for the EC2 instance.

## Troubleshooting

- **Connection issues**: Ensure security groups allow traffic on the required ports.
- **Failed deployment**: Check AWS credentials and permissions.
- **SSH connection errors**: Verify the key pair name and path to your private key.

## Support

For questions or issues, please open an issue in the repository or contact the project maintainer.