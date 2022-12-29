# ecr.tf | Elastic Container Repository

resource "aws_ecr_repository" "aws-ecr" {
  name = "${var.app_name}-${var.app_environment}-ecr"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  
  tags = {
    Name        = "${var.app_name}-ecr"
    Environment = var.app_environment
  }
}
