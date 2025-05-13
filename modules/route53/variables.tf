variable "project_name" {
  description = "Project name"
  type        = string
}

variable "env" {
  description = "Environment (e.g., dev, prod)"
  type        = string
}

variable "domain_name" {
  description = "The domain name to create the hosted zone for"
  type        = string
}

variable "records" {
  description = <<EOF
List of DNS records to create. Example:
[
  {
    name    = "app"
    type    = "A"
    ttl     = 300
    records = ["1.2.3.4"]
  },
  {
    name = "cdn"
    type = "A"
    alias = {
      name                   = "example.cloudfront.net"
      zone_id                = "Z2FDTNDATAQYW2"
      evaluate_target_health = false
    }
  }
]
EOF
  type    = list(map(any))
  default = []
}
