# No Language Left Behind (NLLB)

A performant high-throughput CPU-based API for Meta's No Language Left Behind (NLLB) using CTranslate2, hosted on Hugging Face Spaces. 

**[Documentation](https://github.com/winstxnhdw/nllb-api)** | **[GitHub](https://github.com/winstxnhdw/nllb-api)**

## How to enable?

```
platys init --enable-services NLLB
platys gen
```

## How to use it?

REST API documentation available [here](http://dataplatform:28257/api/schema/swagger).

Translate

```bash
curl 'https://dataplatform:28257/api/v4/translator?text=Hello&source=eng_Latn&target=spa_Latn'
```



