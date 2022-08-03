variable "vpc_cidr" {
  type    = string
  default = "10.23.45.0/24"
}

variable "vpc_id" {
  type    = string
  default = null
}

variable "secondary_vpc_cidrs" {
  type    = list(string)
  default = ["10.20.46.0/24", "10.20.47.0/24"]
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-2a", "us-east-2b"]
}

variable "private_subnets" {
  type = list(object({
    cidr                    = string
    availability_zone_index = number
    }
  ))

  default = [{
    cidr                    = "10.20.46.0/25"
    availability_zone_index = 0
    }, {
    cidr                    = "10.20.46.128/25"
    availability_zone_index = 1
  }]
}
