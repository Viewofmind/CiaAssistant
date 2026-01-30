# 🎉 Happiness Mode Guide for Cia

This guide explains how to set up Cia (your bot) to automatically switch to the cheerful `tomasmcm/zephyr-1b-olmo-sft-qlora` model when you say "Make me happy".

---

## 🚀 Quick Setup

```bash
./happiness-trigger.sh
```

This will:
1. Install the Zephyr happiness model via Ollama
2. Set up the configuration with model switching
3. Create helper scripts for manual switching
4. Test everything

---

## 🎭 How It Works

### The Models:

1. **Primary Model** (Custom Provider)
   - Your main AI for normal conversations
   - API Key: `1bc41bc8772346feaa2e8bfb7f723667.X33IblFyZkxSqpMyYLXZWurs`

2. **Happiness Model** (Ollama)
   - Model: `tomasmcm/zephyr-1b-olmo-sft-qlora`
   - Small, fast, cheerful model optimized for uplifting conversations
   - Runs locally via Ollama

3. **Fallback Models** (Ollama)
   - `llama3.3` - General backup
   - `deepseek-r1:32b` - Advanced reasoning backup

### The Trigger:

When you say **"Make me happy"** to Cia, the bot will:
1. Recognize the phrase
2. Switch to the Zephyr happiness model
3. Respond in a more cheerful, uplifting manner
4. Stay in happiness mode until you say "back to normal"

---

## 📖 Usage Examples

### Method 1: Natural Language (Recommended)

```bash
# Start a conversation with Cia
moltbot agent --message "Hello Cia!"
# Response: [Using primary model]

# Trigger happiness mode
moltbot agent --message "Make me happy"
# Response: [Switches to Zephyr model, cheerful response]

# Continue in happiness mode
moltbot agent --message "Tell me something nice"
# Response: [Still using Zephyr, uplifting message]

# Switch back
moltbot agent --message "Back to normal mode"
# Response: [Switches back to primary model]
```

### Method 2: Helper Script

```bash
# Enable happiness mode
~/.moltbot/scripts/happiness-mode on

# Disable happiness mode
~/.moltbot/scripts/happiness-mode off
```

### Method 3: Direct Model Selection

```bash
# Use happiness model directly
moltbot agent --message "Tell me a joke!" --model ollama/tomasmcm/zephyr-1b-olmo-sft-qlora

# Back to primary
moltbot agent --message "What's the weather?" --model custom/your-model-name
```

---

## 🔧 Configuration Details

The configuration file ([moltbot-config-with-happiness.json](moltbot-config-with-happiness.json)) includes:

```json
{
  "agents": {
    "defaults": {
      "name": "Cia",
      "instructions": "When user says 'Make me happy', switch to ollama/tomasmcm/zephyr-1b-olmo-sft-qlora"
    }
  },
  "models": {
    "providers": {
      "ollama": {
        "models": [
          {
            "id": "tomasmcm/zephyr-1b-olmo-sft-qlora",
            "name": "Zephyr Happy Mode"
          }
        ]
      }
    }
  }
}
```

---

## 🎯 Trigger Phrases

### To Activate Happiness Mode:
- "Make me happy"
- "I need some cheer"
- "Cheer me up"
- "Switch to happy mode"
- "Use the happiness model"

### To Deactivate:
- "Back to normal"
- "Normal mode please"
- "Switch back"
- "Regular mode"

---

## 🛠️ Manual Installation

If you prefer to set up manually:

### 1. Install the Zephyr Model

```bash
ollama pull tomasmcm/zephyr-1b-olmo-sft-qlora
```

### 2. Add to Moltbot Config

Edit `~/.moltbot/config.json` and add to the Ollama models array:

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

### 3. Update Agent Instructions

Add to your agent defaults:

```json
{
  "agents": {
    "defaults": {
      "name": "Cia",
      "instructions": "You are Cia. When the user says 'Make me happy', switch to using the ollama/tomasmcm/zephyr-1b-olmo-sft-qlora model."
    }
  }
}
```

### 4. Test

```bash
moltbot models list
# Should show: ollama/tomasmcm/zephyr-1b-olmo-sft-qlora

moltbot agent --message "Make me happy" --thinking low
```

---

## 🎨 Customization

### Change the Trigger Phrase

Edit `~/.moltbot/config.json`:

```json
{
  "agents": {
    "defaults": {
      "instructions": "When user says 'YOUR_CUSTOM_PHRASE', switch to ollama/tomasmcm/zephyr-1b-olmo-sft-qlora"
    }
  }
}
```

### Use a Different Happiness Model

