resource "aws_ssm_parameter" "runner_config_run_as" {
  name  = "/${var.prefix}/runner/run-as"
  type  = "String"
  value = var.runner_as_root ? "root" : var.runner_run_as
  tags = merge(local.tags, {
    git_repo  = "terraform-aws-github-runner"
    yor_trace = "2cfbf7fc-c62a-497e-93c4-c36c5e1762c3"
  })
}

resource "aws_ssm_parameter" "runner_agent_mode" {
  name  = "/${var.prefix}/runner/agent-mode"
  type  = "String"
  value = var.enable_ephemeral_runners ? "ephemeral" : "persistent"
  tags = merge(local.tags, {
    git_repo  = "terraform-aws-github-runner"
    yor_trace = "e6a4d911-7fc4-4974-bd97-908e804adc72"
  })
}

resource "aws_ssm_parameter" "runner_enable_cloudwatch" {
  name  = "/${var.prefix}/runner/enable-cloudwatch"
  type  = "String"
  value = var.enable_cloudwatch_agent
  tags = merge(local.tags, {
    git_repo  = "terraform-aws-github-runner"
    yor_trace = "3292334a-7d16-48f6-9fec-b23cf7d03624"
  })
}
