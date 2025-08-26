resource "aws_cloudwatch_metric_alarm" "instance-health-check_i-05fe35a8cf98e760d" {
  alarm_name          = "instance-health-check"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "1"
  alarm_description   = "This metric monitors ec2 health status"
  alarm_actions       = [aws_sns_topic.my_topic.arn]

  dimensions = {
    InstanceId = "i-05fe35a8cf98e760d"
  }
}

resource "aws_cloudwatch_metric_alarm" "instance-health-check_i-0975e43f474d1ea83" {
  alarm_name          = "instance-health-check"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "1"
  alarm_description   = "This metric monitors ec2 health status"
  alarm_actions       = [aws_sns_topic.my_topic.arn]

  dimensions = {
    InstanceId = "i-0975e43f474d1ea83"
  }
}