# VS Code Remote Connection Setup

## ✅ What's Been Set Up:

1. **SSH Config** - Added to `~/.ssh/config`:
   - Host: `moltbot-vm` and `socialcoffee`
   - Auto port forwarding (18789)
   - Keep-alive enabled

2. **Connection Script** - `connect-vm.sh`
   - One-click VS Code connection
   - Auto-installs Remote-SSH extension if needed

3. **VS Code Workspace** - `Moltbot-VM.code-workspace`
   - Double-click to open both VM and local code
   - Pre-configured settings

---

## 🚀 Three Ways to Connect:

### Method 1: One-Click Script (Easiest!)
```bash
./connect-vm.sh
```
Opens VS Code directly to VM's `/home/azureuser/moltbot` folder.

### Method 2: Double-Click Workspace File
Just double-click: **`Moltbot-VM.code-workspace`**
- Opens both VM and local folders in VS Code
- Perfect for comparing or syncing code

### Method 3: VS Code Command Palette
1. Open VS Code
2. Press `Cmd+Shift+P` (Mac) or `Ctrl+Shift+P` (Windows/Linux)
3. Type: `Remote-SSH: Connect to Host`
4. Select: `moltbot-vm`

### Method 4: Command Line
```bash
code --folder-uri "vscode-remote://ssh-remote+moltbot-vm/home/azureuser/moltbot"
```

---

## 📂 Important Paths on VM:

| Path | Description |
|------|-------------|
| `/home/azureuser/moltbot/` | Main Moltbot git repo (currently running) |
| `/home/azureuser/moltbot-source/` | Deployed copy |
| `/home/azureuser/.clawdbot/config.json` | Active configuration |
| `/tmp/moltbot-gateway.log` | Gateway logs |

---

## 🔧 Quick Commands in VS Code Terminal:

Once connected to VM via VS Code:

### Check gateway status:
```bash
ps aux | grep moltbot-gateway
```

### View live logs:
```bash
tail -f /tmp/moltbot-gateway.log
```

### Restart gateway:
```bash
pkill -f moltbot-gateway
cd ~/moltbot
nohup pnpm moltbot gateway run --bind loopback --port 18789 --force > /tmp/moltbot-gateway.log 2>&1 &
```

### Edit config:
```bash
nano ~/.clawdbot/config.json
```

### Test Moltbot:
```bash
cd ~/moltbot
pnpm moltbot models list
```

---

## 💡 Shell Aliases (Optional)

Add these to your `~/.zshrc` or `~/.bashrc` for even easier access:

```bash
# Quick VM connection
alias vm-code='code --folder-uri "vscode-remote://ssh-remote+moltbot-vm/home/azureuser/moltbot"'
alias vm-ssh='ssh moltbot-vm'
alias vm-logs='ssh moltbot-vm "tail -f /tmp/moltbot-gateway.log"'
alias vm-config='ssh moltbot-vm "cat ~/.clawdbot/config.json | jq"'
```

Then just type:
```bash
vm-code    # Opens VS Code to VM
vm-ssh     # SSH to VM
vm-logs    # View live logs
vm-config  # View current config
```

---

## 🎯 Workflow Example:

1. **Connect to VM**:
   ```bash
   ./connect-vm.sh
   ```

2. **Edit code in VS Code** (connected to VM)

3. **Open terminal in VS Code** (already on VM)

4. **Test changes**:
   ```bash
   cd ~/moltbot
   pnpm moltbot agent --message "Test" --thinking low
   ```

5. **Restart gateway if needed**:
   ```bash
   pkill -f moltbot-gateway && cd ~/moltbot && nohup pnpm moltbot gateway run --bind loopback --port 18789 --force > /tmp/moltbot-gateway.log 2>&1 &
   ```

---

## 🔐 SSH Config Details:

The SSH config entry looks like this:

```
Host moltbot-vm
    HostName 74.235.97.193
    User azureuser
    IdentityFile ~/.ssh/id_ed25519
    ServerAliveInterval 60
    ServerAliveCountMax 3
    LocalForward 18789 localhost:18789
```

**Features**:
- Auto forwards port 18789 (web chat access)
- Keep-alive to prevent disconnection
- Uses your ed25519 SSH key

---

## 🐛 Troubleshooting:

### VS Code can't find 'code' command:
1. Open VS Code
2. Press `Cmd+Shift+P`
3. Type: `Shell Command: Install 'code' command in PATH`
4. Try again

### Remote-SSH extension not installed:
The script will auto-install it, or manually:
1. Open VS Code
2. Go to Extensions (Cmd+Shift+X)
3. Search: "Remote - SSH"
4. Install it

### Connection fails:
```bash
# Test SSH connection first
ssh moltbot-vm
```

If that works, try VS Code again.

### Port forwarding not working:
Check if port 18789 is already in use locally:
```bash
lsof -i :18789
```

---

## 📚 Next Steps:

1. **Test the connection**: Run `./connect-vm.sh`
2. **Bookmark the workspace**: Keep `Moltbot-VM.code-workspace` handy
3. **Add aliases**: Copy the aliases to your shell config
4. **Start coding**: Edit Moltbot directly on the VM!

---

## ✨ Benefits:

- ✅ Edit code directly on VM (no sync needed)
- ✅ Terminal runs on VM (run commands directly)
- ✅ Automatic port forwarding (access localhost:18789)
- ✅ File watching works perfectly
- ✅ Git operations on VM
- ✅ No manual SSH commands needed

**Everything just works!** 🎉
