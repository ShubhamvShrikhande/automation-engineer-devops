resource "aws_ecr_repository" "flask_app" {
  name = "${var.project_name}-flask-app"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "Flask ECR Repo"
    Project = var.project_name
  }
}
