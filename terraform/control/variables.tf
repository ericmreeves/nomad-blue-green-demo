variable "owner_name" {}
variable "owner_email" {}
variable "region" {}
variable "availability_zones" {}
variable "ami" {}
variable "key_name" {}
variable "route53_zone_id" {}
variable "webapp_dnsname" {}

variable "stack_name" {
  default = "hashistack"
}
