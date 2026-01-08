terraform {
  required_providers {
    archive = {
      version = ">= 2.0"
      source  = "hashicorp/archive"
    }

    genesyscloud = {
      source  = "mypurecloud/genesyscloud"
      # version = "1.72.2"
    }
  }
}

provider "genesyscloud" {
  sdk_debug = true
}
