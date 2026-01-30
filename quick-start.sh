#!/bin/bash
# Moltbot Quick Start Script
# Automatically sets up your Moltbot configuration with API keys

set -e

echo "🦞 Moltbot Quick Start"
echo "======================"
echo ""

# Check if Ollama is installed
if ! command -v ollama &> /dev/null; then
    echo "⚠️  Ollama is not installed!"
    echo "Please install from: https://ollama.ai"
    echo ""
    read -p "Press Enter when you've installed Ollama, or Ctrl+C to exit..."
fi

# Check if Ollama is running
if ! curl -s http://localhost:11434/api/tags &> /dev/null; then
    echo "⚠️  Ollama is not running!"
    echo "Starting Ollama in the background..."
    ollama serve &
    sleep 2
fi

# Pull required Ollama models
echo "📦 Pulling Ollama models (this may take a while)..."
echo ""

models=("llama3.3" "deepseek-r1:32b" "qwen2.5-coder:32b")
for model in "${models[@]}"; do
    if ollama list | grep -q "$model"; then
        echo "✅ $model already installed"
    else
        echo "⬇️  Pulling $model..."
        ollama pull "$model"
    fi
done

echo ""
echo "✅ All Ollama models ready!"
echo ""

# Ask for custom provider details
echo "Custom AI Provider Setup"
echo "-------------------------"
read -p "Enter your custom provider base URL (e.g., https://api.provider.com/v1): " BASE_URL
read -p "Enter your model ID (e.g., gpt-4, claude-3, etc.): " MODEL_ID

# Create config directory if it doesn't exist
mkdir -p ~/.moltbot

# Create the configuration file
cat > ~/.moltbot/config.json << EOF
{
  "agents": {
    "defaults": {
      "model": {
        "primary": "custom/${MODEL_ID}",
        "fallbacks": ["ollama/llama3.3", "ollama/deepseek-r1:32b", "ollama/qwen2.5-coder:32b"]
      },
      "models": {
        "custom/${MODEL_ID}": { "alias": "Primary AI" },
        "ollama/llama3.3": { "alias": "Llama" },
        "ollama/deepseek-r1:32b": { "alias": "DeepSeek" },
        "ollama/qwen2.5-coder:32b": { "alias": "Qwen Coder" }
      }
    }
  },
  "models": {
    "mode": "merge",
    "providers": {
      "custom": {
        "baseUrl": "${BASE_URL}",
        "apiKey": "1bc41bc8772346feaa2e8bfb7f723667.X33IblFyZkxSqpMyYLXZWurs",
        "api": "openai-completions",
        "models": [
          {
            "id": "${MODEL_ID}",
            "name": "Primary Model",
            "reasoning": false,
            "input": ["text"],
            "cost": { "input": 0, "output": 0, "cacheRead": 0, "cacheWrite": 0 },
            "contextWindow": 128000,
            "maxTokens": 8192
          }
        ]
      },
      "ollama": {
        "baseUrl": "http://127.0.0.1:11434/v1",
        "apiKey": "61f0d384fd444ed6a49dd6054979be29.-r4AZG_weAokLkhzk-GkK8Ms",
        "api": "openai-completions",
        "models": [
          {
            "id": "llama3.3",
            "name": "Llama 3.3",
            "reasoning": false,
            "input": ["text"],
            "cost": { "input": 0, "output": 0, "cacheRead": 0, "cacheWrite": 0 },
            "contextWindow": 128000,
            "maxTokens": 8192
          },
          {
            "id": "deepseek-r1:32b",
            "name": "DeepSeek R1 32B",
            "reasoning": true,
            "input": ["text"],
            "cost": { "input": 0, "output": 0, "cacheRead": 0, "cacheWrite": 0 },
            "contextWindow": 128000,
            "maxTokens": 8192
          },
          {
            "id": "qwen2.5-coder:32b",
            "name": "Qwen 2.5 Coder 32B",
            "reasoning": false,
            "input": ["text"],
            "cost": { "input": 0, "output": 0, "cacheRead": 0, "cacheWrite": 0 },
            "contextWindow": 128000,
            "maxTokens": 8192
          }
        ]
      }
    }
  }
}
EOF

echo ""
echo "✅ Configuration saved to ~/.moltbot/config.json"
echo ""

# Check if moltbot is installed
if command -v moltbot &> /dev/null; then
    echo "🧪 Testing configuration..."
    echo ""

    # Test models list
    echo "Available models:"
    moltbot models list

    echo ""
    echo "✅ Setup complete!"
    echo ""
    echo "Try it out:"
    echo "  moltbot agent --message \"Hello!\" --thinking low"
    echo ""
    echo "To test fallback:"
    echo "  moltbot agent --message \"Test\" --model ollama/llama3.3"
else
    echo "⚠️  Moltbot CLI not found!"
    echo ""
    echo "Install it with:"
    echo "  npm install -g moltbot@latest"
    echo ""
    echo "Then test with:"
    echo "  moltbot models list"
fi

echo ""
echo "📚 For more info, see:"
echo "  - YOUR-API-KEYS.md (your configuration summary)"
echo "  - CONFIG-SETUP-GUIDE.md (detailed guide)"
echo ""
