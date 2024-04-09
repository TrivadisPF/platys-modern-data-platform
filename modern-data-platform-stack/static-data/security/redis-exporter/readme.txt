Place the redis-exporter password file here and specify the name in `REDIS_EXPORTER_password_file`.

The password file for the regis-exporter is not the same as for Redis itself. It must have the following format:

{
  "redis://redis-1:6379": "abc123!"
}