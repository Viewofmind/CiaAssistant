# Moltbot Configuration Guide

## Quick Setup: Custom Provider + Ollama Backup

This guide shows you how to set up Moltbot with your custom AI provider as primary and Ollama as a backup.

### Step 1: Install Ollama (Backup)

```bash
# Install Ollama from https://ollama.ai
# Then pull models:
ollama pull llama3.3
ollama pull deepseek-r1:32b

# Enable Ollama for Moltbot
export OLLAMA_API_KEY="ollama-local"
```

### Step 2: Configure Moltbot

You have two options:

#### Option A: Using Config File (Recommended)

1. Copy the example config:
```bash
cp moltbot-config.example.json ~/.moltbot/config.json
```

2. Edit `~/.moltbot/config.json` and update:
   - `baseUrl`: Replace `https://your-provider-url.com/v1` with your actual API endpoint
   - `id`: Replace `your-model-name` with the actual model ID
   - Adjust `contextWindow` and `maxTokens` if needed

3. Apply the configuration:
```bash
moltbot config reload
```

#### Option B: Using Environment Variable (Easy Key Rotation)

For easier API key changes, use environment variables:

```bash
# Set your custom API key
export CUSTOM_AI_API_KEY="1bc41bc8772346feaa2e8bfb7f723667.X33IblFyZkxSqpMyYLXZWurs"

# Set Ollama key
export OLLAMA_API_KEY="ollama-local"
```

Then use this simplified config (without hardcoded keys):

```json
{
  "agents": {
    "defaults": {
      "model": {
        "primary": "custom/your-model-name",
        "fallbacks": ["ollama/llama3.3"]
      }
    }
  },
  "models": {
    "mode": "merge",
    "providers": {
      "custom": {
        "baseUrl": "https://your-provider-url.com/v1",
        "api": "openai-completions",
        "models": [
          {
            "id": "your-model-name",
            "name": "Primary AI",
            "contextWindow": 128000,
            "maxTokens": 8192
          }
        ]
      }
    }
  }
}
```

The `CUSTOM_AI_API_KEY` environment variable will be automatically picked up.

### Step 3: Verify Setup

```bash
# Check available models
moltbot models list

# Test the configuration
moltbot agent --message "Hello, test message" --thinking low

# Check if Ollama is working as backup
# (stop your custom provider to test fallback)
moltbot agent --message "Testing fallback" --thinking low
```

### Step 4: Change API Key Anytime

#### If using config file:
```bash
# Edit the config file
nano ~/.moltbot/config.json
# Update the apiKey field, then reload
moltbot config reload
```

#### If using environment variable (easier):
```bash
# Just update the environment variable
export CUSTOM_AI_API_KEY="your-new-api-key-here"
# Add to ~/.profile or ~/.bashrc to persist across sessions
echo 'export CUSTOM_AI_API_KEY="your-new-api-key-here"' >> ~/.profile
```

## How Fallback Works

1. **Primary**: Moltbot tries your custom provider first
2. **Fallback 1**: If primary fails, tries `ollama/llama3.3`
3. **Fallback 2**: If that fails, tries `ollama/deepseek-r1:32b`

This ensures your assistant stays running even if the primary provider is down!

## Troubleshooting

### Custom provider not connecting
```bash
# Test the endpoint
curl https://your-provider-url.com/v1/models \
  -H "Authorization: Bearer YOUR_API_KEY"
```

### Ollama not detected
```bash
# Make sure Ollama is running
ollama serve

# Test Ollama API
curl http://localhost:11434/api/tags
```

### Check configuration
```bash
# View current config
moltbot config get

# Check model availability
moltbot models list

# Run diagnostics
moltbot doctor
```

## Security Note

⚠️ **Never commit API keys to git!**

- Add `config.json` to `.gitignore`
- Use environment variables for production
- Rotate keys regularly

## See Also

- [Ollama Provider Docs](https://docs.molt.bot/providers/ollama)
- [Local Models Guide](https://docs.molt.bot/gateway/local-models)
- [Model Configuration](https://docs.molt.bot/concepts/models)
