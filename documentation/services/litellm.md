# LiteLLM

Call all LLM APIs using the OpenAI format. Use Bedrock, Azure, OpenAI, Cohere, Anthropic, Ollama, Sagemaker, HuggingFace, Replicate (100+ LLMs) 

**[Documentation](https://docs.litellm.ai/docs/)** | **[GitHub](https://github.com/BerriAI/litellm)**

## How to enable?

```
platys init --enable-services LITELLM
platys gen
```

## How to use it?

```bash
curl --location 'http://localhost:11435/chat/completions' --header 'Content-Type: application/json' \
             --data ' {
                        "model": "gpt-3.5-turbo",
                        "messages": [
                            {
                            "role": "user",
                            "content": "what llm are you"
                            }
                        ]
                      }'
```
