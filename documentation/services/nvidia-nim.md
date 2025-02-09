# Nvidia NIM 

NVIDIA NIM (NVIDIA Inference Microservices) is a set of optimized AI model microservices designed to simplify the deployment of AI models in production. NIM provides pre-optimized, ready-to-use AI models that can be deployed as containerized services, making it easier for developers and enterprises to integrate AI into applications without needing deep expertise in model optimization, fine-tuning, or infrastructure management.

**[Website](https://www.nvidia.com/en-us/ai/)** | **[Documentation](https://docs.nvidia.com/nim/index.html)** | **[Models](https://build.nvidia.com/nvidia)**

## How to enable?

```
platys init --enable-services NVIDIA_NIM
```

Add the [name of the models](https://build.nvidia.com/models) you want to deploy

```
NVIDIA_NIM_images='nvcr.io/nim/meta/llama-3.1-70b-instruct:1.3.0,nvcr.io/nim/nvidia/nv-embedqa-e5-v5:1.0.1'
NVIDIA_NIM_gpu_counts='1,1'
NVIDIA_NIM_api_key=<api-key-from-nvidia>
```

Generate

```bash
platys gen
```

## How to use it?




