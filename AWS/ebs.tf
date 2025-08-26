resource "aws_ebs_volume" "local_demo-ebs" {
  count             = 2
  availability_zone = element(var.azs, count.index)
  size              = 10
  type              = "gp2"
}

resource "aws_volume_attachment" "local_demo-ebs-attachment" {
  count       = 2
  device_name = "/dev/xvdh"
  instance_id = "${aws_instance.local_demo.*.id[count.index]}"
  volume_id   = "${aws_ebs_volume.local_demo-ebs.*.id[count.index]}"
}
