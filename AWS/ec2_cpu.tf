resource "aws_cloudwatch_dashboard" "local_demo-dashboard" {
  dashboard_name = "local_demo-dashboard-${var.ec2_instance_name}"
  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            [
              "AWS/EC2",
              "CPUUtilization",
              "InstanceId",
              "${var.ec2_instance_name}"
            ]
          ]
          period = 300
          stat   = "Average"
          region = "ap-southeast-1"
          title  = "${var.ec2_instance_name} - CPU Utilization"
        }
      },
      {
        type   = "text"
        x      = 0
        y      = 7
        width  = 3
        height = 3

        properties = {
          markdown = "Local Demo Dashboard"
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            [
              "AWS/EC2",
              "NetworkIn",
              "InstanceId",
              "${var.ec2_instance_name}"
            ]
          ]
          period = 300
          stat   = "Average"
          region = "${var.region}"
          title  = "${var.ec2_instance_name} - NetworkIn"
        }
      }
    ]
  })
}

resource "aws_sns_topic" "my_topic" {
  name = "EC2InstancesAlarm"

    delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false,
    "defaultThrottlePolicy": {
      "maxReceivesPerSecond": 1
    }
  }
}
EOF
}

resource "aws_sns_topic_subscription" "sms_subscriber" {
  topic_arn = aws_sns_topic.my_topic.arn
  protocol  = "sms"
  endpoint  = "+85368538139"  # Your Macau phone number
}

resource "aws_cloudwatch_metric_alarm" "ec2_cpu_utilization_i-05fe35a8cf98e760d" {
  alarm_name          = "EC2_CPU_Utilization_Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  count = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ec2 cpu utilization reaches 80%"
  alarm_actions = [aws_sns_topic.my_topic.arn]
  dimensions = {
    InstanceId = "i-05fe35a8cf98e760d"
  }
}

resource "aws_cloudwatch_metric_alarm" "ec2_cpu_utilization_i-0975e43f474d1ea83" {
  alarm_name          = "EC2_CPU_Utilization_Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  count = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ec2 cpu utilization reaches 80%"
  alarm_actions = [aws_sns_topic.my_topic.arn]
  dimensions = {
    InstanceId = "i-0975e43f474d1ea83"
  }
}

