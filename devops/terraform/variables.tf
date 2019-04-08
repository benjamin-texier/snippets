variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_key_path" {}
variable "aws_key_name" {}

// Région utilisée pour notre application. Ici Paris
variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "eu-west-3"
}

// Zone utilisée pour notre application. Ici Paris
variable "availability_zones" {
    description = "EC2 Region for the VPC"
    default = "eu-west-3a"
}

// Permet de gérer les AMIs pour plusieurs régions
variable "amis" {
    description = "AMIs by region"
    default = {
        eu-west-3 = "ami-0a3ac782127380412" # debian 9
    }
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.0.1.0/24"
}

variable "subnet_cidr" {
    description = "CIDR for the Subnet"
    default = "10.0.1.0/24"
}
