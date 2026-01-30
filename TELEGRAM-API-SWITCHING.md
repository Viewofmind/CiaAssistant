# Telegram Bot API Switching Commands

## 🎯 Quick Commands

You can now switch between OpenAI and Ollama Cloud APIs directly from Telegram!

### Commands:

| Command | Effect | Model | Cost |
|---------|--------|-------|------|
| **"make me happy"** | Switch to Ollama Cloud | Llama 3.3 | FREE |
| **"be normal"** | Switch to OpenAI | GPT-4o | Paid (~$2.50-10/1M tokens) |

---

## 📱 How to Use

### Switch to Free Ollama Cloud:
Just message your Telegram bot `@AssistantGc_bot`:

```
make me happy
```

**Response:**
```
🌈 Switched to Ollama Cloud!

Now using: Llama 3.3 (Free)
API: https://api.ollama.com/v1
Cost: FREE

You're in happiness mode! 🎉
```

---

### Switch to Premium OpenAI:
Message your Telegram bot:

```
be normal
```

**Response:**
```
🔧 Switched to OpenAI!

Now using: GPT-4o (Paid)
API: https://api.openai.com/v1
Cost: ~$2.50-10 per 1M tokens

Back to normal mode! 💼
```

---

## ⚙️ How It Works

### Behind the Scenes:
1. The `api-switcher` skill is installed on your VM
2. When Cia (your bot) detects "make me happy" or "be normal", it runs a command
3. The command updates `~/.clawdbot/config.json` to change the primary model
4. The gateway automatically restarts (takes ~5 seconds)
5. Your next message uses the new API

### Technical Details:
- **Config file**: `~/.clawdbot/config.json` on VM
- **Skill location**: `~/moltbot/skills/api-switcher/`
- **Gateway restart**: Automatic via `pkill` + restart
- **Downtime**: ~5 seconds during switch

---

## 🔍 Check Current API

To see which API you're currently using, ask Cia:

```
What model are you using?
```

Or check manually via SSH:
```bash
ssh moltbot-vm 'cat ~/.clawdbot/config.json | jq -r ".agents.defaults.model.primary"'
```

---

## 📊 API Comparison

### Ollama Cloud (Free) - Llama 3.3
✅ **Pros:**
- Completely FREE
- Good quality responses
- Fast enough for most tasks
- Text-only input

⚠️ **Cons:**
- Slightly slower than OpenAI
- No image understanding
- Quality not quite as high as GPT-4o

**Best for:**
- Casual conversations
- Simple questions
- Testing/development
- Saving money

---

### OpenAI (Paid) - GPT-4o
✅ **Pros:**
- Highest quality responses
- Very fast
- Image understanding (send photos)
- Latest GPT-4o model

⚠️ **Cons:**
- Costs money (~$50-100/month for heavy use)
- Uses your OpenAI credits
- Overkill for simple questions

**Best for:**
- Complex tasks
- Important work
- Image analysis
- When quality matters most

---

## 💡 Smart Usage Tips

### Daily Strategy:
1. **Start your day**: `be normal` (OpenAI for important work)
2. **Casual chats**: `make me happy` (Ollama for fun)
3. **Complex task**: `be normal` (OpenAI for quality)
4. **End of day**: `make me happy` (Ollama to save credits)

### Cost Saving:
- Use Ollama Cloud for 80% of conversations (free)
- Switch to OpenAI only when you need the best quality
- Average savings: ~$40-80/month

---

## 🚨 Troubleshooting

### Bot Not Responding After Switch:
- **Reason**: Gateway is restarting (takes ~5 seconds)
- **Fix**: Wait 10 seconds and try again

### Switch Command Not Working:
1. Check if gateway is running:
   ```bash
   ssh moltbot-vm 'ps aux | grep moltbot-gateway'
   ```

2. Check skill is installed:
   ```bash
   ssh moltbot-vm 'cd ~/moltbot && pnpm moltbot skills list | grep api-switcher'
   ```

3. Check gateway logs:
   ```bash
   ssh moltbot-vm 'tail -50 /tmp/moltbot-gateway.log'
   ```

### Gateway Stuck:
If the gateway doesn't restart properly:

```bash
ssh moltbot-vm 'pkill -9 -f moltbot-gateway && cd ~/moltbot && nohup pnpm moltbot gateway run --bind loopback --port 18789 --force > /tmp/moltbot-gateway.log 2>&1 &'
```

---

## 📋 Manual Switching (Alternative Methods)

### Method 1: Shell Script (From Mac)
```bash
# Switch to Ollama
./switch-api.sh ollama

# Switch to OpenAI
./switch-api.sh openai
```

### Method 2: Direct SSH Command
```bash
# Switch to Ollama
ssh moltbot-vm 'cat ~/.clawdbot/config.json | jq ".agents.defaults.model.primary = \"ollama-cloud/llama3.3\"" > /tmp/config-temp.json && mv /tmp/config-temp.json ~/.clawdbot/config.json && pkill -f moltbot-gateway && sleep 2 && cd ~/moltbot && nohup pnpm moltbot gateway run --bind loopback --port 18789 --force > /tmp/moltbot-gateway.log 2>&1 &'

# Switch to OpenAI
ssh moltbot-vm 'cat ~/.clawdbot/config.json | jq ".agents.defaults.model.primary = \"openai/gpt-4o\"" > /tmp/config-temp.json && mv /tmp/config-temp.json ~/.clawdbot/config.json && pkill -f moltbot-gateway && sleep 2 && cd ~/moltbot && nohup pnpm moltbot gateway run --bind loopback --port 18789 --force > /tmp/moltbot-gateway.log 2>&1 &'
```

---

## ✅ Skill Status

**Skill Name**: `api-switcher`
**Status**: ✅ Ready
**Location**: `/home/azureuser/moltbot/skills/api-switcher/SKILL.md`
**Triggers**: "make me happy", "be normal"
**Emoji**: 🔄

---

## 🎉 Summary

You can now switch APIs with simple commands:
- `make me happy` → Free Ollama Cloud
- `be normal` → Premium OpenAI

No need to SSH, no need to run scripts. Just talk to your bot naturally!

**Try it now**: Message `@AssistantGc_bot` on Telegram:
```
make me happy
```

Then test with a question, then switch back:
```
be normal
```

Enjoy your flexible AI assistant! 🚀
