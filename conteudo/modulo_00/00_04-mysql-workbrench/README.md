# 🛠️ Instalação do MySQL Workbench

O **MySQL Workbench** é uma ferramenta gráfica oficial do MySQL que facilita a administração, modelagem, consulta e gerenciamento do seu banco de dados.
Este guia mostra como instalar o MySQL Workbench de forma rápida e segura nos principais sistemas operacionais.

## 📥 Download

Você pode baixar a versão mais recente diretamente do site oficial:

🔗 [https://dev.mysql.com/downloads/workbench](https://dev.mysql.com/downloads/workbench)


## 💻 Instalação por Sistema Operacional

### 🪟 Windows

1. Acesse o link de download acima e selecione seu sistema Windows.
2. Baixe o instalador MSI.
3. Execute o instalador e siga o assistente de instalação.
4. Durante a instalação, você pode optar por instalar também o MySQL Server e outras ferramentas (opcional).
5. Após instalado, abra o **MySQL Workbench** pelo menu iniciar.

> ✅ Recomendado: Use a versão "Community (GPL)".


### 🍎 macOS

1. Acesse o link de download acima e selecione macOS.
2. Baixe o arquivo `.dmg`.
3. Abra o arquivo e arraste o ícone do **MySQL Workbench** para a pasta `Aplicativos`.
4. Abra o app pela Launchpad ou Spotlight.

> Obs: É necessário ter o **MySQL Server** instalado previamente se quiser conectar a um banco local.

### 🐧 Linux (Ubuntu/Debian)

1. Atualize os repositórios:

```bash
sudo apt update
```

2. Instale o Workbench:

```bash
sudo apt install mysql-workbench
```

3. Após a instalação, inicie com:

```bash
mysql-workbench
```

## 🔐 Conectando ao MySQL

Após instalar o Workbench:

1. Abra o aplicativo.
2. Clique em `+` para criar uma nova conexão.
3. Informe:
   - **Hostname**: `localhost` (ou IP/hostname do servidor MySQL)
   - **Porta**: `3306`
   - **Usuário**: `root` (ou outro usuário)
   - **Senha**: `thiago` (ou a senha que você configurou)
4. Clique em "Test Connection" para validar.
5. Salve e clique para conectar.
