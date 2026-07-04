# Zammad

Open source customer support and helpdesk ticketing system. Zammad provides a unified interface for managing customer communications across email, chat, phone, and social media, with a full-featured REST API and extensive reporting.

**[Website](https://zammad.org/)** | **[Documentation](https://docs.zammad.org/)** | **[GitHub](https://github.com/zammad/zammad)**

### How to enable?

```
platys init --enable-services ZAMMAD
platys gen
```

### How to use it?

Navigate to <http://dataplatform:28460>

On first start, complete the setup wizard to configure your instance. The following services are started together:

| Container | Role |
|-----------|------|
| `zammad-nginx` | Web frontend (port 28460) |
| `zammad-railsserver` | Rails application server |
| `zammad-websocket` | WebSocket server for real-time updates |
| `zammad-scheduler` | Background job processor |
| `zammad-backup` | Automated backup service |
| `zammad-init` | One-time database initialisation |
| `zammad-elasticsearch` | Full-text search engine |
| `zammad-postgresql` | Dedicated PostgreSQL database |
| `zammad-memcached` | Session cache |
| `zammad-redis` | Queue and pub/sub backend |

### Configuration

| Parameter | Default | Description |
|-----------|---------|-------------|
| `ZAMMAD_db_name` | `zammad_production` | PostgreSQL database name |
| `ZAMMAD_db_user` | `zammad` | PostgreSQL user |
| `ZAMMAD_db_password` | `zammad` | PostgreSQL password |
