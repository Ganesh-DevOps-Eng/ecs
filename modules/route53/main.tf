resource "aws_route53_zone" "this" {
  name = var.domain_name

  tags = {
    Name        = "${var.project_name}-${var.env}-zone"
    Environment = var.env
  }
}

resource "aws_route53_record" "records" {
  count   = length(var.records)
  zone_id = aws_route53_zone.this.zone_id
  name    = lookup(var.records[count.index], "name", "")
  type    = lookup(var.records[count.index], "type", "A")
  ttl     = lookup(var.records[count.index], "ttl", 300)
  records = lookup(var.records[count.index], "records", [])

  # Optional: alias support
  dynamic "alias" {
    for_each = lookup(var.records[count.index], "alias", null) != null ? [1] : []
    content {
      name                   = var.records[count.index].alias.name
      zone_id                = var.records[count.index].alias.zone_id
      evaluate_target_health = lookup(var.records[count.index].alias, "evaluate_target_health", false)
    }
  }
}
