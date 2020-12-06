# Introdução
Este projeto utiliza o Terraform para criar um servidor web de Wordpress utilizando a infraestrutura da AWS.

**Neste projeto são utilizados os seguintes serviços da AWS:**
* VPCs;
* Subnets;
* Route Tables;
* Internet Gateway;
* NAT Gateway;
* EIP para o Gateway de NAT;
* RDS para a instância de MYSQL;
* Grupos de segurança

##Pré-requisitos
1. Par de chaves pública e privada para acessar as instâncias EC2 via SSH
2. Credenciais de usuário IAM (Identity and Access Management)

##Como utilizar

1. Clone o repositório
2. Insira seu perfil no campo `name` do arquivo `providers.tf`
3. no mesmo arquivo (`providers.tf`) troque a região no campo `region` caso seja necessário
3. No arquivo `ec2-keys.tf`, atua lize os campos `default` das variaveis **ssh_key** e **ssh_priv_key** com o caminho para os arquivos de chave pública e privada respectivamente

![](https://i.imgur.com/0w6WdpL.png)

4.  No arquivo `vars.tf`, troque as credenciais do banco de dados para as que deseje usar

![](https://i.imgur.com/OQ3j4Zv.png)

5. Abrao terminal e rode comando `terraform init` na pasta com o projeto

6. Rode `terraform apply -auto-approve` para subir a infraestrutura para a AWS

7. Depois que o Terraform subir toda a infraestrutura, é possível acessar a página de instalação do Wordpress simplesmente digitando o endereço IP da instância EC2 no navegador

![](https://imgur.com/4g5JWuR.png)

=============

