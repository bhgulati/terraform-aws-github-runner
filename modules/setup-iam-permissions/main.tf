data "aws_caller_identity" "current" {}

resource "aws_iam_role" "deploy" {
  name = "${var.prefix}-terraform"

  permissions_boundary = aws_iam_policy.deploy_boundary.arn
  assume_role_policy = templatefile("${path.module}/policies/assume-role-for-account.json", {
    account_id    = var.account_id
    aws_partition = var.aws_partition
  })
  tags = {
    git_repo  = "terraform-aws-github-runner"
    yor_trace = "af62e548-2266-4e9d-a118-d80292f85681"
  }
}

resource "aws_iam_policy" "boundary" {
  name = "${var.prefix}-boundary"
  path = "/${var.namespaces.boundary_namespace}/"

  policy = templatefile("${path.module}/policies/boundary.json", {
    role_namespace = var.namespaces.role_namespace
    account_id     = data.aws_caller_identity.current.account_id
    aws_partition  = var.aws_partition
  })
  tags = {
    git_repo  = "terraform-aws-github-runner"
    yor_trace = "96c653c3-ca6a-4db9-a6e2-f974154a3cd8"
  }
}

resource "aws_iam_policy" "deploy" {
  name = "${var.prefix}-terraform"
  path = "/"

  policy = templatefile("${path.module}/policies/deploy-policy.json", {
    account_id = data.aws_caller_identity.current.account_id
  })
  tags = {
    git_repo  = "terraform-aws-github-runner"
    yor_trace = "e7f3e9a5-c674-4499-bf35-2b5de3df93ab"
  }
}

resource "aws_iam_role_policy_attachment" "deploy" {
  role       = aws_iam_role.deploy.name
  policy_arn = aws_iam_policy.deploy.arn
}

resource "aws_iam_policy" "deploy_boundary" {
  name = "${var.prefix}-terraform-boundary"
  path = "/${var.namespaces.boundary_namespace}/"

  policy = templatefile("${path.module}/policies/deploy-boundary.json", {
    account_id                 = data.aws_caller_identity.current.account_id
    role_namespace             = var.namespaces.role_namespace
    policy_namespace           = var.namespaces.policy_namespace
    instance_profile_namespace = var.namespaces.instance_profile_namespace
    boundary_namespace         = var.namespaces.boundary_namespace
    permission_boundary        = aws_iam_policy.boundary.arn
    aws_partition              = var.aws_partition
  })
  tags = {
    git_repo  = "terraform-aws-github-runner"
    yor_trace = "b93a3f05-dfb5-4998-9004-219701664dd2"
  }
}
