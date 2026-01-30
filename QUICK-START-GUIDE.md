# 🚀 Moltbot Quick Start Guide

## ✅ Your Complete Setup

### VM Details:
- **Name**: socialcoffee
- **IP**: 74.235.97.193
- **User**: azureuser

### Services Running:
- ✅ Moltbot Gateway (port 18789)
- ✅ Telegram Bot (@AssistantGc_bot)
- ✅ Ollama Cloud (with happiness mode)

---

## 🎯 Quick Access Commands

### One-Click VS Code Connection:
```bash
./connect-vm.sh
```

### Or Double-Click:
`Moltbot-VM.code-workspace`

### SSH Access:
```bash
ssh moltbot-vm
# or
ssh socialcoffee
```

---

## 💬 How to Use Cia

### Via Telegram (Works Always):
1. Open Telegram
2. Find: `@AssistantGc_bot`
3. Send: `Make me happy` 🎉

### Via Web (When SSH tunnel active):
1. Open: `http://localhost:18789/chat`
2. Type: `Make me happy` 🎉

---

## 🎭 Happiness Mode Commands

| Command | Action |
|---------|--------|
| `Make me happy` | Switch to cheerful Zephyr model |
| `Cheer me up` | Alternative happiness trigger |
| `Back to normal` | Return to Llama 3.3 |
| `Normal mode` | Return to regular mode |

---

## 🛠️ Management Commands

### View Logs:
```bash
ssh moltbot-vm "tail -f /tmp/moltbot-gateway.log"
```

### Check Status:
```bash
ssh moltbot-vm "ps aux | grep moltbot-gateway"
```

### Edit Config:
```bash
ssh moltbot-vm "nano ~/.clawdbot/config.json"
```

### Restart Gateway:
```bash
ssh moltbot-vm "pkill -f moltbot-gateway && cd ~/moltbot && nohup pnpm moltbot gateway run --bind loopback --port 18789 --force > /tmp/moltbot-gateway.log 2>&1 &"
```

---

## 🔧 Optional: Install Aliases

```bash
# Add to your ~/.zshrc or ~/.bashrc
source /Users/apple/Desktop/Github\ working/moltbot/vm-aliases.sh

# Then use:
vm-code        # Open VS Code to VM
vm-ssh         # SSH to VM
vm-logs        # View logs
vm-config      # View config
vm-restart     # Restart gateway
```

---

## 📚 Documentation Files

- [VM-VSCODE-SETUP.md](VM-VSCODE-SETUP.md) - Full VS Code setup guide
- [VM-DEPLOYMENT-SUMMARY.md](VM-DEPLOYMENT-SUMMARY.md) - Complete deployment details
- [HAPPINESS-MODE-GUIDE.md](HAPPINESS-MODE-GUIDE.md) - Happiness mode usage
- [OPTION-2-MANUAL-HAPPINESS.md](OPTION-2-MANUAL-HAPPINESS.md) - Manual setup guide

---

## ⚡ Your Current Configuration

```json
{
  "agent": "Cia",
  "primary_model": "ollama-cloud/llama3.3",
  "happiness_model": "ollama-cloud/tomasmcm/zephyr-1b-olmo-sft-qlora",
  "backup_model": "ollama-cloud/deepseek-r1:32b",
  "telegram_bot": "@AssistantGc_bot"
}
```

---

## 🎉 You're All Set!

**Everything is ready to use:**
- ✅ Cia running on VM 24/7
- ✅ Accessible via Telegram (always)
- ✅ Accessible via web (when tunnel active)
- ✅ Happiness mode enabled
- ✅ VS Code one-click connection

**Just run:** `./connect-vm.sh` to start editing code on the VM!

**Or message:** `@AssistantGc_bot` on Telegram to use Cia!
