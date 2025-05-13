resource "aws_db_subnet_group" "aurora_subnet_group" {
  name       = "${var.project_name}-${var.env}-aurora-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.project_name}-${var.env}-aurora-subnet-group"
  }
}

resource "aws_rds_cluster" "aurora" {
  cluster_identifier      = "${var.project_name}-aurora-db-${var.env}"
  engine                  = "aurora-mysql"
  engine_mode             = "provisioned"
  engine_version          = "5.7.mysql_aurora.2.03.2"
  database_name           = var.db_name
  master_username         = var.db_username
  master_password         = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.aurora_subnet_group.name
  vpc_security_group_ids  = var.security_group_ids
  skip_final_snapshot     = true

  tags = {
    Name = "${var.project_name}-aurora-db-${var.env}"
  }
}

resource "aws_rds_cluster_instance" "aurora_instances" {
  count              = var.instance_count
  identifier         = "${var.project_name}-aurora-instance-${count.index + 1}-${var.env}"
  cluster_identifier = aws_rds_cluster.aurora.id
  instance_class     = var.instance_class
  engine             = aws_rds_cluster.aurora.engine
  engine_version     = aws_rds_cluster.aurora.engine_version
  publicly_accessible = false

  tags = {
    Name = "${var.project_name}-aurora-instance-${count.index + 1}-${var.env}"
  }
}
