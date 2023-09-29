resource "aws_resourcegroups_group" "resourcegroups_group" {
  name = "${var.prefix}-group"
  resource_query {
    query = templatefile("${path.module}/templates/resource-group.json", {
      example = var.prefix
    })
  }
  tags = {
    git_repo  = "terraform-aws-github-runner"
    yor_trace = "4b259117-7e61-4d98-88a9-cddf1c8e2ecc"
  }
}
