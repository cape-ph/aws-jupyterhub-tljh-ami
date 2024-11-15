locals {
  ami_name = "${var.ami_name_prefix}-${var.ami_version}"
  # ami_name = "${var.ami_name_prefix}-hvm-2023.0.${var.ami_version}${var.kernel_version}-x86_64"
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
    device_name           = "/dev/xvda"
  }
  region = var.region
  source_ami_filter {
    filters = {
      name = "${var.source_ami}"
      root-device-type = "ebs"
      virtualization-type = "hvm"
    }
    # TODO: may need ubuntu's account id here instead of "ubuntu"
    owners             = ["ubuntu"]
    most_recent        = true
  }
    #  ssh_interface = "public_ip"
  ssh_username  = "ubuntu"
  tags = {
    os_version          = "Ubuntu 24.04"
    source_image_name   = "{{ .SourceAMIName }}"
        #ecs_runtime_version = "Docker version ${var.docker_version}"
        #ecs_agent_version   = "${var.ecs_agent_version}"
    ami_type            = "ubuntu2404"
    ami_version         = "${var.ami_version}"
  }
}

build {
  sources = [
    "source.amazon-ebs.ubuntu2404",
  ]
    
  # TODO: install tljh, docker, ecs agent

  provisioner "shell" {
    script = "scripts/install-docker.sh"
  #   environment_vars = [
  #     "DOCKER_VERSION=${var.docker_version}",
  #     "CONTAINERD_VERSION=${var.containerd_version}",
  #     "RUNC_VERSION=${var.runc_version}",
  #     "AIR_GAPPED=${var.air_gapped}"
  #   ]
  }

  provisioner "shell" {
    script = "scripts/install-ecs-agent.sh"
  }

  provisioner "shell" {
    script = "scripts/install-tljh.sh"
  }

  # provisioner "file" {
  #   source      = "files/90_ecs.cfg.amzn2"
  #   destination = "/tmp/90_ecs.cfg"
  # }
  #
  # provisioner "shell" {
  #   inline_shebang = "/bin/sh -ex"
  #   inline = [
  #     "sudo mv /tmp/90_ecs.cfg /etc/cloud/cloud.cfg.d/90_ecs.cfg",
  #     "sudo chown root:root /etc/cloud/cloud.cfg.d/90_ecs.cfg"
  #   ]
  # }
  #
  # provisioner "shell" {
  #   script = "scripts/setup-motd.sh"
  # }
  #
  # provisioner "shell" {
  #   inline_shebang = "/bin/sh -ex"
  #   inline = [
  #     "mkdir /tmp/additional-packages",
  #     "mkdir /tmp/additional-scripts"
  #   ]
  # }
  #
  # provisioner "shell" {
  #   inline_shebang = "/bin/sh -ex"
  #   inline = [
  #     "sudo dnf update -y --releasever=${var.distribution_release}"
  #   ]
  # }
  #
  # provisioner "file" {
  #   source      = "additional-packages/"
  #   destination = "/tmp/additional-packages"
  # }
  #
  # provisioner "file" {
  #   source      = "scripts/additional-scripts/"
  #   destination = "/tmp/additional-scripts"
  # }
  #
  # provisioner "shell" {
  #   inline_shebang = "/bin/sh -ex"
  #   inline = [
  #     "sudo dnf install -y ${local.packages} ${var.additional_packages}",
  #     "sudo dnf swap -y gnupg2-minimal gnupg2-full"
  #   ]
  # }
  #
  # provisioner "shell" {
  #   script = "scripts/setup-ecs-config-dir.sh"
  # }
  #
  # provisioner "shell" {
  #   script = "scripts/install-docker.sh"
  #   environment_vars = [
  #     "DOCKER_VERSION=${var.docker_version}",
  #     "CONTAINERD_VERSION=${var.containerd_version}",
  #     "RUNC_VERSION=${var.runc_version}",
  #     "AIR_GAPPED=${var.air_gapped}"
  #   ]
  # }
  #
  # provisioner "shell" {
  #   script = "scripts/install-ecs-init.sh"
  #   environment_vars = [
  #     "REGION=${var.region}",
  #     "AGENT_VERSION=${var.ecs_agent_version}",
  #     "INIT_REV=${var.ecs_init_rev}",
  #     "AL_NAME=amzn2023",
  #     "ECS_INIT_URL=${var.ecs_init_url}",
  #     "AIR_GAPPED=${var.air_gapped}",
  #     "ECS_INIT_LOCAL_OVERRIDE=${var.ecs_init_local_override}"
  #   ]
  # }
  #
  # provisioner "shell" {
  #   script = "scripts/install-managed-daemons.sh"
  #   environment_vars = [
  #     "REGION=${var.region}",
  #     "AGENT_VERSION=${var.ecs_agent_version}",
  #     "EBS_CSI_DRIVER_VERSION=${var.ebs_csi_driver_version}",
  #     "AIR_GAPPED=${var.air_gapped}",
  #     "MANAGED_DAEMON_BASE_URL=${var.managed_daemon_base_url}"
  #   ]
  # }
  #
  # provisioner "shell" {
  #   script = "scripts/append-efs-client-info.sh"
  # }
  #
  # provisioner "shell" {
  #   script = "scripts/install-additional-packages.sh"
  # }
  #
  # provisioner "shell" {
  #   script = "scripts/additional-scripts.sh"
  #   environment_vars = [
  #     "AMI_PREFIX=${var.ami_name_prefix}",
  #   ]
  # }
  #
  # ### exec
  #
  # provisioner "file" {
  #   source      = "files/amazon-ssm-agent.gpg"
  #   destination = "/tmp/amazon-ssm-agent.gpg"
  # }
  #
  # provisioner "shell" {
  #   script = "scripts/install-exec-dependencies.sh"
  #   environment_vars = [
  #     "REGION=${var.region}",
  #     "EXEC_SSM_VERSION=${var.exec_ssm_version}",
  #     "AIR_GAPPED=${var.air_gapped}"
  #   ]
  # }
  #
  # ### reboot worker instance to install kernel update. enable-ecs-agent-inferentia-support needs
  # ### new kernel (if there is) to be installed.
  # provisioner "shell" {
  #   inline_shebang    = "/bin/sh -ex"
  #   expect_disconnect = "true"
  #   inline = [
  #     "sudo reboot"
  #   ]
  # }
  #
  # provisioner "shell" {
  #   environment_vars = [
  #     "AMI_TYPE=${source.name}"
  #   ]
  #   pause_before        = "10s" # pause for starting the reboot
  #   start_retry_timeout = "40s" # wait before start retry
  #   max_retries         = 3
  #   script              = "scripts/enable-ecs-agent-inferentia-support.sh"
  # }
  #
  # provisioner "shell" {
  #   inline_shebang = "/bin/sh -ex"
  #   inline = [
  #     "sudo usermod -a -G docker ec2-user"
  #   ]
  # }
  #
  # provisioner "shell" {
  #   script = "scripts/enable-services.sh"
  # }
  #
  # provisioner "shell" {
  #   script = "scripts/install-service-connect-appnet.sh"
  # }
  #
  # provisioner "shell" {
  #   script = "scripts/cleanup.sh"
  # }
  #
  post-processor "manifest" {
    output     = "manifest.json"
    strip_path = true
  }
}
