# Data Contract Editor

A web-based editor for creating and managing data contracts using the Open Data Contract Standard (ODCS).

**[Documentation](https://github.com/datacontract/datacontract-editor)** | **[GitHub](https://github.com/datacontract/datacontract-editor)**

## How to enable?

```bash
platys init --enable-services DATA_CONTRACT_EDITOR
platys gen
```

## How to use it?

Navigate to <http://dataplatform:4173>

## AI assistant

Set `DATA_CONTRACT_EDITOR_ai_enabled: true` to enable the AI assistant of the editor. It talks to Ollama, either the `ollama` service of the platform (`OLLAMA_enable`) or an external Ollama (`external['OLLAMA_url']`), and uses the model configured with `DATA_CONTRACT_EDITOR_ai_model` (e.g. `llama3.2`), which has to be available in Ollama. If `DATA_CONTRACT_EDITOR_ai_model` is empty, no model is passed to the editor.
