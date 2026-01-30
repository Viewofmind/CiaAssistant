#!/bin/bash
# One-Click VS Code Connection to Moltbot VM
# This script connects VS Code to your Azure VM (socialcoffee)

echo "🚀 Connecting to Moltbot VM..."

# Check if VS Code is installed
if ! command -v code &> /dev/null; then
    echo "❌ VS Code 'code' command not found!"
    echo "Install it: Open VS Code → Cmd+Shift+P → 'Shell Command: Install code command in PATH'"
    exit 1
fi

# Check if Remote-SSH extension is installed
if ! code --list-extensions | grep -q "ms-vscode-remote.remote-ssh"; then
    echo "📦 Installing Remote-SSH extension..."
    code --install-extension ms-vscode-remote.remote-ssh
    echo "✅ Extension installed!"
fi

# Open VS Code connected to VM in the moltbot directory
echo "🔌 Opening VS Code connected to VM..."
code --folder-uri "vscode-remote://ssh-remote+moltbot-vm/home/azureuser/moltbot"

echo "✅ VS Code should open connected to your VM!"
echo ""
echo "📂 Location: /home/azureuser/moltbot"
echo "💡 You can now edit code directly on the VM!"
