variable "project_name" {
  type = string
}

variable "env" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "san_list" {
  type    = list(string)
  default = []
}
