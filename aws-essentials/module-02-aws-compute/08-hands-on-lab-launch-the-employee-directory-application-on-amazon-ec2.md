# Hands-On Lab: Launch the Employee Directory Application on Amazon EC2

## Visão Geral

Neste laboratório prático, você lançará a **Employee Directory Application** em uma instância Amazon EC2. Você configurará uma instância Linux, instalará o servidor web, implantará a aplicação e verificará o acesso via navegador.

### Objetivos de Aprendizagem

- Lançar uma instância EC2 com Amazon Linux 2
- Configurar Security Groups para acesso web
- Usar User Data para instalar e iniciar a aplicação
- Acessar a aplicação via navegador
- Verificar o funcionamento via console

### Pré-requisitos

- Conta AWS ativa (ou AWS Free Tier)
- Acesso de administrador à conta
- Navegador web
- Chave SSH baixada (.pem) ou credenciais de console

## Roteiro Passo a Passo

### Passo 1: Acessar o Console do EC2

- [ ] Acesse o [AWS Management Console](https://console.aws.amazon.com/)
- [ ] Faça login com usuário administrador
- [ ] Na barra de busca, digite **EC2** e selecione **EC2** (Elastic Compute Cloud)

### Passo 2: Criar um Key Pair

- [ ] No painel de navegação à esquerda, clique em **Key Pairs** (em **Network & Security**)
- [ ] Clique em **Create key pair**
- [ ] Em **Name**, digite `employee-directory-key`
- [ ] Em **Key pair type**, selecione **RSA**
- [ ] Em **File format**, selecione **.pem**
- [ ] Clique em **Create key pair**
- [ ] O arquivo `.pem` será baixado automaticamente — salve em um local seguro
- [ ] No Linux/macOS, ajuste as permissões: `chmod 400 employee-directory-key.pem`

### Passo 3: Configurar o Security Group

- [ ] No painel de navegação, clique em **Security Groups**
- [ ] Clique em **Create security group**
- [ ] Em **Name**, digite `employee-directory-sg`
- [ ] Em **Description**, digite `Security group for Employee Directory Application`
- [ ] Em **Inbound rules**, adicione as seguintes regras:
  - [ ] **Type**: HTTP, **Port**: 80, **Source**: 0.0.0.0/0
  - [ ] **Type**: HTTPS, **Port**: 443, **Source**: 0.0.0.0/0
  - [ ] **Type**: SSH, **Port**: 22, **Source**: 0.0.0.0/0 (ou seu IP específico)
- [ ] Clique em **Create security group**

### Passo 4: Lançar a Instância EC2

- [ ] No painel principal, clique em **Launch Instance**
- [ ] Em **Name**, digite `employee-directory-app`
- [ ] Em **Amazon Machine Image (AMI)**, selecione **Amazon Linux 2** (ou Ubuntu Server 22.04 LTS)
- [ ] Em **Instance Type**, selecione **t2.micro** (eligível ao Free Tier)
- [ ] Em **Key pair (login)**, selecione `employee-directory-key`
- [ ] Em **Network settings**, clique em **Edit** e selecione o Security Group `employee-directory-sg`
- [ ] Em **Configure storage**, mantenha o padrão (8 GB, gp3)
- [ ] Em **Advanced details** → **User data**, cole o script abaixo:

```bash
#!/bin/bash
yum update -y
yum install -y python3 python3-pip git
pip3 install flask
# Clonar a aplicação (repositório de exemplo)
git clone https://github.com/aws-samples/employee-directory.git /var/app
cd /var/app
# Iniciar a aplicação em segundo plano
nohup python3 app.py > /var/log/employee-app.log 2>&1 &
```

- [ ] Clique em **Launch Instance**

### Passo 5: Aguardar a Inicialização

- [ ] No console EC2, clique em **Instances** no painel de navegação
- [ ] Localize a instância `employee-directory-app`
- [ ] Aguarde o status mudar de **pending** para **running** (pode levar 1-2 minutos)
- [ ] Verifique que o **Status Check** mostre **2/2 checks passed**

### Passo 6: Acessar a Aplicação

- [ ] Com a instância selecionada, copie o **IPv4 Public IP** (ou DNS público)
- [ ] Abra uma nova aba do navegador
- [ ] Cole o IP público na barra de endereços: `http://[IP-PUBLICO]`
- [ ] Aguarde alguns segundos para o servidor iniciar (User Data pode levar 1-2 minutos após o boot)
- [ ] A aplicação Employee Directory deve ser exibida

### Passo 7: Verificar o Funcionamento

- [ ] Na aba da aplicação, verifique:
  - [ ] A página inicial carrega com a lista de funcionários
  - [ ] A funcionalidade de busca funciona (digite um nome)
  - [ ] O botão "Add Employee" está visível
- [ ] No console EC2, selecione a instância e clique na aba **Monitor**
- [ ] Verifique as métricas de **CPU Utilization** e **Network In/Out**
- [ ] Clique em **Actions** → **Security** → **Get system log** para verificar logs de inicialização

### Passo 8: Testar o Acesso SSH (Opcional)

- [ ] Abra o terminal (Linux/macOS) ou use o PuTTY (Windows)
- [ ] Conecte-se à instância:
  ```bash
  ssh -i "employee-directory-key.pem" ec2-user@[IP-PUBLICO]
  ```
- [ ] Verifique que o processo da aplicação está rodando:
  ```bash
  ps aux | grep python
  ```
- [ ] Verifique os logs da aplicação:
  ```bash
  cat /var/log/employee-app.log
  ```

### Passo 9: Configurar Elastic IP (Opcional)

- [ ] No painel de navegação, clique em **Elastic IPs**
- [ ] Clique em **Allocate Elastic IP address**
- [ ] Clique em **Allocate**
- [ ] Selecione o Elastic IP recém-criado
- [ ] Clique em **Actions** → **Associate Elastic IP**
- [ ] Selecione a instância `employee-directory-app`
- [ ] Clique em **Associate**
- [ ] Agora a aplicação pode ser acessada pelo Elastic IP fixo

## Verificação dos Resultados

| Verificação | Resultado Esperado |
|-------------|-------------------|
| Instância EC2 em estado `running` | ✅ Sim |
| Security Group permite HTTP (porta 80) | ✅ Sim |
| User Data instalou e iniciou a aplicação | ✅ Sim |
| Aplicação acessível via IP público | ✅ Sim |
| Página Employee Directory carrega no navegador | ✅ Sim |
| Funcionalidade de busca funciona | ✅ Sim |
| Status Check: 2/2 checks passed | ✅ Sim |

## Limpeza (Importante)

Para evitar custos desnecessários após o laboratório:

- [ ] No console EC2, selecione a instância `employee-directory-app`
- [ ] Clique em **Instance State** → **Stop** (para parar a instância)
- [ ] Após confirmar que não precisa mais, clique em **Instance State** → **Terminate**
- [ ] Clique em **Elastic IPs**, selecione o EIP e clique em **Actions** → **Release Elastic IP**
- [ ] Opcional: exclua o Security Group e o Key Pair

## Links Oficiais

- [Launch an Instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/launch-instance.html)
- [EC2 User Data](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html)
