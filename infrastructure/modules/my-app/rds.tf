resource "aws_db_subnet_group" "db_subnet" {
  name       = "app-database"
  subnet_ids = [aws_subnet.private_subnet[0].id, aws_subnet.private_subnet[1].id]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "app_db" {
  identifier             = "app-database"
  db_name                = "appdb"
  instance_class         = "db.t3.micro"
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "8.0"
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids = [aws_security_group.sg.id]
  parameter_group_name   = aws_db_parameter_group.db_para.name
  publicly_accessible    = false
  skip_final_snapshot    = true
  # final_snapshot_identifier = "db-snap-${t}"
  backup_retention_period = 7
}

resource "aws_db_parameter_group" "db_para" {
  name   = "data-para"
  family = "mysql8.0"

  parameter {
    name  = "slow_query_log"
    value = "1"
  }
  parameter {
    name  = "long_query_time"
    value = "2"
  }
}

resource "aws_secretsmanager_secret" "rds_secret" {
  description = "RDS credentials for MySQL database"
  tags = {
    Name = "My RDS Secret"
  }
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id = aws_secretsmanager_secret.rds_secret.id
  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
  })
}