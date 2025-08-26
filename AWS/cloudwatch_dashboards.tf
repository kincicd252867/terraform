resource "aws_cloudwatch_dashboard" "ebs_dashboard_VolumeQueueLength" {
  dashboard_name = "EBS-VolumeQueueLength"
  dashboard_body = jsonencode({
    widgets = [
      {
        height = 6
        width  = 6
        y      = 0
        x      = 0
        type   = "metric"
        properties = {
          view    = "timeSeries"
          stacked = false
          metrics = [
            ["AWS/EBS", "VolumeQueueLength", "VolumeId", "vol-03f1bc7f097e29470"],
            ["AWS/EBS", "VolumeQueueLength", "VolumeId", "vol-0ff11f67f7b983d03"]
          ]
          region  = "ap-southeast-1"
        }
      }
    ]
  })
}