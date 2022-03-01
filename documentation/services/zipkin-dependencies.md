# Zipkin Dependencies

Zipkin Dependencies collects spans from storage, analyzes links between services, and stores them for later presentation in the web UI.

**[Website](https://zipkin.io/)** | **[Documentation](https://zipkin.io/)** | **[GitHub](https://github.com/openzipkin/zipkin)**

## How to enable?

```
platys init --enable-services ZIPKIN
platys gen
```

## How to use it?

Navigate to <http://dataplatform:9411/dependency>