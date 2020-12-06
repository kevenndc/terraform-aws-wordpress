# Solicita o serviço de AWS do terraform na versão 3.7
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.7"
    }
  }
}

# Configura provider aws usando o profile contido no ~/.aws/credentials e
# Define a região das instâncias para 'us-east-1' (Virgínia)
provider "aws" {
    profile = "default"
    region = "us-east-1"
}


