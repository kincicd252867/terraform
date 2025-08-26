#AWS region
variable "region" {
  type    = string
  default = "ap-southeast-1"
}

#AWS EC2
variable "instance_type" {
  description = "ec2 for test in public subnet"
  type        = string
  default     = "t3.micro"
}

variable "ec2_instance_name" {
  description = "Name of the EC2 instance"
  default     = "local-demo"
}

variable "instance_count" {
  description = "my instance type"
  type        = number
  default     = 1
}


variable "project_name" {
  description = "Location of server"
  type        = string
  default     = "Project_Name"
}

variable "environment" {
  description = "Name of server"
  type        = string
  default     = "dev"
}

variable "vpc_cidrs_subnet" {
  description = "List of CIDR blocks, functions of enable dns and enable classiclink"
  type = object({
    cidr_block           = string
    enable_dns_support   = bool
    enable_dns_hostnames = bool
    enable_classiclink   = bool
  })
  default = {
    cidr_block           = "10.0.0.0/16"
    enable_dns_support   = true
    enable_dns_hostnames = true
    enable_classiclink   = false
  }
}

variable "dev-public_subnet_cidrs" {
  description = "Public Subnet CIDR values"
  type = object({
    cidr_block              = list(string)
    map_public_ip_on_launch = bool
  })
  default = {
    cidr_block              = ["10.0.1.0/24", "10.0.2.0/24"]
    map_public_ip_on_launch = true
  }
}

variable "dev-private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["ap-southeast-1a", "ap-southeast-1b"]
}

variable "alarmsphoneno" {
  type    = string
  default = "+85368538139"
}

variable "health_check_path" {
  description = "Health check path for the default target group"
  default     = "/"
}

# auto scaling
variable "autoscale_min" {
  description = "Minimum autoscale (number of EC2)"
  default     = "2"
}
variable "autoscale_max" {
  description = "Maximum autoscale (number of EC2)"
  default     = "2"
}
variable "autoscale_desired" {
  description = "Desired autoscale (number of EC2)"
  default     = "2"
}

variable "ssh_pubkey_file" {
  description = "Path to an SSH public key"
  default     = "~/.ssh/aws/aws_key.pub"
}










