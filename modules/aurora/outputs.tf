output "aurora_cluster_id" {
  value = aws_rds_cluster.aurora.id
}

output "aurora_endpoint" {
  value = aws_rds_cluster.aurora.endpoint
}

output "reader_endpoint" {
  value = aws_rds_cluster.aurora.reader_endpoint
}
