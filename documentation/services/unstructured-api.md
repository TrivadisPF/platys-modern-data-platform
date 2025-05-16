# Unstructured API

The Unstructured API services offer a high-quality and scalable solution capable of ingesting and digesting files of various types and sizes.

**[Homepage](https://unstructured-io.github.io/unstructured/)** | **[Documentation](https://unstructured-io.github.io/unstructured/apis/usage_methods.html)** | **[GitHub](https://github.com/Unstructured-IO/unstructured-api)**

## How to enable?

```
platys init --enable-services UNSTRUCTURED_API
platys gen
```

## How to use it?

```bash
curl -X 'POST' \  
        'http://192.168.1.102:28374/general/v0/general' \
         -H 'accept: application/json' \
         -H 'Content-Type: multipart/form-data' \
         -F 'files=@sample-docs/layout-parser-paper.pdf' \
         -F 'strategy=hi_res'
```                                   