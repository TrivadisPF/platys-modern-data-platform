# NATS 

High-Performance server for NATS.io, the cloud and edge native messaging system.  

**[Website](https://nats.io/)** | **[Documentation](https://docs.nats.io/)** | **[GitHub](https://github.com/nats-io/nats-server)**

## How to enable?

```
platys init --enable-services NATS
platys gen
```

## How to use it?

```bash
telnet dataplatform 4222
```

you should see a result similar to this

```
Trying ::1...
Connected to dataplatform.
Escape character is '^]'.
INFO {"server_id":"NDP7NP2P2KADDDUUBUDG6VSSWKCW4IC5BQHAYVMLVAJEGZITE5XP7O5J","version":"2.0.0","proto":1,"go":"go1.11.10","host":"0.0.0.0","port":4222,"max_payload":1048576,"client_id":13249}
```

You can also test the monitoring endpoint, viewing <http://dataplatform:8222>.