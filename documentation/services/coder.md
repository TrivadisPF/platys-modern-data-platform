# Coder

Coder is an open-source platform for creating and managing cloud development environments (CDEs) running on your own infrastructure. Developers connect to remote workspaces via VS Code, JetBrains, or a browser-based IDE, getting consistent, reproducible environments defined as code (Terraform templates).

**Website**: <https://coder.com>  
**Documentation**: <https://coder.com/docs>  
**GitHub**: <https://github.com/coder/coder>

## Prerequisites

Coder requires a running PostgreSQL instance. Enable it alongside Coder:

```yaml
POSTGRESQL_enable: true
POSTGRESQL_multiple_databases: 'coderdb'
POSTGRESQL_multiple_users: 'coder'
POSTGRESQL_multiple_passwords: 'abc123!'

CODER_enable: true
CODER_postgres_dbname: coderdb
CODER_postgres_user: coder
CODER_postgres_password: abc123!
```

## Accessing the UI

Navigate to <http://dataplatform:7080>.

On first access you will be prompted to create an admin account. After that you can define workspace templates (using the Coder CLI or the web UI) and spin up developer workspaces.

## Getting Started

Install the Coder CLI on your local machine:

```bash
curl -L https://coder.com/install.sh | sh
```

Authenticate against the platform:

```bash
coder login http://dataplatform:28494
```

List available templates and create a workspace:

```bash
coder templates list
coder create my-workspace --template <template-name>
```
