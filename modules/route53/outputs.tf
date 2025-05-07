output "zone_id" {
  description = "The ID of the created Route53 hosted zone"
  value       = aws_route53_zone.this.zone_id
}

output "zone_name" {
  description = "The domain name of the hosted zone"
  value       = aws_route53_zone.this.name
}
