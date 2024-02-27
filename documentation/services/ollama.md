# Ollama

Get up and running with Llama 2, Mistral, Gemma, and other large language models.  

**[Website](https://ollama.com/)** | **[Documentation](https://github.com/ollama/ollama)** | **[GitHub](https://github.com/ollama/ollama)**

## How to enable?

```
platys init --enable-services OLLAMA
platys gen
```

## How to use it?

```bash
curl http://localhost:11434/api/generate -d '{
  "model": "llama2",
  "prompt":"Why is the sky blue?"
}'
```