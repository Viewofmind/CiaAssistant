#!/bin/bash
# Moltbot VM Shell Aliases
# Add this to your ~/.zshrc or ~/.bashrc

# Quick VM access
alias vm-code='code --folder-uri "vscode-remote://ssh-remote+moltbot-vm/home/azureuser/moltbot"'
alias vm-ssh='ssh moltbot-vm'
alias vm='ssh moltbot-vm'

# VM Moltbot management
alias vm-logs='ssh moltbot-vm "tail -f /tmp/moltbot-gateway.log"'
alias vm-config='ssh moltbot-vm "cat ~/.clawdbot/config.json | jq"'
alias vm-status='ssh moltbot-vm "ps aux | grep moltbot-gateway | grep -v grep"'
alias vm-restart='ssh moltbot-vm "pkill -f moltbot-gateway && cd ~/moltbot && nohup pnpm moltbot gateway run --bind loopback --port 18789 --force > /tmp/moltbot-gateway.log 2>&1 &"'

# Telegram bot
alias vm-telegram='ssh moltbot-vm "tail -f /tmp/moltbot-gateway.log | grep telegram"'

# Quick edits
alias vm-edit-config='ssh moltbot-vm "nano ~/.clawdbot/config.json"'

echo "✅ Aliases loaded!"
echo ""
echo "Available commands:"
echo "  vm-code        - Open VS Code connected to VM"
echo "  vm-ssh / vm    - SSH to VM"
echo "  vm-logs        - View gateway logs"
echo "  vm-config      - View current config"
echo "  vm-status      - Check if gateway is running"
echo "  vm-restart     - Restart the gateway"
echo "  vm-telegram    - View telegram logs"
echo "  vm-edit-config - Edit config file"
