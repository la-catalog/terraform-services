# terraform-services
Cria todos os serviços dos quais la-catalog precisa em uma máquina.  

## SSH
Adiciona sua chave à máquina remota: `ssh-copy-id machine_user@192.168.0.1`  
Caso você não tenha uma chave: `ssh-keygen`  

**Referencia**: https://github.com/hashicorp/terraform-provider-docker/issues/259#issuecomment-678267234  

## Setup
Cria o arquivo `terraform.tfvars` com os segredos, exemplo:  

```conf
influx_user="user"
influx_pass="password"
mongo_user="user"
mongo_pass="password"
rabbit_user="user"
rabbit_pass="password"
```