variable aws_reg {
  description = "Região AWS"
  default     = "us-east-1"
  type        = string
}

variable stack {
  description = "Prefixo"
  default     = "terraform"
}

variable username {
  default = "wordpress"
  description = "Usuario do Banco de Dados"
}

variable password {
  default = "wpdbpasswd"
  description = "Senha do Banco de Dados"
}

variable dbname {
  default = "wordpress"
  description = "Nome do Banco de Dados"
}