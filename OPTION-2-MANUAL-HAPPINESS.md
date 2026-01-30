# Option 2: Manual Setup with "Make Me Happy" Trigger

## 🎯 What You Wanted

You want to be able to say **"Make me happy"** to your bot (Cia), and have it automatically switch to the `tomasmcm/zephyr-1b-olmo-sft-qlora` Ollama model for cheerful, uplifting conversations.

## ✅ What I Created

### Files:
1. **[HAPPINESS-MODE-GUIDE.md](HAPPINESS-MODE-GUIDE.md)** ← Complete guide
2. **[happiness-trigger.sh](happiness-trigger.sh)** ← Automated setup script
3. **[moltbot-config-with-happiness.json](moltbot-config-with-happiness.json)** ← Config file
4. **[cia-happiness-skill.js](cia-happiness-skill.js)** ← Optional skill for advanced users

---

## 🚀 Quick Setup (3 Steps)

### Step 1: Install the Happiness Model
```bash
# Pull the Zephyr model from Ollama
ollama pull tomasmcm/zephyr-1b-olmo-sft-qlora
```

### Step 2: Update Your Configuration
```bash
# Option A: Use the automated script (easiest)
./happiness-trigger.sh

# Option B: Manual copy
cp moltbot-config-with-happiness.json ~/.moltbot/config.json
# Then edit to add your provider's base URL
nano ~/.moltbot/config.json
```

### Step 3: Test It!
```bash
# Say the magic words
moltbot agent --message "Make me happy"

# Cia will respond using the cheerful Zephyr model! 🎉
```

---

## 💬 How to Use

### Activate Happiness Mode:
Just say any of these phrases to Cia:
- **"Make me happy"** ← Your requested phrase
- "Cheer me up"
- "I need some cheer"
- "Switch to happy mode"

### Deactivate (Back to Normal):
- "Back to normal"
- "Normal mode"
- "Switch back"

---

## 🎭 Example Conversation

```
You: Hello Cia
Cia: [Using primary model] Hello! How can I help you today?

You: Make me happy
Cia: [Switches to Zephyr] 🎉 Oh absolutely! I'd love to brighten your day!
     You're amazing and today is full of possibilities! What would make
     you smile right now?

You: Tell me something nice
Cia: [Still in happy mode] You are capable of wonderful things! Every day
     you're making progress, even when it doesn't feel like it. The world
     is better with you in it! ✨

You: Thanks! Back to normal mode
Cia: [Switches to primary] Returned to standard mode. How else can I help?
```

---

## 🔧 Manual Configuration

If you prefer to configure manually:

### 1. Add the Model to Your Config

Edit `~/.moltbot/config.json` and add to the `models.providers.ollama.models` array:

```json
{
  "id": "tomasmcm/zephyr-1b-olmo-sft-qlora",
  "name": "Zephyr Happy Mode",
  "reasoning": false,
  "input": ["text"],
  "cost": { "input": 0, "output": 0, "cacheRead": 0, "cacheWrite": 0 },
  "contextWindow": 8192,
  "maxTokens": 2048
}
```

### 2. Add Agent Instructions

In your config, update the agent settings:

```json
{
  "agents": {
    "defaults": {
      "name": "Cia",
      "instructions": "You are Cia, a helpful AI assistant. When the user says 'Make me happy', switch to using the ollama/tomasmcm/zephyr-1b-olmo-sft-qlora model for cheerful conversations. When they say 'back to normal', switch back to the primary model.",
      "models": {
        "ollama/tomasmcm/zephyr-1b-olmo-sft-qlora": { "alias": "Happy Mode" }
      }
    }
  }
}
```

### 3. Test

```bash
moltbot models list
# Should show: ollama/tomasmcm/zephyr-1b-olmo-sft-qlora

moltbot agent --message "Make me happy"
```

---

## 🎨 Your Complete Configuration

Your full config file includes:

### Providers:
- **Primary**: Custom OpenAI-compatible provider
  - API Key: `1bc41bc8772346feaa2e8bfb7f723667.X33IblFyZkxSqpMyYLXZWurs`

