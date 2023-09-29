resource "aws_ssm_parameter" "github_app_id" {
  name   = "/actions_runner/${var.prefix}/github_app_id"
  type   = "SecureString"
  value  = var.github_app.id
  key_id = local.kms_key_arn
  tags = merge(var.tags, {
    git_repo  = "terraform-aws-github-runner"
    yor_trace = "204ce065-2232-46de-96e0-67ea152e3daa"
  })
}

resource "aws_ssm_parameter" "github_app_key_base64" {
  name   = "/actions_runner/${var.prefix}/github_app_key_base64"
  type   = "SecureString"
  value  = var.github_app.key_base64
  key_id = local.kms_key_arn
  tags = merge(var.tags, {
    git_repo  = "terraform-aws-github-runner"
    yor_trace = "dcfcb0fa-16e2-46a4-a86e-aceb4374e3e1"
  })
}

resource "aws_ssm_parameter" "github_app_webhook_secret" {
  name   = "/actions_runner/${var.prefix}/github_app_webhook_secret"
  type   = "SecureString"
  value  = var.github_app.webhook_secret
  key_id = local.kms_key_arn
  tags = merge(var.tags, {
    git_repo  = "terraform-aws-github-runner"
    yor_trace = "f7cf3a24-84bb-4af3-ae5a-f36375649edd"
  })
}
