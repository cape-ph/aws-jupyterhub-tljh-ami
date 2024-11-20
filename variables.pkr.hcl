packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

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

#TODO: ISSUE #2
#TODO: ISSUE #4
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

variable "source_ami" {
  type        = string
  description = "Ubuntu 24.04 Server (64bit) source AMI to build from."
}

variable "air_gapped" {
  type        = string
  description = "If this build is for an air-gapped region, set to 'true'"
  default     = ""
}

variable "general_purpose_instance_types" {
  type        = list(string)
  description = "List of available in-region instance types for general-purpose platform"
  default     = ["t3a.medium"]
}

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
