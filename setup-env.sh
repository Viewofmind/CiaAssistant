#!/bin/bash
# Moltbot Environment Setup Script
# This script helps you set up API keys as environment variables

set -e

echo "🦞 Moltbot Environment Setup"
echo "================================"
echo ""

# Detect shell profile
SHELL_PROFILE=""
if [ -f "$HOME/.zshrc" ]; then
    SHELL_PROFILE="$HOME/.zshrc"
elif [ -f "$HOME/.bashrc" ]; then
    SHELL_PROFILE="$HOME/.bashrc"
elif [ -f "$HOME/.profile" ]; then
    SHELL_PROFILE="$HOME/.profile"
else
    echo "⚠️  Could not detect shell profile (.zshrc, .bashrc, or .profile)"
    echo "You'll need to manually add the environment variables to your shell config"
    SHELL_PROFILE=""
fi

echo "Shell profile: ${SHELL_PROFILE:-Manual setup required}"
echo ""

# Custom AI Provider Setup
echo "Step 1: Custom AI Provider"
echo "----------------------------"
read -p "Enter your custom provider API key: " CUSTOM_KEY
read -p "Enter your custom provider base URL (e.g., https://api.provider.com/v1): " CUSTOM_URL

# Ollama Setup
echo ""
echo "Step 2: Ollama (Backup)"
echo "----------------------------"
echo "Setting up Ollama as backup provider..."
OLLAMA_KEY="61f0d384fd444ed6a49dd6054979be29.-r4AZG_weAokLkhzk-GkK8Ms"

# Write to profile if available
if [ -n "$SHELL_PROFILE" ]; then
    echo ""
    echo "Adding environment variables to $SHELL_PROFILE..."

    # Backup existing profile
    cp "$SHELL_PROFILE" "$SHELL_PROFILE.backup.$(date +%Y%m%d-%H%M%S)"

    # Remove old Moltbot env vars if they exist
    grep -v "# Moltbot API Keys" "$SHELL_PROFILE" > "$SHELL_PROFILE.tmp" || true
    grep -v "CUSTOM_AI_API_KEY" "$SHELL_PROFILE.tmp" > "$SHELL_PROFILE.tmp2" || true
    grep -v "CUSTOM_AI_BASE_URL" "$SHELL_PROFILE.tmp2" > "$SHELL_PROFILE.tmp3" || true
    grep -v "OLLAMA_API_KEY" "$SHELL_PROFILE.tmp3" > "$SHELL_PROFILE" || true
    rm -f "$SHELL_PROFILE.tmp" "$SHELL_PROFILE.tmp2" "$SHELL_PROFILE.tmp3"

    # Add new vars
    cat >> "$SHELL_PROFILE" << EOF

# Moltbot API Keys
export CUSTOM_AI_API_KEY="$CUSTOM_KEY"
export CUSTOM_AI_BASE_URL="$CUSTOM_URL"
export OLLAMA_API_KEY="$OLLAMA_KEY"
EOF

    echo "✅ Environment variables added to $SHELL_PROFILE"
else
    # Manual setup
    echo ""
    echo "Add these lines to your shell configuration file:"
    echo ""
    echo "export CUSTOM_AI_API_KEY=\"$CUSTOM_KEY\""
    echo "export CUSTOM_AI_BASE_URL=\"$CUSTOM_URL\""
    echo "export OLLAMA_API_KEY=\"$OLLAMA_KEY\""
fi

# Export for current session
export CUSTOM_AI_API_KEY="$CUSTOM_KEY"
export CUSTOM_AI_BASE_URL="$CUSTOM_URL"
export OLLAMA_API_KEY="$OLLAMA_KEY"

echo ""
echo "✅ Environment variables set for current session"
echo ""
echo "Next steps:"
echo "1. Reload your shell: source $SHELL_PROFILE"
echo "2. Install Ollama: https://ollama.ai"
echo "3. Pull Ollama models: ollama pull llama3.3"
echo "4. Configure Moltbot: Use moltbot-config-secure.example.json"
echo "5. Test: moltbot models list"
echo ""
echo "To change your API key later, either:"
echo "  - Re-run this script, or"
echo "  - Edit $SHELL_PROFILE manually"
echo ""
