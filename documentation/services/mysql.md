# MySQL

MySQL Server, the world's most popular open source database, and MySQL Cluster, a real-time, open source transactional database. 

**[Website](https://www.mysql.com/)** | **[Documentation](https://dev.mysql.com/doc/)** | **[GitHub](https://github.com/mysql)**

### How to enable

```
platys init --enable-services MYSQL
platys gen
```

### Other links



### Backup & Restore

To backup a database perform

```bash
docker exec mysql /usr/bin/mysqldump -u root --password=root DATABASE > backup.sql
```

To restore from a backup, perform

```bash
cat backup.sql | docker exec -i mysql /usr/bin/mysql -u root --password=root DATABASE
```
