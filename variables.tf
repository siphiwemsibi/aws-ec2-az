variable "region" {
  default = "af-south-1"
}

variable "ami_id" {
  default     = "ami-0aada2b7fc7573003"
  description = "specific ami ID, this one is LRHE"
}

variable "subnet_ids" {
  default = ["subnet-0a01cdf1a7fd22b20", "subnet-06319c1a473a03935"]
}

variable "instance_type" {
  default = "t3.2xlarge"
}

variable "key_name" {
  default = "firco-key"
}

variable "sec_group" {
  default = "firco-sec"
}

variable "vpc_id" {
  default = "vpc-04dee187fd5e82d8e"
}

variable "my_name" {
  default = "Siphiwe"
}