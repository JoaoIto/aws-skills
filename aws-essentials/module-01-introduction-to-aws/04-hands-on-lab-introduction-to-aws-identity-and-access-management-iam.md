# Hands-On Lab: Introduction to AWS Identity and Access Management (IAM)

## Visão Geral

Neste laboratório prático, você explorará o **AWS Identity and Access Management (IAM)**, o serviço central de gerenciamento de acesso da AWS. Você criará usuários, grupos e funções (roles), configurará políticas de acesso, habilitará a autenticação multifator (MFA) e aplicará o princípio de **least privilege** (menor privilégio necessário).

### Objetivos de Aprendizagem

- Criar usuários e grupos IAM
- Aplicar políticas de acesso (managed e customizadas)
- Configurar MFA para usuários
- Criar roles IAM e associá-las a serviços
- Aplicar o princípio de least privilege
- Testar permissões de acesso

### Pré-requisitos

- Conta AWS ativa (ou AWS Free Tier)
- Acesso de administrador à conta (usuário raiz ou usuário IAM com permissões de administrador)
- Navegador web com acesso ao AWS Management Console

## Roteiro Passo a Passo

### Passo 1: Acessar o Console do IAM

- [ ] Acesse o [AWS Management Console](https://console.aws.amazon.com/)
- [ ] Faça login com usuário administrador
- [ ] Na barra de busca, digite **IAM** e selecione **IAM**

### Passo 2: Criar um Grupo IAM

- [ ] No painel de navegação, clique em **Groups**
- [ ] Clique em **Create group**
- [ ] Em **Group name**, digite `Developers`
- [ ] Em **Attach policies**, selecione:
  - [ ] `AmazonS3ReadOnlyAccess`
  - [ ] `AWSPriceCalculatorServicePolicy` (opcional)
- [ ] Clique em **Create group**

### Passo 3: Criar um Usuário IAM

- [ ] No painel de navegação, clique em **Users**
- [ ] Clique em **Create user**
- [ ] Em **User name**, digite `developer-user`
- [ ] Em **Access type**, selecione **AWS Management Console access**
- [ ] Em **Console password**, selecione **Custom password** e digite uma senha segura
- [ ] Marque **Require password reset** (recomendado)
- [ ] Clique em **Next: Permissions**

### Passo 4: Adicionar o Usuário ao Grupo

- [ ] Em **Permissions**, selecione **Add user to group**
- [ ] Marque o grupo `Developers` criado no Passo 2
- [ ] Clique em **Next: Tags** (opcional - adicione tags como `Department=Engineering`)
- [ ] Clique em **Next: Review**
- [ ] Verifique as informações e clique em **Create user**
- [ ] Clique em **Download** para baixar as credenciais (salve em local seguro)

### Passo 5: Habilitar MFA para o Usuário

- [ ] No painel de navegação, clique em **Users**
- [ ] Selecione o usuário `developer-user`
- [ ] Clique na aba **Security credentials**
- [ ] Clique em **Assign MFA**
- [ ] Selecione **Virtual MFA device** (recomendado)
- [ ] Clique em **Next**
- [ ] Abra o app de autenticador (Google Authenticator, Authy, etc.) e escaneie o código QR
- [ ] Digite os dois códigos de verificação consecutivos
- [ ] Clique em **Assign MFA**

### Passo 6: Criar uma Política Customizada (Least Privilege)

- [ ] No painel de navegação, clique em **Policies**
- [ ] Clique em **Create policy**
- [ ] Clique na aba **JSON**
- [ ] Cole a política abaixo (permite apenas leitura de objetos em um bucket S3 específico):

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::employee-directory-assets",
                "arn:aws:s3:::employee-directory-assets/*"
            ]
        }
    ]
}
```

- [ ] Clique em **Next: Tags** (opcional)
- [ ] Clique em **Next: Review**
- [ ] Em **Name**, digite `S3-Employee-Directory-ReadOnly`
- [ ] Em **Description**, digite `Permissão de leitura para o bucket employee-directory-assets`
- [ ] Clique em **Create policy**

### Passo 7: Associar a Política ao Grupo

- [ ] No painel de navegação, clique em **Groups**
- [ ] Selecione o grupo `Developers`
- [ ] Clique na aba **Permissions**
- [ ] Clique em **Add permissions**
- [ ] Selecione **Attach policies**
- [ ] Procure e selecione `S3-Employee-Directory-ReadOnly`
- [ ] Clique em **Add permissions**

### Passo 8: Criar uma Role IAM para EC2

- [ ] No painel de navegação, clique em **Roles**
- [ ] Clique em **Create role**
- [ ] Em **Trusted entity type**, selecione **AWS service**
- [ ] Em **Use case**, selecione **EC2**
- [ ] Clique em **Next**
- [ ] Em **Add permissions**, selecione:
  - [ ] `AmazonS3ReadOnlyAccess`
  - [ ] `CloudWatchAgentServerPolicy`
- [ ] Clique em **Next**
- [ ] Em **Role name**, digite `EC2-Employee-Directory-Role`
- [ ] Clique em **Create role**

### Passo 9: Testar Permissões (Login como Usuário)

- [ ] Abra uma janela anônima do navegador
- [ ] Acesse o [AWS Management Console](https://console.aws.amazon.com/)
- [ ] Faça login com o usuário `developer-user` e a senha definida
- [ ] Verifique:
  - [ ] O usuário pode acessar o console IAM (mas não modificar)
  - [ ] O usuário pode listar buckets S3
  - [ ] O usuário **não** pode criar ou excluir buckets S3
  - [ ] O usuário **não** pode acessar o EC2

### Passo 10: Verificar a Role IAM

- [ ] Faça login novamente como administrador
- [ ] No painel de navegação do EC2, clique em **Instances**
- [ ] Selecione uma instância (ou crie uma nova)
- [ ] Clique em **Actions** → **Security** → **Modify IAM role**
- [ ] Selecione a role `EC2-Employee-Directory-Role`
- [ ] Clique em **Save**

## Verificação dos Resultados

| Verificação | Resultado Esperado |
|-------------|-------------------|
| Grupo `Developers` criado | ✅ Sim |
| Usuário `developer-user` criado | ✅ Sim |
| Usuário adicionado ao grupo `Developers` | ✅ Sim |
| MFA habilitado para o usuário | ✅ Sim |
| Política `S3-Employee-Directory-ReadOnly` criada | ✅ Sim |
| Política associada ao grupo `Developers` | ✅ Sim |
| Role `EC2-Employee-Directory-Role` criada | ✅ Sim |
| Usuário consegue listar buckets S3 | ✅ Sim |
| Usuário não consegue criar/excluir buckets S3 | ✅ Sim |
| Role associada a uma instância EC2 | ✅ Sim |

## Conceitos Revisados

- **Users**: Identidades individuais com credenciais próprias
- **Groups**: Coleções de usuários com permissões compartilhadas
- **Roles**: Identidades assumíveis por usuários, serviços ou contas externas
- **Policies**: Documentos JSON que definem permissões (Allow/Deny)
- **MFA**: Autenticação de dois fatores para segurança adicional
- **Least Privilege**: Conceder apenas as permissões mínimas necessárias
- **Managed Policies**: Políticas pré-definidas pela AWS
- **Custom Policies**: Políticas criadas pelo usuário para necessidades específicas

## Limpeza

Para evitar deixar permissões desnecessárias na sua conta:

- [ ] Exclua o usuário `developer-user` (se não for mais necessário)
- [ ] Exclua o grupo `Developers` (se não for mais necessário)
- [ ] Exclua a política `S3-Employee-Directory-ReadOnly` (se não for mais necessária)
- [ ] Exclua a role `EC2-Employee-Directory-Role` (se não for mais necessária)
- [ ] Desassocie a role da instância EC2 (se foi apenas para teste)

## Links Oficiais

- [AWS IAM User Guide](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html)
- [IAM Best Practices](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html)
- [AWS IAM Policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html)
