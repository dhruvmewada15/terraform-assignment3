variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "public_subnet1_cidr" {
    default = "10.0.9.0/24"
}

variable "public_subnet2_cidr" {
    default = "10.0.2.0/24"
}

variable "public_subnet3_cidr" {
    default = "10.0.3.0/24"
}

variable "private_subnet1_cidr" {
    default = "10.0.4.0/24"
}

variable "private_subnet2_cidr" {
    default = "10.0.5.0/24"
}

variable "private_subnet3_cidr" {
    default = "10.0.6.0/24"
}

variable "my_ip_addr" {
    default = "27.106.11.197/32"
}