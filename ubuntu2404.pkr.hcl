locals {
  # TODO: ISSUE #3
  ami_name = "${var.ami_name_prefix}-${var.ami_version}"
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "ubuntu2404" {
  ami_name        = "${local.ami_name}.${local.timestamp}"
  ami_description = "Ubuntu 24.04 (64bit) server ${var.ami_version} x86_64 ECS HVM EBS"
  instance_type   = var.general_purpose_instance_types[0]
  launch_block_device_mappings {
    volume_size           = var.block_device_size_gb
    delete_on_termination = true
    volume_type           = "gp3"
    device_name           = "/dev/sda1"
  }
  region = var.region
  source_ami_filter {
    filters = {
      name = "${var.source_ami}"
      root-device-type = "ebs"
      virtualization-type = "hvm"
    }
    # NOTE: this is the marketplace account number for ubuntu
    owners             = ["099720109477"]
    most_recent        = true
  }
  ssh_interface = "public_ip"
  ssh_username  = "ubuntu"
  tags = {
    os_version          = "Ubuntu 24.04"
    source_image_name   = "{{ .SourceAMIName }}"
    ami_type            = "ubuntu2404"
    ami_version         = "${var.ami_version}"
  }
}

build {
  sources = [
    "source.amazon-ebs.ubuntu2404",
  ]
    
  # TODO: install tljh, docker, ecs agent
  
  # get os and pre-installs up to date
  provisioner "shell" {
    inline_shebang = "/bin/sh -ex"
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get -y upgrade",
    ]
  }

  provisioner "shell" {
    script = "scripts/install-docker.sh"
  }

  provisioner "shell" {
    script = "scripts/install-ecs-agent.sh"
  }

  provisioner "shell" {
    script = "scripts/install-tljh.sh"
  }

  post-processor "manifest" {
    output     = "manifest.json"
    strip_path = true
  }
}
