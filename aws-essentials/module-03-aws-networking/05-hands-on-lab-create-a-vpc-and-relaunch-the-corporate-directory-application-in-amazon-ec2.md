# Hands-On Lab: Create a VPC and Relaunch the Corporate Directory Application in Amazon EC2

## Visão Geral

Neste laboratório prático, você criará uma **VPC personalizada** com sub-redes públicas e privadas, configurará um **Internet Gateway**, **Route Tables**, **NAT Gateway** e **Security Groups**. Em seguida, você relançará a aplicação Employee Directory em uma instância EC2 dentro da nova VPC.

### Objetivos de Aprendizagem

- Criar uma VPC com CIDR personalizado
- Criar sub-redes públicas e privadas em múltiplas AZs
- Configurar Internet Gateway e Route Tables
- Configurar NAT Gateway para sub-redes privadas
- Configurar Security Groups para acesso web
- Lançar uma instância EC2 na VPC personalizada
- Verificar conectividade e acesso à aplicação

### Pré-requisitos

- Conta AWS ativa (ou AWS Free Tier)
- Acesso de administrador à conta
- Key Pair existente (`employee-directory-key`) ou criar um novo
- Navegador web com acesso ao AWS Management Console

## Roteiro Passo a Passo

### Passo 1: Acessar o Console do EC2

