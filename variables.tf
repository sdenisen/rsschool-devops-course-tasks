variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "az_1" {
  description = "AZ-1 to use"
  type = string
  default = "eu-west-1a"
}

variable "az_2" {
  description = "AZ-2 to use"
  type = string
  default = "eu-west-1b"
}

variable private_subten_1 {
  description = "CIDR block for private subnet-1"
  type = string
  default = "10.0.101.0/24"
}

variable private_subten_2 {
  description = "CIDR block for private subnet-2"
  type = string
  default = "10.0.102.0/24"
}

variable public_subnet_1 {
  description = "CIDR block for public subnet-1"
  type= string
  default = "10.0.1.0/24"
}

variable public_subnet_2 {
  description = "CIDR block for public subnet-2"
  type= string
  default = "10.0.2.0/24"
}