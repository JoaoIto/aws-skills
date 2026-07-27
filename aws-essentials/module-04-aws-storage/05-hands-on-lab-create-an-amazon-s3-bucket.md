# Hands-On Lab: Create an Amazon S3 Bucket

## Visão Geral

Neste laboratório prático, você criará um **bucket Amazon S3**, configurará **políticas de acesso**, habilitará **versionamento** e **lifecycle policies**, testará o **hosting de website estático** e validará o acesso aos objetos.

### Objetivos de Aprendizagem

- Criar um bucket S3 com configurações de segurança
- Configurar políticas de acesso (bucket policy, ACLs)
- Habilitar versionamento e lifecycle policies
- Fazer upload e download de objetos
- Configurar website estático no S3
- Testar acesso público e privado

### Pré-requisitos

- Conta AWS ativa (ou AWS Free Tier)
- Acesso de administrador à conta
- Navegador web com acesso ao AWS Management Console

## Roteiro Passo a Passo

### Passo 1: Acessar o Console do S3

- [ ] Acesse o [AWS Management Console](https://console.aws.amazon.com/)
- [ ] Faça login com usuário administrador
- [ ] Na barra de busca, digite **S3** e selecione **S3**

### Passo 2: Criar o Bucket S3

- [ ] Clique em **Create bucket**
- [ ] Em **Bucket name**, digite `employee-directory-assets-[seu-nome]` (deve ser único globalmente)
- [ ] Em **Region**, selecione sua região (ex: `South America (São Paulo) sa-east-1`)
- [ ] Em **Object Ownership**, selecione **ACLs enabled** (recomendado para este laboratório)
- [ ] Em **Block Public Access**, mantenha **desmarcado** por enquanto (vamos configurar acesso público manualmente)
- [ ] Clique em **Create bucket**
- [ ] Aguarde o status mudar para **Available**

### Passo 3: Configurar Versionamento

- [ ] Com o bucket selecionado, clique na aba **Properties**
- [ ] Role para baixo até **Versioning**
- [ ] Clique em **Edit**
- [ ] Marque **Enable**
- [ ] Clique em **Save changes**

### Passo 4: Configurar Lifecycle Policy

- [ ] Na aba **Management**, clique em **Create lifecycle policy**
- [ ] Em **Lifecycle policy name**, digite `archive-old-files`
- [ ] Em **Scope**, selecione **Whole bucket**
- [ ] Em **Lifecycle rule name**, digite `transition-to-glacier`
- [ ] Clique em **Next**
- [ ] Em **Transitions**, adicione:
  - [ ] **Current version**: Transition to **Glacier** after **90** days
- [ ] Clique em **Next**
- [ ] Clique em **Create policy**

### Passo 5: Fazer Upload de Objetos

- [ ] Com o bucket selecionado, clique na aba **Objects** → **Upload**
- [ ] Clique em **Add files**
- [ ] Selecione um arquivo local (ex: uma imagem ou documento)
- [ ] Clique em **Upload**
- [ ] Aguarde o upload completar

### Passo 6: Configurar Bucket Policy (Acesso Público)

- [ ] Na aba **Permissions**, clique em **Bucket Policy**
- [ ] Cole a política abaixo (substitua `[NOME-DO-BUCKET]` pelo nome real do seu bucket):

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::[NOME-DO-BUCKET]/*"
        }
    ]
}
```

- [ ] Clique em **Save changes**

### Passo 7: Configurar Website Estático

- [ ] Na aba **Properties**, role para baixo até **Static website hosting**
- [ ] Clique em **Edit**
- [ ] Selecione **Enable**
- [ ] Em **Index document**, digite `index.html`
- [ ] Em **Error document**, digite `error.html`
- [ ] Clique em **Save changes**
- [ ] Anote o **endpoint** do website (ex: `http://employee-directory-assets.s3-website.sa-east-1.amazonaws.com`)

### Passo 8: Criar Arquivo index.html

- [ ] Clique em **Create folder** → nome: `website`
- [ ] Clique no folder `website` → **Upload** → **Add files**
- [ ] Crie um arquivo `index.html` localmente com o conteúdo abaixo:

```html
<!DOCTYPE html>
<html>
<head>
    <title>Employee Directory</title>
</head>
<body>
    <h1>Welcome to Employee Directory</h1>
    <p>Static website hosted on Amazon S3</p>
</body>
</html>
```

- [ ] Faça upload do `index.html` para a pasta `website`
- [ ] Clique em **Actions** → **Make public** (para o index.html)

### Passo 9: Testar o Website Estático

- [ ] Abra uma nova aba do navegador
- [ ] Cole o endpoint do website estático (do Passo 7)
- [ ] Adicione `/website/index.html` ao final do URL
- [ ] Verifique que a página "Welcome to Employee Directory" é exibida

### Passo 10: Testar Upload via CLI (Opcional)

- [ ] Abra o terminal (ou use o AWS CloudShell)
- [ ] Execute:

```bash
# Listar buckets
aws s3 ls

# Fazer upload de um arquivo
aws s3 cp ./arquivo-local.txt s3://employee-directory-assets-[seu-nome]/

# Listar objetos do bucket
aws s3 ls s3://employee-directory-assets-[seu-nome]/

# Baixar um arquivo
aws s3 cp s3://employee-directory-assets-[seu-nome]/arquivo-local.txt ./arquivo-baixado.txt
```

### Passo 11: Configurar Server Access Logging

- [ ] Na aba **Properties**, role para baixo até **Server access logging**
- [ ] Clique em **Edit**
- [ ] Marque **Enable**
- [ ] Em **Target bucket**, digite o nome do seu bucket (ou crie um bucket separado para logs)
- [ ] Em **Target prefix**, digite `logs/`
- [ ] Clique em **Save changes**

## Verificação dos Resultados

| Verificação | Resultado Esperado |
|-------------|-------------------|
| Bucket S3 criado com nome único | ✅ Sim |
| Versionamento habilitado | ✅ Sim |
| Lifecycle policy configurada (90 dias → Glacier) | ✅ Sim |
| Objeto(s) enviado(s) com sucesso | ✅ Sim |
| Bucket policy configurada para acesso público | ✅ Sim |
| Website estático configurado | ✅ Sim |
| index.html acessível via endpoint do website | ✅ Sim |
| Server access logging configurado | ✅ Sim |
| Upload/download via CLI funciona | ✅ Sim |

## Conceitos Revisados

- **Bucket**: Contêiner de nível superior para objetos no S3
- **Object**: Dado individual (arquivo + metadados)
- **Key**: Nome/identificador do objeto dentro do bucket
- **Versionamento**: Preserva versões anteriores de objetos
- **Lifecycle Policy**: Automatiza transição entre classes de armazenamento
- **Bucket Policy**: Política JSON que controla acesso a nível de bucket
- **Website Estático**: Servir arquivos HTML/CSS/JS diretamente do S3
- **Server Access Logging**: Registra requisições ao bucket

## Limpeza (Importante)

Para evitar custos desnecessários após o laboratório:

- [ ] Exclua os objetos do bucket (selecionar objetos → Actions → Delete)
- [ ] Exclua o bucket (selecionar bucket → Actions → Delete)
- [ ] Verifique no console S3 que o bucket foi removido
- [ ] Se criou um bucket separado para logs, exclua também

## Links Oficiais

- [Amazon S3 User Guide](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html)
- [Create a Bucket](https://docs.aws.amazon.com/AmazonS3/latest/userguide/creating-bucket.html)
- [S3 Lifecycle Policies](https://docs.aws.amazon.com/AmazonS3/latest/userguide/lifecycle-configuration-examples.html)
- [S3 Static Website Hosting](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html)
