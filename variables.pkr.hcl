packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

# locals {
#   packages = "amazon-efs-utils amazon-ssm-agent amazon-ec2-net-utils acpid"
# }

variable "additional_packages" {
  type        = string
  description = "Additional packages to be installed with apt"
  default     = ""
}

variable "ami_name_prefix" {
  type        = string
  description = "Outputted AMI name prefix."
  default     = "ubuntu-noble-24.04-amd64-server"
}

variable "ami_version" {
  type        = string
  description = "Outputted AMI version."
}

variable "region" {
  type        = string
  description = "Region to build the AMI in."
}

variable "block_device_size_gb" {
  type        = number
  description = "Size of the root block device."
  default     = 30
}

# TODO: need to install this manually
# variable "ecs_agent_version" {
#   type        = string
#   description = "ECS agent version to build AMI with."
#   default     = "1.84.0"
# }
#
# variable "ecs_init_rev" {
#   type        = string
#   description = "ecs-init package version rev"
#   default     = "1"
# }

variable "docker_version" {
  type        = string
  description = "Docker version to build Ubuntu 24.04 Server AMI with."
  default     = "25.0.3"
}

variable "containerd_version" {
  type        = string
  description = "Containerd version to build Ubuntu 24.04 Server AMI with."
  default     = "1.7.11"
}

variable "runc_version" {
  type        = string
  description = "Runc version to build Ubuntu 24.04 Server (64bit) AMI with."
  default     = "1.1.11"
}

# NOTE: pre-installed as a snap
# variable "exec_ssm_version" {
#   type        = string
#   description = "SSM binary version to build ECS exec support with."
#   default     = "3.2.2303.0"
# }

variable "source_ami" {
  type        = string
  description = "Ubuntu 24.04 Server (64bit) source AMI to build from."
}

# TODO: need this stuff?
# variable "source_ami_arm" {
#   type        = string
#   description = "Ubuntu 24.04 Server (64bit) ARM source AMI to build from."
# }
# NOTE: this is used for a dnf thing only.
# variable "distribution_release" {
#   type        = string
#   description = "Ubuntu 24.04 Server (64bit) distribution release."
# }
# NOTE: kernel version used for AL2023 AMI name, ignore for now cause ubuntu
# variable "kernel_version" {
#   type        = string
#   description = "Ubuntu 24.04 Server (64bit) kernel version."
# }
# variable "kernel_version_arm" {
#   type        = string
#   description = "Ubuntu 24.04 Server (64bit) ARM kernel version."
# }

variable "air_gapped" {
  type        = string
  description = "If this build is for an air-gapped region, set to 'true'"
  default     = ""
}

# TODO: need this stuff?
# variable "ecs_init_url" {
#   type        = string
#   description = "Specify a particular ECS init URL for Ubuntu 24.04 Server (64bit) to install. If empty it will use the standard path."
#   default     = ""
# }
#
# variable "ecs_init_local_override" {
#   type        = string
#   description = "Specify a local init rpm under /additional-packages to be used for building AL2 and Ubuntu 24.04 Server (64bit) AMIs. If empty it will use ecs_init_url if specified, otherwise the standard path"
#   default     = ""
# }

variable "general_purpose_instance_types" {
  type        = list(string)
  description = "List of available in-region instance types for general-purpose platform"
  default     = ["t3a.medium"]
}

# TODO: need this stuff?
# variable "gpu_instance_types" {
#   type        = list(string)
#   description = "List of available in-region instance types for GPU platform"
#   default     = ["c5.4xlarge"]
# }
#
# variable "arm_instance_types" {
#   type        = list(string)
#   description = "List of available in-region instance types for ARM platform"
#   default     = ["m6g.xlarge"]
# }
#
# variable "inf_instance_types" {
#   type        = list(string)
#   description = "List of available in-region instance types for INF platform"
#   default     = ["inf1.xlarge"]
# }
#
# variable "neu_instance_types" {
#   type        = list(string)
#   description = "List of available in-region instance types for NEU platform"
#   default     = ["inf1.xlarge"]
# }
#
variable "managed_daemon_base_url" {
  type        = string
  description = "Base URL (minus file name) to download managed daemons from."
  default     = ""
}

variable "ebs_csi_driver_version" {
  type        = string
  description = "EBS CSI driver version to build AMI with."
  default     = ""
}
