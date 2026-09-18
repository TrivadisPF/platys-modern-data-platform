# Forgejo

Forgejo is a lightweight, self-hosted Git service. It provides repositories, issue tracking, pull requests, CI/CD integration, and a web UI, making it a drop-in alternative to GitHub or GitLab for on-premises use.

**[Website](https://forgejo.org/)** | **[Documentation](https://forgejo.org/docs/latest/)** | **[Codeberg](https://codeberg.org/forgejo/forgejo)**

## How to enable?

```
platys init --enable-services FORGEJO
platys gen
```

Or in `config.yml`:

```yaml
      FORGEJO_enable: true
```

## How to use it?

Navigate to <http://dataplatform:3004> to access the Forgejo web UI.

On first access, complete the installation wizard to set up your admin account and site settings.

### SSH access

Configure your SSH client to use port `2223`:

```bash
ssh -p 2223 git@dataplatform
```

Clone a repository via SSH:

```bash
git clone ssh://git@dataplatform:2223/<user>/<repo>.git
```

Clone a repository via HTTP:

```bash
git clone http://dataplatform:3004/<user>/<repo>.git
```
