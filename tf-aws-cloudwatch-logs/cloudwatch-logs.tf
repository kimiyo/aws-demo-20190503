resource "aws_cloudwatch_log_group" "test-cw-log-group" {
  name = "/test/cw/log/group"

  tags = {
    Environment = "production"
    Application = "jh-app"
  }
}
