terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.53.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "openstack" {
  auth_url      = "https://10.0.2.15:5000/v3"
  tenant_name   = "admin"
  user_name     = "admin"
  password      = var.os_password
  region        = "microstack"
  insecure      = true
  endpoint_type = "public"
}

provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3 = "http://127.0.0.1:4566"
  }
}

resource "openstack_compute_instance_v2" "test_instance" {
  name      = "terraform-vm"
  image_id  = "87eca0da-a842-4a77-aa3b-1615ed486999"
  flavor_id = "1"

  network {
    name = "private-net"
  }
}

resource "openstack_compute_instance_v2" "test_instance_2" {
  name      = "terraform-vm-2"
  image_id  = "87eca0da-a842-4a77-aa3b-1615ed486999"
  flavor_id = "1"

  network {
    name = "private-net"
  }
}

resource "aws_s3_bucket" "cloud_storage" {
  bucket = "intern-multicloud-demo"
}
