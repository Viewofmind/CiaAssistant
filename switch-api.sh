#!/bin/bash
# Switch between OpenAI and Ollama Cloud API
# Usage: ./switch-api.sh [openai|ollama]

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 [openai|ollama]"
    echo ""
    echo "Current model:"
    ssh -i ~/.ssh/id_ed25519 azureuser@74.235.97.193 'cat ~/.clawdbot/config.json | jq -r ".agents.defaults.model.primary"'
    exit 1
fi

CHOICE="$1"

case "$CHOICE" in
    openai)
        echo "🔄 Switching to OpenAI GPT-4o..."
        ssh -i ~/.ssh/id_ed25519 azureuser@74.235.97.193 'cat ~/.clawdbot/config.json | jq ".agents.defaults.model.primary = \"openai/gpt-4o\"" > /tmp/config-temp.json && mv /tmp/config-temp.json ~/.clawdbot/config.json'
        echo "✅ Switched to OpenAI!"
        echo ""
        echo "Primary model: openai/gpt-4o"
        echo "API: https://api.openai.com/v1"
        echo "Cost: Paid (uses your OpenAI credits)"
        ;;
    ollama)
        echo "🔄 Switching to Ollama Cloud Llama 3.3..."
        ssh -i ~/.ssh/id_ed25519 azureuser@74.235.97.193 'cat ~/.clawdbot/config.json | jq ".agents.defaults.model.primary = \"ollama-cloud/llama3.3\"" > /tmp/config-temp.json && mv /tmp/config-temp.json ~/.clawdbot/config.json'
        echo "✅ Switched to Ollama Cloud!"
        echo ""
        echo "Primary model: ollama-cloud/llama3.3"
        echo "API: https://api.ollama.com/v1"
        echo "Cost: Free"
        ;;
    *)
        echo "❌ Invalid choice. Use 'openai' or 'ollama'"
        exit 1
        ;;
esac

echo ""
echo "🔄 Restarting gateway to apply changes..."
ssh -i ~/.ssh/id_ed25519 azureuser@74.235.97.193 'pkill -f moltbot-gateway && sleep 2 && cd ~/moltbot && nohup pnpm moltbot gateway run --bind loopback --port 18789 --force > /tmp/moltbot-gateway.log 2>&1 &'

echo "⏳ Waiting for gateway to start..."
sleep 5

echo "✅ Gateway restarted!"
echo ""
echo "Current configuration:"
ssh -i ~/.ssh/id_ed25519 azureuser@74.235.97.193 'cat ~/.clawdbot/config.json | jq -r ".agents.defaults.model"'

echo ""
echo "🎉 Ready! Test it by messaging @AssistantGc_bot on Telegram"
