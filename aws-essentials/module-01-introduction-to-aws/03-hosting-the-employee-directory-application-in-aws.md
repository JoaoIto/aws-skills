# Hosting the Employee Directory Application in AWS

## Visão Geral

O **Employee Directory Application** é uma aplicação web de exemplo usada ao longo do curso AWS Technical Essentials para demonstrar conceitos práticos de computação, armazenamento, banco de dados e segurança na nuvem AWS. A aplicação permite listar, buscar e gerenciar funcionários, integrando-se a um banco de dados backend e servindo uma interface web.

Este tópico aborda a **arquitetura inicial** da aplicação — uma implementação simples em uma única instância Amazon EC2 — que serve como ponto de partida para evoluções posteriores (como alta disponibilidade, serverless e migração para containers).

## Arquitetura Inicial (Single EC2 Instance)

```
┌─────────────────────────────────────────────────────────┐
│                    Cliente Web (Browser)                 │
└──────────────────────────┬──────────────────────────────┘
                           │ HTTP/HTTPS
┌──────────────────────────▼──────────────────────────────┐
│                    Amazon EC2 (t3.micro)                  │
│  ┌────────────────────────────────────────────────────┐  │
│  │  Application Server (Python/Flask, Node.js, etc.)   │  │
│  └────────────────────────────────────────────────────┘  │
│  ┌────────────────────────────────────────────────────┐  │
│  │  Employee Data (JSON file or local SQLite DB)      │  │
│  └────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
```

Nesta arquitetura inicial:
- Uma única instância EC2 hospeda o servidor web e os dados.
- O acesso é feito diretamente via IP público ou DNS da instância.
- Não há alta disponibilidade, backup automatizado ou escalabilidade.

## Conceitos Chave

- **Amazon Machine Image (AMI)**: Imagem pré-configurada que contém o sistema operacional, servidor web e aplicação. A AWS fornece AMIs oficiais (Amazon Linux 2, Ubuntu, Windows) e permite criar AMIs customizadas para reutilização.

- **Security Group para Web**: O Security Group da instância deve permitir inbound na porta **80 (HTTP)** e/ou **443 (HTTPS)** de `0.0.0.0/0` (qualquer origem), e **22 (SSH)** apenas de IPs específicos (não abra SSH para todo mundo).

- **IAM Role para EC2**: Em vez de usar credenciais estáticas, anexe uma **IAM Role** à instância EC2 para que a aplicação acesse serviços como S3, DynamoDB ou Secrets Manager de forma segura e sem credenciais hardcoded.

- **User Data Script**: Script executado automaticamente na primeira inicialização da instância. Pode instalar pacotes, baixar código da aplicação e iniciar o serviço. Exemplo:

  ```bash
  #!/bin/bash
  yum update -y
  yum install -y python3 python3-pip
  pip3 install flask
  # Baixar e iniciar a aplicação
  ```

- **Elastic IP (EIP)**: Endereço IPv4 estático que pode ser associado a uma instância EC2, garantindo que o IP público não mude após reinicializações. Útil para aplicações que precisam de endpoint fixo.

- **Key Pair**: Par de chaves criptográficas (pública/privada) usado para autenticação SSH na instância. A chave privada (.pem) deve ser mantida segura e com permissões `400` no Linux/macOS.

## Casos de Uso

- **Desenvolvimento e Teste**: Um time de desenvolvimento lança rapidamente uma instância EC2 com a aplicação Employee Directory para testes funcionais, usando o AWS Free Tier (t3.micro).

- **Prototipagem Rápida**: Um arquiteto de soluções demonstra uma POC (Proof of Concept) da aplicação em uma única instância, validando a lógica de negócio antes de projetar a arquitetura de produção.

- **Migração de Aplicação Local**: Uma empresa migra seu diretório de funcionários de um servidor local para a AWS, começando com uma instância EC2 que replica o ambiente atual.

## Links Oficiais

- [Amazon EC2 User Data](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html)
- [IAM Roles for EC2](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/iam-roles-for-amazon-ec2.html)
