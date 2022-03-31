resource "github_repository" "my-cicd-repo" {
  name = var.repository
  visibility = "private"
  gitignore_template = "Terraform"
}


resource "github_user_ssh_key" "my-ssh-key" {
  title = "my-revol-ssh-key"
  key = file(var.public_key)
}


resource "github_actions_secret" "aws_access" {
  repository       = github_repository.my-cicd-repo.name
  secret_name      = "AWS_ACCESS_KEY"
  plaintext_value  = aws_iam_access_key.githubactions-access-key.id
}

resource "github_actions_secret" "aws_secret" {
  repository       = github_repository.my-cicd-repo.name
  secret_name      = "AWS_SECRET_KEY"
  plaintext_value  = aws_iam_access_key.githubactions-access-key.secret
  
}