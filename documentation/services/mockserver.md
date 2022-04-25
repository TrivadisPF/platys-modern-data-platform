# MockServer

MockServer enables easy mocking of any system you integrate with via HTTP or HTTPS with clients written in Java, JavaScript and Ruby. MockServer also includes a proxy that introspects all proxied traffic including encrypted SSL traffic and supports Port Forwarding, Web Proxying (i.e. HTTP proxy), HTTPS Tunneling Proxying (using HTTP CONNECT) and… 

**[Website](https://mock-server.com/)** | **[Documentation](https://mock-server.com/)** | **[GitHub](https://github.com/mock-server/mockserver)**

## How to enable?

```
platys init --enable-services MOCK_SERVER
platys gen
```

## How to use it?

Navigate to <http://dataplatform:28273>.


### Setting expectations using Json Config File

```json
[ {
  "httpRequest" : {
    "path" : "/some/path"
  },
  "httpResponse" : {
    "statusCode": 200,
      "body": {
        "value": "one"
      }
  }
} ]
```

### Setting expectations using Curl

```bash
curl -X PUT 'localhost:28273/mockserver/expectation' \
-d '[
  {
    "httpRequest": {
      "path": "/some/path"
    },
    "httpResponse": {
      "statusCode": 200,
      "body": {
        "value": "one"
      }
    }
  }
]'
```