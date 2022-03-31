
output "repo-ssh-clone-url" {
  value = github_repository.my-cicd-repo.ssh_clone_url
}
output "parameter_url" {
  value = "https://${var.region}.console.aws.amazon.com/systems-manager/parameters/${aws_ssm_parameter.my-deployment-keys.name}/description?region=eu-west-2&tab=Table"
}