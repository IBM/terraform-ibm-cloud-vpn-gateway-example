variable "vpc_region" {
  type    = string
  default = "us-south"
}

variable "zone_name" {
  type = string
  default = "us-south-2"
}

variable "mode" {
  type = string
  default = "route"
}

variable "peer_address" {
  type = string
}

variable "local_cidrs" {
  type = list(string)
  nullable = true
  default=[]
}

variable "peer_cidrs" {
  type = list(string)
  nullable = true
  default=[]
}

variable "preshared_key" {
  type = string
  default = "fake-pwd"
}