```bash
# Pull a different model
ollama pull another-happy-model

# Update config with the new model ID
nano ~/.moltbot/config.json
```

### Create Multiple Mood Modes

```json
{
  "agents": {
    "defaults": {
      "instructions": "Mood modes: 'Make me happy' → zephyr, 'Make me creative' → llama3.3, 'Make me analytical' → deepseek-r1"
    }
  }
}
```

---

## 📊 Model Comparison

| Feature | Primary (Custom) | Happiness (Zephyr) | Fallback (Llama) |
|---------|------------------|-------------------|------------------|
| Speed | Medium | Very Fast | Medium |
| Context | 128k tokens | 8k tokens | 128k tokens |
| Purpose | General tasks | Cheerful chat | Backup |
| Cost | Paid | Free (local) | Free (local) |
| Tone | Neutral | Uplifting | Balanced |

---

## 🐛 Troubleshooting

### "Model not found" error

```bash
# Check if model is installed
ollama list | grep zephyr

# If not, pull it
ollama pull tomasmcm/zephyr-1b-olmo-sft-qlora

# Verify in Moltbot
moltbot models list
```

### Switching doesn't work

```bash
# Check your config
moltbot config get | grep -A 5 instructions

# Make sure the model is in your config
moltbot config get | grep zephyr

# Try direct switching
moltbot agent --message "Test" --model ollama/tomasmcm/zephyr-1b-olmo-sft-qlora
```

### Model is slow

The Zephyr model is very small (1B parameters), so it should be fast. If it's slow:

```bash
# Check if Ollama is running
curl http://localhost:11434/api/tags

# Restart Ollama
ollama serve

# Check system resources
top | grep ollama
```

---

## 🎓 Advanced: Creating a Skill

For more sophisticated model switching, create a Moltbot skill:

```bash
# Create a skill directory
mkdir -p ~/.moltbot/skills/happiness

# Create the skill
cat > ~/.moltbot/skills/happiness/skill.ts << 'EOF'
import { defineSkill } from '@moltbot/plugin-sdk';

export default defineSkill({
  name: 'happiness',
  description: 'Switches to happiness mode when triggered',

  async execute(ctx) {
    const message = ctx.message.toLowerCase();

    if (message.includes('make me happy')) {
      await ctx.switchModel('ollama/tomasmcm/zephyr-1b-olmo-sft-qlora');
      return "🎉 Switching to happiness mode! Let's brighten your day!";
    }

    if (message.includes('back to normal')) {
      await ctx.switchModel('primary');
      return "👔 Back to normal mode!";
    }
  }
});
EOF
```

Then enable it in your config:

```json
{
  "skills": {
    "enabled": ["happiness"]
  }
}
```

---

## 📚 Related Documentation

- **Main Setup Guide**: [SETUP-README.md](SETUP-README.md)
- **Configuration Guide**: [CONFIG-SETUP-GUIDE.md](CONFIG-SETUP-GUIDE.md)
- **Ollama Provider**: https://docs.molt.bot/providers/ollama
- **Agent Configuration**: https://docs.molt.bot/concepts/agents

---

## 🌟 Tips for Best Results

1. **Keep conversations in context**: The Zephyr model has a smaller context window (8k vs 128k), so happiness mode works best for shorter, focused conversations

2. **Use for specific purposes**: Great for:
   - Getting motivational messages
   - Light-hearted chat
   - Quick mood boosts
   - Simple Q&A with cheerful responses

3. **Switch back for complex tasks**: For detailed analysis, code generation, or long documents, switch back to your primary model

4. **Combine with other tools**: Use happiness mode while chatting on WhatsApp, Telegram, or other channels

---

## 💡 Example Conversation Flow

```
You: Hey Cia, how are you?
Cia: [Primary Model] I'm functioning well, thank you. How can I assist you today?

You: Make me happy
Cia: [Switches to Zephyr] 🎉 Oh absolutely! I'd love to brighten your day!
     You're amazing and capable of wonderful things. What would bring you
     joy right now? A joke, some encouragement, or maybe a fun fact?

You: Tell me something encouraging
Cia: [Zephyr] Every single day is a fresh start and a new opportunity!
     You have unique strengths and talents that the world needs. Remember,
     progress isn't always linear, but every small step forward counts.
     You're doing great, and I believe in you! ✨

You: Thanks! Back to normal mode now
Cia: [Switches to Primary] Returned to standard operating mode. How else
     may I help you?
```

---

**Enjoy your happiness mode!** 🎉

If you need help or have questions, check the [troubleshooting section](#-troubleshooting) or see the main [SETUP-README.md](SETUP-README.md).
