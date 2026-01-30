# Moltbot Configuration Setup - Complete Guide

Your Moltbot has been configured with:
- **Primary AI**: Custom OpenAI-compatible provider
- **Backup AI**: Ollama (local, free, always available)

---

## 🚀 Quickest Start (One Command!)

```bash
./quick-start.sh
```

This script will:
1. Check if Ollama is installed
2. Pull required models (llama3.3, deepseek-r1, qwen-coder)
3. Ask for your custom provider's base URL and model ID
4. Create the complete configuration file
5. Test everything

**Done!** Your Moltbot is ready to use.

---

## 📋 Your API Keys

### Custom Provider (Primary)
- **API Key**: `1bc41bc8772346feaa2e8bfb7f723667.X33IblFyZkxSqpMyYLXZWurs`
- **You need to provide**: Base URL and Model ID

### Ollama (Backup)
- **API Key**: `61f0d384fd444ed6a49dd6054979be29.-r4AZG_weAokLkhzk-GkK8Ms`
- **Base URL**: `http://127.0.0.1:11434/v1`
- **Models**: llama3.3, deepseek-r1:32b, qwen2.5-coder:32b

See [YOUR-API-KEYS.md](YOUR-API-KEYS.md) for complete details.

---

## 📁 Files Created

| File | Purpose |
|------|---------|
| [quick-start.sh](quick-start.sh) | **Start here!** Automated setup |
| [YOUR-API-KEYS.md](YOUR-API-KEYS.md) | Your API keys & setup summary |
| [CONFIG-SETUP-GUIDE.md](CONFIG-SETUP-GUIDE.md) | Detailed manual setup guide |
| [moltbot-config.example.json](moltbot-config.example.json) | Config with hardcoded keys |
| [moltbot-config-secure.example.json](moltbot-config-secure.example.json) | Config using environment variables |
| [setup-env.sh](setup-env.sh) | Interactive environment setup |

---

## 🎯 Choose Your Setup Method

### Method 1: Automated (Recommended)
```bash
./quick-start.sh
```
Everything is done for you!

### Method 1.5: Automated + Happiness Mode 🎉
```bash
./happiness-trigger.sh
```
Includes everything from Method 1 PLUS:
- Zephyr happiness model for cheerful conversations
- Automatic switching when you say "Make me happy" to Cia
- See [HAPPINESS-MODE-GUIDE.md](HAPPINESS-MODE-GUIDE.md) for details

### Method 2: Manual with Hardcoded Keys
```bash
# 1. Install Ollama
ollama pull llama3.3

# 2. Copy config and update base URL
cp moltbot-config.example.json ~/.moltbot/config.json
nano ~/.moltbot/config.json  # Update "baseUrl"

# 3. Test
moltbot models list
```

### Method 3: Manual with Environment Variables (Most Secure)
```bash
# 1. Run setup script for env vars
./setup-env.sh

# 2. Install Ollama
ollama pull llama3.3

# 3. Copy secure config
cp moltbot-config-secure.example.json ~/.moltbot/config.json
nano ~/.moltbot/config.json  # Update "baseUrl"

# 4. Reload shell
source ~/.zshrc

# 5. Test
moltbot models list
```

---

## ✅ Testing Your Setup

### 1. Check Ollama is Running
```bash
ollama list
# Should show: llama3.3, deepseek-r1:32b, qwen2.5-coder:32b
```

### 2. Check Moltbot Can See All Models
```bash
moltbot models list
# Should show:
# - custom/your-model (Primary)
# - ollama/llama3.3 (Backup)
# - ollama/deepseek-r1:32b (Backup)
# - ollama/qwen2.5-coder:32b (Backup)
```

### 3. Test Primary Provider
```bash
moltbot agent --message "Hello, test message" --thinking low
```

### 4. Test Ollama Backup
```bash
moltbot agent --message "Testing Ollama" --model ollama/llama3.3
```

### 5. Test Failover
Stop your custom provider to force fallback to Ollama:
```bash
moltbot agent --message "Testing automatic fallback"
# Should automatically use Ollama if primary fails!
```

---

## 🔧 Changing API Keys Later

### Quick Change (Edit Config File)
```bash
nano ~/.moltbot/config.json
# Find and update the "apiKey" field
# Save and exit
moltbot config reload  # If needed
```

### Secure Change (Environment Variable)
If using the secure config:
```bash
# Update in your shell profile
nano ~/.zshrc  # or ~/.bashrc

# Add/update:
export CUSTOM_AI_API_KEY="new-key-here"
export OLLAMA_API_KEY="new-ollama-key-here"

# Reload
source ~/.zshrc
```

---

## 🛠️ Troubleshooting

### Ollama Not Working?
```bash
# Check if running
curl http://localhost:11434/api/tags

# If not, start it
ollama serve

# Pull models if missing
ollama pull llama3.3
ollama pull deepseek-r1:32b
```

### Custom Provider Not Working?
```bash
# Test the endpoint
curl YOUR_BASE_URL/models \
  -H "Authorization: Bearer YOUR_API_KEY"

# Check your base URL is correct
# Should end with /v1 usually
```

### Check Configuration
```bash
moltbot config get        # View current config
moltbot models list       # See available models
moltbot doctor           # Run diagnostics
```

### Still Having Issues?
See the detailed [CONFIG-SETUP-GUIDE.md](CONFIG-SETUP-GUIDE.md)

---

## 🔒 Security Notes

⚠️ **Important**:
- Never commit API keys to git
- Add `*.json` to `.gitignore` if sharing this repository
- Use environment variables for production environments
- Rotate API keys regularly

---

## 📚 Documentation

- **Moltbot Docs**: https://docs.molt.bot
- **Ollama Guide**: https://docs.molt.bot/providers/ollama
- **Local Models**: https://docs.molt.bot/gateway/local-models
- **Model Configuration**: https://docs.molt.bot/concepts/models

---

## 🎉 Next Steps

Once setup is complete:

1. **Start using Moltbot**:
   ```bash
   moltbot agent --message "What can you help me with?"
   ```

2. **Configure channels** (WhatsApp, Telegram, Discord, etc.):
   ```bash
   moltbot onboard
   ```

3. **Explore features**:
   - Voice commands (macOS/iOS)
   - Canvas rendering
   - Memory/embeddings
   - Skills and plugins

4. **Read the docs**: https://docs.molt.bot/start/getting-started

---

## 💡 How Your Failover Works

```
User Message
    ↓
Try Primary (Custom Provider)
    ↓ (if fails)
Try Backup 1 (Ollama llama3.3)
    ↓ (if fails)
Try Backup 2 (Ollama deepseek-r1)
    ↓ (if fails)
Try Backup 3 (Ollama qwen-coder)
    ↓
Response delivered!
```

Your assistant will **always work** even if your primary provider is down! 🎯

---

**Need Help?** Open an issue or check the [Discord community](https://discord.gg/clawd)
