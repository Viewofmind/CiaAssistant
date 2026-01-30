# API Switching Guide - OpenAI ↔ Ollama Cloud

## 🎯 Quick Switch

### **Method 1: One-Click Script** (Easiest!)

```bash
# Switch to OpenAI
./switch-api.sh openai

# Switch to Ollama Cloud
./switch-api.sh ollama

# Check current model
./switch-api.sh
```

---

## 📊 Available APIs:

### 1️⃣ **OpenAI** (Paid)
- **Model**: GPT-4o
- **API**: `https://api.openai.com/v1`
- **Cost**: ~$2.50 per 1M input tokens, ~$10 per 1M output tokens
- **Quality**: ⭐⭐⭐⭐⭐ (Excellent)
- **Speed**: ⭐⭐⭐⭐ (Fast)
- **Features**: Text + Image input

### 2️⃣ **Ollama Cloud** (Free)
- **Model**: Llama 3.3
- **API**: `https://api.ollama.com/v1`
- **Cost**: FREE
- **Quality**: ⭐⭐⭐⭐ (Very Good)
- **Speed**: ⭐⭐⭐ (Good)
- **Features**: Text only

---

## 🔄 Method 2: Manual Switch

### Switch to OpenAI:
```bash
ssh moltbot-vm 'cat ~/.clawdbot/config.json | jq ".agents.defaults.model.primary = \"openai/gpt-4o\"" > /tmp/config.json && mv /tmp/config.json ~/.clawdbot/config.json'

# Restart gateway
ssh moltbot-vm 'pkill -f moltbot-gateway && cd ~/moltbot && nohup pnpm moltbot gateway run --bind loopback --port 18789 --force > /tmp/moltbot-gateway.log 2>&1 &'
```

### Switch to Ollama Cloud:
```bash
ssh moltbot-vm 'cat ~/.clawdbot/config.json | jq ".agents.defaults.model.primary = \"ollama-cloud/llama3.3\"" > /tmp/config.json && mv /tmp/config.json ~/.clawdbot/config.json'

# Restart gateway
ssh moltbot-vm 'pkill -f moltbot-gateway && cd ~/moltbot && nohup pnpm moltbot gateway run --bind loopback --port 18789 --force > /tmp/moltbot-gateway.log 2>&1 &'
```

---

## 🎛️ Method 3: Edit Config Directly

```bash
# SSH to VM
ssh moltbot-vm

# Edit config
nano ~/.clawdbot/config.json
```

Find this line:
```json
"primary": "ollama-cloud/llama3.3"
```

Change to:
```json
"primary": "openai/gpt-4o"
```

Save and restart gateway.

---

## 📋 Available Models:

### OpenAI:
- `openai/gpt-4o` (Best, latest)
- `openai/gpt-4o-mini` (Faster, cheaper)
- `openai/gpt-4-turbo`
- `openai/gpt-3.5-turbo` (Cheapest)

### Ollama Cloud:
- `ollama-cloud/llama3.3` (Recommended)
- `ollama-cloud/deepseek-r1:32b` (Reasoning)
- `ollama-cloud/tomasmcm/zephyr-1b-olmo-sft-qlora` (Happiness mode)

---

## 🔍 Check Current API:

```bash
# Method 1: Check config
ssh moltbot-vm 'cat ~/.clawdbot/config.json | jq -r ".agents.defaults.model.primary"'

# Method 2: Check gateway logs
ssh moltbot-vm 'grep "agent model" /tmp/moltbot-gateway.log | tail -1'

# Method 3: Ask Cia!
# Send to @AssistantGc_bot:
"What model are you currently using?"
```

---

## 💡 Smart Switching Strategies:

### **Use OpenAI when:**
- Need highest quality responses
- Working on complex tasks
- Need image understanding
- Cost is not a concern

### **Use Ollama Cloud when:**
- Casual conversations
- Simple questions
- Testing/development
- Want to save money (it's free!)

### **Hybrid Approach:**
```json
{
  "primary": "openai/gpt-4o",
  "fallbacks": [
    "ollama-cloud/llama3.3",
    "ollama-cloud/deepseek-r1:32b"
  ]
}
```
This uses OpenAI first, falls back to Ollama if it fails!

---

## 🎨 Advanced: Per-Channel Configuration

You can use different models for different channels:

```json
{
  "agents": {
    "defaults": {
      "model": { "primary": "openai/gpt-4o" }
    },
    "telegram": {
      "model": { "primary": "ollama-cloud/llama3.3" }
    },
    "web": {
      "model": { "primary": "openai/gpt-4o" }
    }
  }
}
```

---

## 🔐 API Keys Configuration:

### Check if OpenAI is configured:
```bash
ssh moltbot-vm 'cd ~/moltbot && pnpm moltbot models list | grep openai'
```

### Check Ollama Cloud:
```bash
ssh moltbot-vm 'cat ~/.clawdbot/config.json | jq ".models.providers.\"ollama-cloud\""'
```

---

## 🚨 Troubleshooting:

### Model not working after switch:
```bash
# 1. Check if gateway restarted
ssh moltbot-vm 'ps aux | grep moltbot-gateway'

# 2. Check logs for errors
ssh moltbot-vm 'tail -50 /tmp/moltbot-gateway.log'

# 3. Verify config
ssh moltbot-vm 'cat ~/.clawdbot/config.json | jq ".agents.defaults.model"'
```

### OpenAI "unauthorized" error:
- Check if OpenAI API key is valid
- Verify credits/billing on OpenAI account

### Ollama Cloud not responding:
- Check internet connection
- Verify API key is correct
- Try switching to OpenAI temporarily

---

## 📊 Cost Comparison:

### Example: 1000 messages/day

| Provider | Monthly Cost | Quality | Speed |
|----------|-------------|---------|-------|
| **OpenAI GPT-4o** | ~$50-100 | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| **OpenAI GPT-4o-mini** | ~$5-15 | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| **Ollama Cloud** | $0 (FREE) | ⭐⭐⭐⭐ | ⭐⭐⭐ |

---

## ✅ Quick Reference:

```bash
# Switch to OpenAI
./switch-api.sh openai

# Switch to Ollama
./switch-api.sh ollama

# Check current
ssh moltbot-vm 'cat ~/.clawdbot/config.json | jq -r ".agents.defaults.model.primary"'

# Test via Telegram
# Message: @AssistantGc_bot "What model are you using?"
```

---

## 🎯 Recommended Setup:

**For Best Balance:**
```json
{
  "primary": "ollama-cloud/llama3.3",
  "fallbacks": [
    "openai/gpt-4o-mini",
    "openai/gpt-4o"
  ]
}
```

- Normal chats: Free (Ollama)
- If Ollama fails: Falls back to OpenAI
- Best of both worlds!

---

**Ready to switch?** Run: `./switch-api.sh openai` or `./switch-api.sh ollama`
