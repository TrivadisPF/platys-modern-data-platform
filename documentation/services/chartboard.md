# Chartboard

Simple dashboard to show widget chart 

**[Website](https://github.com/the-maux/Chartboard)** | **[Documentation](https://github.com/the-maux/tipboard/wiki)** | **[GitHub](https://github.com/the-maux/Chartboard)**

```
platys init --enable-services CHARTBOARD
platys gen
```

### Run Sample Dashboard

Navigate to <http://dataplatform:28173> to see the sample dashboard.

To simulate data, you can run the sensors inside the container

```
docker exec -ti chartboard python src/manage.py sensors
```