- [ ] Acesse o [AWS Management Console](https://console.aws.amazon.com/)
- [ ] Faça login com usuário administrador
- [ ] Na barra de busca, digite **VPC** e selecione **VPC**

### Passo 2: Criar a VPC

- [ ] No painel de navegação, clique em **VPC**
- [ ] Clique em **Create VPC**
- [ ] Em **Name tag**, digite `employee-directory-vpc`
- [ ] Em **IPv4 CIDR**, digite `10.0.0.0/16`
- [ ] Em **IPv6 CIDR**, deixe como padrão (nenhum)
- [ ] Clique em **Create VPC**
- [ ] Aguarde o status mudar para **available**

### Passo 3: Criar Sub-redes

- [ ] No painel de navegação, clique em **Subnets**
- [ ] Clique em **Create subnet**

#### Sub-rede Pública AZ-a:
- [ ] Em **VPC ID**, selecione `employee-directory-vpc`
- [ ] Em **Name tag**, digite `public-subnet-az-a`
- [ ] Em **Availability Zone**, selecione a primeira AZ (ex: `sa-east-1a`)
- [ ] Em **IPv4 CIDR block**, digite `10.0.1.0/24`
- [ ] Clique em **Create subnet**

#### Sub-rede Pública AZ-b:
- [ ] Clique em **Create subnet** novamente
- [ ] Em **VPC ID**, selecione `employee-directory-vpc`
- [ ] Em **Name tag**, digite `public-subnet-az-b`
- [ ] Em **Availability Zone**, selecione a segunda AZ (ex: `sa-east-1b`)
- [ ] Em **IPv4 CIDR block**, digite `10.0.2.0/24`
- [ ] Clique em **Create subnet**

#### Sub-rede Privada AZ-a:
- [ ] Clique em **Create subnet** novamente
- [ ] Em **VPC ID**, selecione `employee-directory-vpc`
- [ ] Em **Name tag**, digite `private-subnet-az-a`
- [ ] Em **Availability Zone**, selecione a primeira AZ (ex: `sa-east-1a`)
- [ ] Em **IPv4 CIDR block**, digite `10.0.10.0/24`
- [ ] Clique em **Create subnet**

#### Sub-rede Privada AZ-b:
- [ ] Clique em **Create subnet** novamente
- [ ] Em **VPC ID**, selecione `employee-directory-vpc`
- [ ] Em **Name tag**, digite `private-subnet-az-b`
- [ ] Em **Availability Zone**, selecione a segunda AZ (ex: `sa-east-1b`)
- [ ] Em **IPv4 CIDR block**, digite `10.0.11.0/24`
- [ ] Clique em **Create subnet**

### Passo 4: Criar e Associar o Internet Gateway

- [ ] No painel de navegação, clique em **Internet Gateways**
- [ ] Clique em **Create internet gateway**
- [ ] Em **Name tag**, digite `employee-directory-igw`
- [ ] Clique em **Create internet gateway**
- [ ] Com o IGW selecionado, clique em **Actions** → **Attach to VPC**
- [ ] Em **VPC**, selecione `employee-directory-vpc`
- [ ] Clique em **Attach**

### Passo 5: Configurar Route Tables

- [ ] No painel de navegação, clique em **Route Tables**
- [ ] Selecione a **tabela de rotas principal** (main) da VPC `employee-directory-vpc`
- [ ] Clique na aba **Subnet Associations**
- [ ] Clique em **Edit subnet associations**
- [ ] **Remova** a associação automática das sub-redes privadas (deixe apenas as públicas associadas à principal temporariamente)

#### Criar Route Table para Sub-redes Públicas:
- [ ] Clique em **Create route table**
- [ ] Em **Name tag**, digite `public-route-table`
- [ ] Em **VPC**, selecione `employee-directory-vpc`
- [ ] Clique em **Create**
- [ ] Com a tabela selecionada, clique na aba **Routes** → **Edit routes** → **Add route**
  - **Destination**: `0.0.0.0/0`
  - **Target**: `employee-directory-igw` (Internet Gateway)
- [ ] Clique em **Save changes**
- [ ] Clique na aba **Subnet Associations** → **Edit subnet associations**
  - Marque `public-subnet-az-a` e `public-subnet-az-b`
- [ ] Clique em **Save associations**

#### Criar Route Table para Sub-redes Privadas:
- [ ] Clique em **Create route table**
- [ ] Em **Name tag**, digite `private-route-table`
- [ ] Em **VPC**, selecione `employee-directory-vpc`
- [ ] Clique em **Create**
- [ ] Clique na aba **Subnet Associations** → **Edit subnet associations**
  - Marque `private-subnet-az-a` e `private-subnet-az-b`
- [ ] Clique em **Save associations**

### Passo 6: Criar NAT Gateway

- [ ] No painel de navegação, clique em **NAT Gateways**
- [ ] Clique em **Create NAT gateway**
- [ ] Em **Name tag**, digite `employee-directory-nat`
- [ ] Em **Subnet**, selecione `public-subnet-az-a`
- [ ] Em **Elastic IP**, clique em **Allocate Elastic IP** (ou selecione um existente)
- [ ] Clique em **Create NAT gateway**
- [ ] Aguarde o status mudar para **available** (pode levar 1-2 minutos)

### Passo 7: Configurar Rota para NAT Gateway

- [ ] No painel de navegação, clique em **Route Tables**
- [ ] Selecione a tabela `private-route-table`
- [ ] Clique na aba **Routes** → **Edit routes** → **Add route**
  - **Destination**: `0.0.0.0/0`
  - **Target**: `employee-directory-nat` (NAT Gateway)
- [ ] Clique em **Save changes**

### Passo 8: Configurar Security Groups

- [ ] No painel de navegação, clique em **Security Groups**
- [ ] Clique em **Create security group**
- [ ] Em **Name tag**, digite `employee-directory-sg`
- [ ] Em **Description**, digite `Security group for Employee Directory Application`
- [ ] Em **VPC**, selecione `employee-directory-vpc`
- [ ] Em **Inbound rules**, adicione:
  - [ ] **Type**: HTTP, **Port**: 80, **Source**: 0.0.0.0/0
  - [ ] **Type**: HTTPS, **Port**: 443, **Source**: 0.0.0.0/0
  - [ ] **Type**: SSH, **Port**: 22, **Source**: 0.0.0.0/0 (ou seu IP específico)
- [ ] Clique em **Create security group**

### Passo 9: Lançar Instância EC2 na VPC

- [ ] No painel de navegação, clique em **Instances**
- [ ] Clique em **Launch Instance**
- [ ] Em **Name**, digite `employee-directory-app`
- [ ] Em **AMI**, selecione **Amazon Linux 2**
- [ ] Em **Instance Type**, selecione **t2.micro** (eligível ao Free Tier)
- [ ] Em **Key pair**, selecione `employee-directory-key`
- [ ] Em **Network settings**, clique em **Edit**
  - Em **Network**, selecione `employee-directory-vpc`
  - Em **Subnet**, selecione `public-subnet-az-a`
  - Selecione o Security Group `employee-directory-sg`
- [ ] Em **Configure storage**, mantenha o padrão (8 GB, gp3)
- [ ] Em **Advanced details** → **User data**, cole:

```bash
#!/bin/bash
yum update -y
yum install -y python3 python3-pip git
pip3 install flask
git clone https://github.com/aws-samples/employee-directory.git /var/app
cd /var/app
nohup python3 app.py > /var/log/employee-app.log 2>&1 &
```

- [ ] Clique em **Launch Instance**

### Passo 10: Aguardar a Inicialização

- [ ] No console EC2, clique em **Instances**
- [ ] Localize a instância `employee-directory-app`
- [ ] Aguarde o status mudar de **pending** para **running** (pode levar 1-2 minutos)
- [ ] Verifique que o **Status Check** mostre **2/2 checks passed**

### Passo 11: Acessar a Aplicação

- [ ] Com a instância selecionada, copie o **IPv4 Public IP**
- [ ] Abra uma nova aba do navegador
- [ ] Cole o IP público na barra de endereças: `http://[IP-PUBLICO]`
- [ ] Aguarde alguns segundos para o servidor iniciar
- [ ] A aplicação Employee Directory deve ser exibida

### Passo 12: Verificar a Conectividade das Sub-redes

- [ ] No console VPC, clique em **Route Tables**
- [ ] Verifique:
  - [ ] A tabela `public-route-table` tem rota `0.0.0.0/0 → IGW`
  - [ ] A tabela `private-route-table` tem rota `0.0.0.0/0 → NAT Gateway`
  - [ ] As sub-redes públicas estão associadas à `public-route-table`
  - [ ] As sub-redes privadas estão associadas à `private-route-table`

## Verificação dos Resultados

| Verificação | Resultado Esperado |
|-------------|-------------------|
| VPC `employee-directory-vpc` criada (10.0.0.0/16) | ✅ Sim |
| 2 sub-redes públicas criadas em AZs diferentes | ✅ Sim |
| 2 sub-redes privadas criadas em AZs diferentes | ✅ Sim |
| Internet Gateway criado e associado à VPC | ✅ Sim |
| Route Table pública com rota 0.0.0.0/0 → IGW | ✅ Sim |
| Route Table privada com rota 0.0.0.0/0 → NAT Gateway | ✅ Sim |
| NAT Gateway criado na sub-rede pública | ✅ Sim |
| Security Group `employee-directory-sg` criado | ✅ Sim |
| Instância EC2 lançada na sub-rede pública | ✅ Sim |
| Instância em estado `running` com 2/2 checks passed | ✅ Sim |
| Aplicação acessível via IP público | ✅ Sim |
| Página Employee Directory carrega no navegador | ✅ Sim |

## Limpeza (Importante)

Para evitar custos desnecessários após o laboratório:

- [ ] Exclua a instância EC2 (selecionar instância → Instance State → Terminate)
- [ ] Exclua o NAT Gateway (selecionar → Actions → Delete)
- [ ] Libere o Elastic IP associado ao NAT Gateway
- [ ] Exclua o Internet Gateway (desassociar da VPC → Delete)
- [ ] Exclua as sub-redes, route tables e security groups criados
- [ ] Exclua a VPC `employee-directory-vpc`

## Links Oficiais

- [Amazon VPC User Guide](https://docs.aws.amazon.com/vpc/latest/userguide/vpc.html)
- [Create a VPC](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-create-vpc.html)
- [Create Subnets](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-subnets.html)
- [NAT Gateway](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway.html)
