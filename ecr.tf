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


resource "aws_ecr_lifecycle_policy" "repo_policy" {
  repository = aws_ecr_repository.aws-ecr.name
  policy     = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images older than 14 days",
            "selection": {
                "tagStatus": "any",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 14
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
