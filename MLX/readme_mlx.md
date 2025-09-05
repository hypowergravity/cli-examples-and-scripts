# MLX Installation and Model Usage on macOS

This guide covers installing MLX (Apple's machine learning framework) and running language models locally on Apple Silicon Macs.

## Environment Setup

Create and activate a new conda environment with Python 3.11:

```bash
conda create -n mlx-arm -y python=3.11
conda activate mlx-arm
```

## Install MLX Dependencies

Install the core MLX packages:

```bash
python -m pip install --no-cache-dir mlx mlx-lm
pip install huggingface_hub[cli]
```

## Hugging Face Cache Management

Scan and clean up your Hugging Face cache to free up space:

```bash
huggingface-cli scan-cache
huggingface-cli delete-cache
```

## Basic Model Generation

### Example 1: Chemistry Q&A with DeepSeek Model

```bash
mlx_lm.generate \
  --model mlx-community/DeepSeek-R1-Distill-Qwen-7B \
  --prompt "can you explain redox chemistry of antioxidants" \
  --max-tokens 1000 \
  --temp 0.8
```

### Example 2: Antioxidant Assays with GPT-OSS

```bash
mlx_lm.generate \
  --model openai/gpt-oss-20b \
  --prompt "can you explain the different assay for evaluating antioxidants" \
  --max-tokens 100
```

## Model Quantization for Larger Models

For better performance with large models, quantize to 4-bit precision:

```bash
mlx_lm.convert \
  --hf-path openai/gpt-oss-20b \
  -q \
  --q-bits 4 \
  --q-group-size 64
```

## Prompt Caching

For repeated queries with long context, use prompt caching to improve performance:

### Step 1: Cache the Context

```bash
cat context.txt | mlx_lm.cache_prompt \
  --model InferenceIllusionist/gpt-oss-20b-MLX-4bit \
  --prompt - \
  --prompt-cache-file context_cache.safetensors \
  --max-kv-size 4096
```

### Step 2: Generate with Cached Context

```bash
mlx_lm.generate \
  --model openai/gpt-oss-20b \
  --prompt-cache-file context_cache.safetensors \
  --prompt "you are a chemistry assistant specialized in extracting antioxidant assay results. Use only the provided text. identify all chemical compounds only, please give as json of antioxidants and please do not add explain, save output as json file" \
  --max-kv-size 4096 \
  --max-tokens 100 \
  --temp 0.0
```