- **Ollama** (Multiple models):
  - API Key: `61f0d384fd444ed6a49dd6054979be29.-r4AZG_weAokLkhzk-GkK8Ms`
  - Models:
    - `llama3.3` (General backup)
    - `deepseek-r1:32b` (Reasoning backup)
    - `tomasmcm/zephyr-1b-olmo-sft-qlora` (Happiness mode) ⭐

### Fallback Chain:
1. Custom provider (primary)
2. Ollama llama3.3 (if primary fails)
3. Ollama deepseek-r1 (if llama fails)

### Special Trigger:
- "Make me happy" → Switches to Zephyr model

---

## 🔄 How the Switching Works

### Automatic (with instructions):
The agent's instructions tell it to recognize "Make me happy" and switch models accordingly.

### Manual (direct command):
```bash
# Switch to happiness model
moltbot agent --message "Hello" --model ollama/tomasmcm/zephyr-1b-olmo-sft-qlora

# Switch back to primary
moltbot agent --message "Hello" --model custom/your-model-name
```

### Advanced (with skill):
For more sophisticated control, install the [cia-happiness-skill.js](cia-happiness-skill.js):

```bash
# Copy skill to Moltbot skills directory
cp cia-happiness-skill.js ~/.moltbot/skills/

# The skill will automatically intercept "Make me happy" phrases
```

---

## 📊 Model Comparison

| Feature | Primary (Custom) | Happiness (Zephyr) |
|---------|------------------|-------------------|
| **Size** | Varies | 1B parameters (tiny!) |
| **Speed** | Medium | Very fast |
| **Context** | 128k tokens | 8k tokens |
| **Purpose** | General tasks | Cheerful chat |
| **Cost** | Paid (your API) | Free (local) |
| **Personality** | Professional | Uplifting & cheerful |
| **Best for** | Complex tasks | Mood boosts, encouragement |

---

## 🎓 Advanced Options

### Create Custom Trigger Phrases

Edit the agent instructions to add more triggers:

```json
{
  "instructions": "Triggers: 'Make me happy' → zephyr, 'Inspire me' → zephyr, 'Motivate me' → zephyr"
}
```

### Add More Mood Models

```bash
# Pull another model
ollama pull another-cheerful-model

# Add to config
# Update instructions with new trigger phrase
```

### Create a Shortcut Command

```bash
# Add to ~/.bashrc or ~/.zshrc
alias happy='moltbot agent --model ollama/tomasmcm/zephyr-1b-olmo-sft-qlora --message'

# Usage:
happy "Tell me something nice"
```

---

## 🐛 Troubleshooting

### Model not switching?

```bash
# Check if model is installed
ollama list | grep zephyr

# Pull if missing
ollama pull tomasmcm/zephyr-1b-olmo-sft-qlora

# Verify in Moltbot
moltbot models list
```

### Agent doesn't recognize "Make me happy"?

The phrase recognition depends on your model's ability to follow instructions. Try:

1. **Use the skill method** (more reliable):
   ```bash
   cp cia-happiness-skill.js ~/.moltbot/skills/
   ```

2. **Use direct model switching**:
   ```bash
   moltbot agent --message "Make me happy" --model ollama/tomasmcm/zephyr-1b-olmo-sft-qlora
   ```

3. **Check your agent instructions**:
   ```bash
   moltbot config get | grep -A 5 instructions
   ```

---

## 📚 Documentation Links

- **Complete Guide**: [HAPPINESS-MODE-GUIDE.md](HAPPINESS-MODE-GUIDE.md)
- **Main Setup**: [SETUP-README.md](SETUP-README.md)
- **Configuration Guide**: [CONFIG-SETUP-GUIDE.md](CONFIG-SETUP-GUIDE.md)
- **Ollama Provider**: https://docs.molt.bot/providers/ollama

---

## ✨ Summary

### What You Get:
✅ Primary AI provider for serious work
✅ Ollama backups for reliability
✅ Special "happiness mode" with Zephyr model
✅ Automatic switching with "Make me happy" phrase
✅ All running locally and for free (except primary)

### One Command Setup:
```bash
./happiness-trigger.sh
```

### Test Happiness Mode:
```bash
moltbot agent --message "Make me happy"
```

**Enjoy your cheerful AI assistant!** 🎉
