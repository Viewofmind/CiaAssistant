#!/bin/bash
# Happiness Mode Trigger Script for Cia
# This script helps set up automatic model switching when you say "Make me happy"

set -e

echo "🎉 Setting up Happiness Mode for Cia"
echo "======================================"
echo ""

# Check if Ollama is installed
if ! command -v ollama &> /dev/null; then
    echo "⚠️  Ollama is not installed!"
    echo "Please install from: https://ollama.ai"
    exit 1
fi

# Pull the happiness model
echo "📦 Pulling the Zephyr happiness model..."
echo "This may take a while on first run..."
echo ""

if ollama list | grep -q "tomasmcm/zephyr-1b-olmo-sft-qlora"; then
    echo "✅ Zephyr model already installed"
else
    echo "⬇️  Pulling tomasmcm/zephyr-1b-olmo-sft-qlora..."
    ollama pull tomasmcm/zephyr-1b-olmo-sft-qlora
fi

# Pull other required models
echo ""
echo "📦 Checking other required models..."

models=("llama3.3" "deepseek-r1:32b")
for model in "${models[@]}"; do
    if ollama list | grep -q "$model"; then
        echo "✅ $model already installed"
    else
        echo "⬇️  Pulling $model..."
        ollama pull "$model"
    fi
done

echo ""
echo "✅ All models ready!"
echo ""

# Copy the happiness config
echo "📝 Setting up configuration..."
mkdir -p ~/.moltbot

if [ -f ~/.moltbot/config.json ]; then
    # Backup existing config
    cp ~/.moltbot/config.json ~/.moltbot/config.backup.$(date +%Y%m%d-%H%M%S).json
    echo "✅ Backed up existing config"
fi

# Ask for custom provider details
echo ""
echo "Custom AI Provider Setup"
echo "-------------------------"
read -p "Enter your custom provider base URL (e.g., https://api.provider.com/v1): " BASE_URL
read -p "Enter your model ID (e.g., gpt-4, claude-3, etc.): " MODEL_ID

# Copy the happiness config
cp moltbot-config-with-happiness.json ~/.moltbot/config.json

# Update the config with user's base URL and model ID
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    sed -i '' "s|https://your-provider-url.com/v1|${BASE_URL}|g" ~/.moltbot/config.json
    sed -i '' "s|your-model-name|${MODEL_ID}|g" ~/.moltbot/config.json
else
    # Linux
    sed -i "s|https://your-provider-url.com/v1|${BASE_URL}|g" ~/.moltbot/config.json
    sed -i "s|your-model-name|${MODEL_ID}|g" ~/.moltbot/config.json
fi

echo "✅ Configuration updated!"
echo ""

# Create the happiness trigger helper script
mkdir -p ~/.moltbot/scripts

cat > ~/.moltbot/scripts/happiness-mode << 'EOF'
#!/bin/bash
# Quick switch to happiness mode

if [ "$1" = "on" ]; then
    echo "🎉 Switching to Happiness Mode (Zephyr)..."
    moltbot agent --message "Switching to happiness mode. Let's make this conversation cheerful!" --model ollama/tomasmcm/zephyr-1b-olmo-sft-qlora
elif [ "$1" = "off" ]; then
    echo "👔 Switching back to normal mode..."
    moltbot agent --message "Switching back to normal mode." --model custom/$MODEL_ID
else
    echo "Usage: happiness-mode [on|off]"
    echo "  on  - Switch to happy Zephyr model"
    echo "  off - Switch back to primary model"
fi
EOF

chmod +x ~/.moltbot/scripts/happiness-mode

echo "✅ Created happiness mode helper script"
echo ""

# Test if moltbot is installed
if command -v moltbot &> /dev/null; then
    echo "🧪 Testing configuration..."
    echo ""

    # Test models list
    echo "Available models:"
    moltbot models list | grep -E "(custom|ollama|zephyr)" || moltbot models list

    echo ""
    echo "✅ Setup complete!"
    echo ""
    echo "🎉 How to use Happiness Mode:"
    echo ""
    echo "Option 1: Say to Cia:"
    echo '  "Make me happy"'
    echo '  → Cia will switch to the cheerful Zephyr model'
    echo ""
    echo "Option 2: Use the helper script:"
    echo '  ~/.moltbot/scripts/happiness-mode on   # Enable happiness mode'
    echo '  ~/.moltbot/scripts/happiness-mode off  # Back to normal'
    echo ""
    echo "Option 3: Direct model switch:"
    echo '  moltbot agent --message "Hello!" --model ollama/tomasmcm/zephyr-1b-olmo-sft-qlora'
    echo ""
else
    echo "⚠️  Moltbot CLI not found!"
    echo ""
    echo "Install it with:"
    echo "  npm install -g moltbot@latest"
fi

echo ""
echo "📚 See HAPPINESS-MODE-GUIDE.md for detailed usage"
echo ""
