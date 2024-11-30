resource "aws_db_subnet_group" "db_subnet" {
  name       = "app-database"
  subnet_ids = [aws_subnet.private_subnet[0].id, aws_subnet.private_subnet[1].id]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "app_db" {
  identifier                = "tier-database"
  instance_class            = "db.t3.micro"
  allocated_storage         = 10
  engine                    = "mysql"
  engine_version            = "5.7"
  username                  = var.db_username
  password                  = var.db_password
  db_subnet_group_name      = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids    = [aws_security_group.sg.id]
  parameter_group_name      = aws_db_parameter_group.db_para.name
  publicly_accessible       = false
  skip_final_snapshot       = true
  # final_snapshot_identifier = "db-snap-${t}"
  backup_retention_period   = 7
  backup_window             = "03:00-04:00"
  maintenance_window        = "mon:04:00-mon:04:30"
}

resource "aws_db_parameter_group" "db_para" {
  name   = "data-para"
  family = "mysql5.7"

  parameter {
    name  = "slow_query_log"
    value = "1"
  }
  parameter {
    name  = "long_query_time"
    value = "2"
  }
}
