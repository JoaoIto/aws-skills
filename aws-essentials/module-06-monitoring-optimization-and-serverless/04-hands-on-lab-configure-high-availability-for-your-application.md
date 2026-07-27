# Hands-On Lab: Configure High Availability for Your Application

## Visão Geral

Neste laboratório prático, você configurará **alta disponibilidade (High Availability)** para a Employee Directory Application. Você implantará a aplicação em **múltiplas zonas de disponibilidade (AZs)**, configurará um **Application Load Balancer**, habililitará **Auto Scaling** e testará a recuperação de falhas.

### Objetivos de Aprendizagem

- Configurar Auto Scaling Group com múltiplas AZs
- Criar e configurar um Application Load Balancer
- Configurar Health Checks para detecção de falhas
- Testar failover entre AZs
- Verificar alta disponibilidade via console

### Pré-requisitos

- Conta AWS ativa (ou AWS Free Tier)
- Acesso de administrador à conta
- Key Pair existente (`employee-directory-key`)
- Navegador web com acesso ao AWS Management Console

## Roteiro Passo a Passo

### Passo 1: Acessar o Console do EC2

- [ ] Acesse o [AWS Management Console](https://console.aws.amazon.com/)
- [ ] Faça login com usuário administrador
- [ ] Na barra de busca, digite **EC2** e selecione **EC2**

### Passo 2: Criar um Launch Template

- [ ] No painel de navegação, clique em **Launch Templates**
- [ ] Clique em **Create launch template**
- [ ] Em **Name**, digite `employee-directory-template`
- [ ] Em **AMI**, selecione **Amazon Linux 2**
- [ ] Em **Instance type**, selecione **t2.micro**
- [ ] Em **Key pair**, selecione `employee-directory-key`
- [ ] Em **Security group**, selecione `employee-directory-sg` (ou crie um novo)
- [ ] Em **User data**, cole:

```bash
#!/bin/bash
yum update -y
yum install -y python3 python3-pip git
pip3 install flask
git clone https://github.com/aws-samples/employee-directory.git /var/app
cd /var/app
nohup python3 app.py > /var/log/employee-app.log 2>&1 &
```

- [ ] Clique em **Create launch template**

### Passo 3: Criar um Application Load Balancer

- [ ] No painel de navegação, clique em **Load Balancers**
- [ ] Clique em **Create Load Balancer**
- [ ] Selecione **Application Load Balancer**
- [ ] Em **Name**, digite `employee-directory-alb`
- [ ] Em **Scheme**, selecione **Internet-facing**
- [ ] Em **Listeners**, mantenha **HTTP (80)**
- [ ] Em **Availability Zones**, selecione **2 ou mais AZs**
- [ ] Em **Security group**, selecione `employee-directory-sg`
- [ ] Clique em **Create**

### Passo 4: Criar um Target Group

- [ ] No painel de navegação, clique em **Target Groups**
- [ ] Clique em **Create target group**
- [ ] Em **Target type**, selecione **Instance**
- [ ] Em **Name**, digite `employee-directory-tg`
- [ ] Em **Protocol**, selecione **HTTP**
- [ ] Em **Port**, digite **80**
- [ ] Em **Health check path**, digite `/health` (ou `/`)
- [ ] Clique em **Create target group**

### Passo 5: Configurar o Listener do ALB

- [ ] Com o ALB selecionado, clique na aba **Listeners**
- [ ] Clique em **View/edit target groups** (ou **Edit**)
- [ ] Selecione o target group `employee-directory-tg`
- [ ] Clique em **Save**

### Passo 6: Criar um Auto Scaling Group

- [ ] No painel de navegação, clique em **Auto Scaling Groups**
- [ ] Clique em **Create Auto Scaling group**
- [ ] Em **Launch template**, selecione `employee-directory-template`
- [ ] Clique em **Next**
- [ ] Em **Name**, digite `employee-directory-asg`
- [ ] Em **VPC**, selecione sua VPC
- [ ] Em **Availability Zones**, selecione **2 ou mais AZs**
- [ ] Em **Desired capacity**, digite **2**
- [ ] Em **Minimum capacity**, digite **2**
- [ ] Em **Maximum capacity**, digite **4**
- [ ] Clique em **Next**
- [ ] Em **Target group**, selecione `employee-directory-tg`
- [ ] Clique em **Next** → **Create Auto Scaling group**

### Passo 7: Configurar Scaling Policies

- [ ] Com o ASG selecionado, clique na aba **Automatic scaling**
- [ ] Clique em **Add policy**
- [ ] Em **Policy name**, digite `scale-out-policy`
- [ ] Em **Metric type**, selecione **Average CPU utilization**
- [ ] Em **Target value**, digite **60**
- [ ] Clique em **Create**
- [ ] Clique em **Add policy** novamente
- [ ] Em **Policy name**, digite `scale-in-policy`
- [ ] Em **Metric type**, selecione **Average CPU utilization**
- [ ] Em **Target value**, digite **30**
- [ ] Clique em **Create**

### Passo 8: Verificar o Funcionamento

- [ ] No painel de navegação, clique em **Load Balancers**
- [ ] Selecione `employee-directory-alb`
- [ ] Copie o **DNS name** (ex: `employee-directory-alb-123456789.sa-east-1.elb.amazonaws.com`)
- [ ] Abra uma nova aba do navegador
- [ ] Cole o DNS na barra de endereços: `http://[DNS-NAME]`
- [ ] Aguarde alguns minutos para as instâncias serem registradas no target group
- [ ] A aplicação Employee Directory deve ser exibida

### Passo 9: Testar Health Checks

- [ ] No painel de navegação, clique em **Target Groups**
- [ ] Selecione `employee-directory-tg`
- [ ] Clique na aba **Targets**
- [ ] Verifique que as instâncias estão com status **healthy**
- [ ] Clique na aba **Health** para ver o histórico de health checks

### Passo 10: Testar Failover (Simulação)

- [ ] No painel de navegação, clique em **Instances**
- [ ] Selecione uma instância do ASG
- [ ] Clique em **Instance State** → **Stop**
- [ ] Aguarde 1-2 minutos
- [ ] Verifique:
  - [ ] A instância parada é automaticamente substituída pelo ASG
  - [ ] O ALB redireciona o tráfego para as instâncias saudáveis
  - [ ] A aplicação continua acessível via DNS do ALB
- [ ] Quando a instância parada for substituída, o ASG criará uma nova instância

### Passo 11: Verificar Métricas de Alta Disponibilidade

- [ ] No painel de navegação, clique em **Load Balancers**
- [ ] Selecione `employee-directory-alb`
- [ ] Clique na aba **Monitoring**
- [ ] Verifique as métricas:
  - [ ] **RequestCount**: Número de requisições processadas
  - [ ] **HealthyHostCount**: Número de hosts saudáveis
  - [ ] **UnHealthyHostCount**: Número de hosts não saudáveis
  - [ ] **HTTPCode_Backend_2XX**: Respostas HTTP 2xx
  - [ ] **HTTPCode_Backend_5XX**: Respostas HTTP 5xx

### Passo 12: Configurar Notificações do ASG (Opcional)

- [ ] Com o ASG selecionado, clique na aba **Notifications**
- [ ] Clique em **Create notification**
- [ ] Em **Notification name**, digite `asg-notifications`
- [ ] Em **Events**, selecione:
  - [ ] **EC2 Instance Launch Successful**
  - [ ] **EC2 Instance Terminate**
  - [ ] **EC2 Instance Launch Unsuccessful**
- [ ] Em **SNS topic**, crie um novo ou selecione um existente
- [ ] Clique em **Create**

## Verificação dos Resultados

| Verificação | Resultado Esperado |
|-------------|-------------------|
| Launch Template criado | ✅ Sim |
| Application Load Balancer criado (Internet-facing) | ✅ Sim |
| Target Group criado com health check | ✅ Sim |
| Auto Scaling Group com 2-4 instâncias | ✅ Sim |
| Scaling policies configuradas (60% e 30%) | ✅ Sim |
| Aplicação acessível via DNS do ALB | ✅ Sim |
| Instâncias com status "healthy" no Target Group | ✅ Sim |
| Failover testado (instância substituída) | ✅ Sim |
| Métricas de ALB visíveis no console | ✅ Sim |
| Notificações do ASG configuradas | ✅ Sim |

## Limpeza (Importante)

Para evitar custos desnecessários após o laboratório:

- [ ] Exclua o Auto Scaling Group (selecionar ASG → Actions → Delete)
- [ ] Exclua o Application Load Balancer
- [ ] Exclua o Target Group
- [ ] Exclua o Launch Template
- [ ] Exclua as instâncias EC2 (se sobrarem)
- [ ] Exclua o Security Group (se não for mais usado)

## Links Oficiais

- [Auto Scaling Groups](https://docs.aws.amazon.com/autoscaling/ec2/userguide/auto-scaling-groups.html)
- [Application Load Balancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/what-is-application-load-balancer.html)
- [Health Checks](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-health-checks.html)
