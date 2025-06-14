terraform {
  backend "s3" {
    bucket         = "rs.school-bucket-777"
    key            = "rsschool-devops-course-tasks/terraform.tfstate"
    region         = "eu-north-1"
    encrypt        = true
    use_lockfile   = true
  }
}
