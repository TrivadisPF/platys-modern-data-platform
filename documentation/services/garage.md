# Garage

S3-compatible object store for small self-hosted geo-distributed deployments.

**[Website](https://garagehq.deuxfleurs.fr/)** | **[Documentation](https://garagehq.deuxfleurs.fr/documentation/quick-start/)** | **[Git](https://git.deuxfleurs.fr/Deuxfleurs/garage)**

## How to enable?

```bash
platys init --enable-services GARAGE GARAGE_WEBUI
platys gen
```

```bash
docker compose up -d
```

Before we can use the Garage node, we have to assign a role to it. 

```bash
docker exec -ti garage /garage status
```

```
guido.schmutz@AMAXDKFVW0HYY ~/w/platys-demo3 [1]> docker exec -ti garage /garage status
2025-05-26T18:42:32.749482Z  INFO garage_net::netapp: Connected to 192.168.147.2:3901, negotiating handshake...
2025-05-26T18:42:32.792908Z  INFO garage_net::netapp: Connection established to d04b323f9f765aed
==== HEALTHY NODES ====
ID                Hostname  Address             Tags  Zone  Capacity          DataAvail
d04b323f9f765aed  garage    192.168.147.2:3901              NO ROLE ASSIGNED
```

Now create the layout with 1GB for the node

```bash
docker exec -ti garage /garage layout assign -z dc1 -c 1G d04b323f9f765aed
docker exec -ti garage /garage layout apply --version 1
```

## How to use it?

Navigate to <http://dataplatform:3909> for the Garage WebUI. 








