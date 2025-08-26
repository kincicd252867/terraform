resource "aws_launch_template" "ec2-lt" {
  name_prefix   = "${var.ec2_instance_name}-instances-lt"
  image_id      = "ami-060e277c0d4cce553"
  instance_type = var.instance_type
  key_name      = aws_key_pair.local_demo.key_name

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 10
      volume_type = "gp2"
    }
  }

  user_data = base64encode(<<-EOL
    #!/bin/bash -xe
    sudo apt-get update -y
    sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update
    sudo apt-get -y install docker-ce docker-ce-cli containerd.io
    sudo service docker start
    sudo usermod -a -G docker ubuntu
    sudo chmod 666 /var/run/docker.sock
    docker pull nginx
    docker tag nginx my-nginx
    docker run --rm --name nginx-server -d -p 80:80 -t my-nginx
  EOL
  )
}

