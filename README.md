# Cia Assistant 🤖

**A fully configured Moltbot instance with AI API switching, 24/7 Azure VM deployment, and Telegram integration.**

> This is a customized deployment of [Moltbot](https://github.com/moltbot/moltbot) with advanced features including voice-command API switching between OpenAI and Ollama Cloud.

---

## ✨ Features

### 🔄 **Dynamic API Switching**
- Switch between OpenAI (paid, premium quality) and Ollama Cloud (free, good quality) with simple voice commands
- **"make me happy"** → Switch to FREE Ollama Cloud (Llama 3.3)
- **"be normal"** → Switch to PREMIUM OpenAI (GPT-4o)
- Save $40-80/month by using free Ollama for casual conversations

### 🌐 **24/7 Availability**
- Deployed on Azure VM (Ubuntu 24.04)
- Auto-start on boot
- Always-on Telegram bot: [@AssistantGc_bot](https://t.me/AssistantGc_bot)
- Web interface via localhost tunnel

### 🎯 **8 Ready-to-Use Skills**
- 🔄 **API Switcher** - Voice-command API switching
- 🐙 **GitHub** - Manage repos, issues, PRs
- 🎞️ **Video Frames** - Extract frames from videos
- 🌤️ **Weather** - Get forecasts (no API key needed)
- 🧵 **Tmux** - Terminal session control
- 🧩 **Coding Agent** - AI coding assistant
- 📦 **Skill Creator** - Create custom skills
- 📦 **BlueBubbles** - iMessage integration

### 💰 **Cost Optimization**
- Primary: Ollama Cloud (FREE)
- Fallback: OpenAI GPT-4o (Paid)
- Smart switching saves money while maintaining quality

---

## 🚀 Quick Start

### Prerequisites
- Node.js 22+
- pnpm (or npm/bun)
- Azure VM (or any Linux server)
- Telegram account

### 1. Clone & Install
```bash
git clone https://github.com/riverflylastrada/CiaAssistant.git
cd CiaAssistant
pnpm install
```

### 2. Configure API Keys
Copy the example configuration and add your API keys:

```bash
# See QUICK-START-GUIDE.md for detailed setup instructions
cp moltbot-config.example.json ~/.clawdbot/config.json

# Edit with your API keys
nano ~/.clawdbot/config.json
```

**Required API Keys:**
- OpenAI API key (get from [platform.openai.com](https://platform.openai.com))
- Ollama Cloud API key (get from [ollama.com](https://ollama.com))
- Telegram Bot Token (create via [@BotFather](https://t.me/BotFather))

⚠️ **Important**: Never commit API keys to git! They're excluded via `.gitignore`.

### 3. Start the Gateway
```bash
pnpm moltbot gateway run --bind loopback --port 18789
```

### 4. Test via Telegram
Message your bot: `@YourBotName`

Try the API switcher:
```
make me happy
What's the weather?
be normal
Tell me a joke
```

---

## 📚 Documentation

| Guide | Description |
|-------|-------------|
| [Quick Start Guide](QUICK-START-GUIDE.md) | Get started in 5 minutes |
| [API Switching Guide](API-SWITCHING-GUIDE.md) | How to switch between OpenAI and Ollama |
| [Telegram API Switching](TELEGRAM-API-SWITCHING.md) | Voice commands for API switching |
| [Skills Installed](SKILLS-INSTALLED.md) | All 8 installed skills and how to use them |
| [VM 24/7 Setup](VM-24-7-SETUP.md) | Azure VM deployment and auto-start |
| [Config Setup Guide](CONFIG-SETUP-GUIDE.md) | Detailed configuration instructions |

---

## 🎯 Usage

### Telegram Bot Commands

**API Switching:**
```
make me happy     # Switch to free Ollama Cloud
be normal         # Switch to premium OpenAI
```

**General Usage:**
```
What's the weather?
Show me my GitHub repos
Extract frames from this video: [URL]
Create a tmux session
```

### Web Interface
Access via: `http://localhost:18789/chat`

Requires SSH tunnel:
```bash
ssh -f -N -L 18789:localhost:18789 your-vm-host
```

---

## ⚙️ Architecture

### Deployment Diagram
```
┌─────────────────────────────────────────┐
│ Azure VM (Ubuntu 24.04)                 │
│ 74.235.97.193                           │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ Moltbot Gateway                 │   │
│  │ Port: 18789 (localhost only)    │   │
│  │ Auto-start on boot              │   │
│  └──────────────┬──────────────────┘   │
│                 │                       │
└─────────────────┼───────────────────────┘
                  │
        ┌─────────┴─────────┐
        │                   │
    ┌───▼────┐        ┌────▼─────┐
    │Telegram│        │SSH Tunnel│
    │  Bot   │        │localhost │
    └────────┘        └──────────┘
```

### API Provider Flow
```
User Message
     │
     ▼
┌────────────────┐
│ Detect Command │
│ make me happy? │ ──Yes──► Switch to Ollama Cloud (FREE)
│ be normal?     │ ──Yes──► Switch to OpenAI (PAID)
└────────┬───────┘
         │ No
         ▼
┌──────────────────┐
│ Current Provider │
│ - Ollama Cloud   │ ──► Llama 3.3 (Free, Good Quality)
│   OR              │
│ - OpenAI         │ ──► GPT-4o (Paid, Best Quality)
└──────────────────┘
```

---

## 🔧 Advanced Configuration

### Custom Skills
Create your own skills in `~/moltbot/skills/`:

```bash
mkdir ~/moltbot/skills/my-skill
nano ~/moltbot/skills/my-skill/SKILL.md
```

See [Skill Creator Guide](https://docs.molt.bot/skills) for details.

### API Providers
Configured providers:
- **OpenAI**: GPT-4o, GPT-4o-mini, GPT-3.5-turbo
- **Ollama Cloud**: Llama 3.3, DeepSeek R1 32B
- **Custom**: Your own OpenAI-compatible endpoint

Edit `~/.clawdbot/config.json` to add more providers.

### Environment Variables
For secure production deployment:

```bash
export OPENAI_API_KEY="your-openai-key"
export OLLAMA_API_KEY="your-ollama-key"
export TELEGRAM_BOT_TOKEN="your-telegram-token"
```

Then use `env:` references in config.json:
```json
{
  "apiKey": "env:OPENAI_API_KEY"
}
```

---

## 💡 Tips & Best Practices

### Cost Savings
1. **Start with Ollama** (free) for daily use: `make me happy`
2. **Switch to OpenAI** (paid) only when you need the best quality: `be normal`
3. **Average savings**: $40-80/month

### Quality vs. Cost
| Task | Recommended API | Why |
|------|----------------|-----|
| Casual chat | Ollama Cloud | Free, good enough |
| Complex coding | OpenAI | Better accuracy |
| Image analysis | OpenAI | Ollama doesn't support images |
| Simple questions | Ollama Cloud | Save credits |
| Important work | OpenAI | Highest quality |

### Security
- ✅ Gateway binds to localhost only (not exposed to internet)
- ✅ Telegram uses encrypted WebSocket
- ✅ SSH tunnel encrypts all traffic
- ✅ API keys stored in config (excluded from git)
- ✅ No public ports open except SSH

---

## 🚨 Troubleshooting

### Bot Not Responding
```bash
# Check if gateway is running
ssh your-vm 'ps aux | grep moltbot-gateway'

# Check logs
ssh your-vm 'tail -50 /tmp/moltbot-gateway.log'

# Restart gateway
ssh your-vm 'pkill -f moltbot-gateway && cd ~/moltbot && nohup pnpm moltbot gateway run --bind loopback --port 18789 --force > /tmp/moltbot-gateway.log 2>&1 &'
```

### API Switch Not Working
```bash
# Check skill is installed
ssh your-vm 'cd ~/moltbot && pnpm moltbot skills list | grep api-switcher'

# Should show: ✓ ready │ 🔄 api-switcher
```

### VM Stopped
If VM gets deallocated (Azure auto-shutdown):

```bash
# Start VM
az vm start --name socialcoffee --resource-group SOCIALCOFFEE_GROUP

# Wait 60 seconds for boot
sleep 60

# Reconnect SSH tunnel
ssh -f -N -L 18789:localhost:18789 your-vm
```

Gateway will auto-start on boot (configured in cron).

### More Help
- Check [VM-24-7-SETUP.md](VM-24-7-SETUP.md) for deployment issues
- Check [API-SWITCHING-GUIDE.md](API-SWITCHING-GUIDE.md) for switching problems
- Check [Skills Installed](SKILLS-INSTALLED.md) for skill issues

---

## 📊 Project Status

- ✅ **Deployed**: Azure VM (Ubuntu 24.04)
- ✅ **Bot Active**: [@AssistantGc_bot](https://t.me/AssistantGc_bot)
- ✅ **Skills Ready**: 8/52 skills installed
- ✅ **Auto-start**: Configured via cron
- ✅ **API Switching**: Working via voice commands
- ✅ **24/7 Uptime**: Auto-shutdown disabled

---

## 🤝 Contributing

This is a personal Moltbot deployment. For contributing to the core Moltbot project, see:
- [Moltbot GitHub](https://github.com/moltbot/moltbot)
- [Moltbot Docs](https://docs.molt.bot)

---

## 📝 License

This project uses [Moltbot](https://github.com/moltbot/moltbot) which is licensed under the MIT License.

Configuration and custom skills in this repository: MIT License

---

## 🙏 Acknowledgments

- Built with [Moltbot](https://github.com/moltbot/moltbot) by Anthropic
- Powered by OpenAI GPT-4o and Ollama Cloud
- Deployed on Microsoft Azure
- Telegram bot platform

---

## 📞 Support

- **Telegram**: [@AssistantGc_bot](https://t.me/AssistantGc_bot)
- **Moltbot Docs**: [docs.molt.bot](https://docs.molt.bot)
- **Moltbot GitHub Issues**: [github.com/moltbot/moltbot/issues](https://github.com/moltbot/moltbot/issues)

---

## 🎉 Getting Started

Ready to use Cia? Just message on Telegram:

```
@AssistantGc_bot make me happy
```

Then ask anything! The bot is always online and ready to help. 🚀

---

**Made with ❤️ using Moltbot**
