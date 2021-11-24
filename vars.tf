
variable "profile" {
  description = "AWS profile"
  type        = string
  default     = "default"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = ""
}

variable "ssh_key_name" {
  description = "ssh pem key file"
  type        = string
  default     = ""
}

variable "ami" {
  description = "Amazon Machine Image identifier, unqiue to each AZ"
  type        = string
  default     = ""
}

variable "inst_type" {
  description = "EC2 instance type"
  type        = string
  default     = ""
}

variable "spot_price_max" {
  description = "max spot price"
  type        = string
  default     = ""
}
