variable "username" {
  type    = lis(string)
  default = ["user1", "user2", "user3"]
}

resource "aws_iam_user" "userList" {
  count = length(var.username)
  name  = element(var.username, count.index)
}

resource "aws_iam_group" "dev_group" {
  name = "Developer"
}

resource "aws_iam_group_membership" "user_group_membership" {
  count  = length(var.username)
  user   = element(var.username, count.index)
  groups = [aws_iam_group.dev_group.name]
}