# mitmproxy

mitmproxy is a free and open source interactive HTTPS proxy. It allows you to intercept, inspect, modify and replay web traffic, making it ideal for debugging and testing HTTP/HTTPS-based applications.

**[Website](https://mitmproxy.org/)** | **[Documentation](https://docs.mitmproxy.org/)** | **[GitHub](https://github.com/mitmproxy/mitmproxy)**

## How to enable?

```
platys init --enable-services MITMPROXY
platys gen
```

Or in `config.yml`:

```yaml
      MITMPROXY_enable: true
```

## How to use it?

Navigate to <http://dataplatform:9050> to access the mitmweb interface.

Configure your HTTP/HTTPS client to use `dataplatform:9051` as its proxy.

### Browser proxy setup

Set your browser or system proxy to:

```
HTTP Proxy:  dataplatform  Port: 9051
HTTPS Proxy: dataplatform  Port: 9051
```

### curl example

```bash
curl -x http://dataplatform:9051 https://example.com
```

### Install the mitmproxy CA certificate

To intercept HTTPS traffic without certificate errors, install the mitmproxy CA certificate in your client. After configuring the proxy, navigate to <http://mitm.it> to download and install the certificate for your platform.
