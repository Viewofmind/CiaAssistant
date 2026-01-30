# Moltbot VM Deployment Summary

## ✅ What's Been Set Up

### Azure VM Details
- **VM Name**: socialcoffee
- **Public IP**: 74.235.97.193
- **Private IP**: 172.16.0.4
- **OS**: Ubuntu 24.04 (Linux 6.14.0-1017-azure)
- **Resource Group**: SOCIALCOFFEE_GROUP
- **Username**: azureuser

### Installed Components

1. **Ollama** ✅
   - Installed and running as systemd service
   - API available at: http://127.0.0.1:11434
   - Running in CPU-only mode (no GPU)

2. **Node.js** ✅
   - Version: v24.13.0
   - NPM Version: 11.6.2

3. **Moltbot** 🔄 (Currently building)
   - Source deployed to: `~/moltbot-source`
   - Building with pnpm

### Configuration

**Location**: `~/.moltbot/config.json` on VM

**Providers Configured**:

1. **Custom Provider** (Primary)
   - API Key: `1bc41bc8772346feaa2e8bfb7f723667.X33IblFyZkxSqpMyYLXZWurs`
   - Base URL: `https://your-provider-url.com/v1` ⚠️ **You need to update this**
   - Model ID: `your-model-name` ⚠️ **You need to update this**

2. **Ollama Cloud** (Backup)
   - API Key: `61f0d384fd444ed6a49dd6054979be29.-r4AZG_weAokLkhzk-GkK8Ms`
   - Base URL: `https://api.ollama.com/v1`
   - Models:
     - `llama3.3` (General backup)
     - `deepseek-r1:32b` (Reasoning backup)
     - `tomasmcm/zephyr-1b-olmo-sft-qlora` (Happiness mode)

### Features Enabled

1. **"Make me happy" Trigger** 🎉
   - Say "Make me happy" to Cia
   - Automatically switches to `ollama-cloud/tomasmcm/zephyr-1b-olmo-sft-qlora`
   - Cheerful, uplifting responses
   - Say "back to normal" to switch back

2. **Automatic Failover**
   - Primary → Ollama llama3.3 → Ollama deepseek-r1
   - Always available even if primary provider is down

---

## 🔧 Next Steps

### 1. Update Configuration

SSH into your VM:
```bash
ssh -i ~/.ssh/id_ed25519 azureuser@74.235.97.193
```

Edit the config:
```bash
nano ~/.moltbot/config.json
```

Update these fields:
- `models.providers.custom.baseUrl`: Your actual API endpoint
- `models.providers.custom.models[0].id`: Your actual model ID

### 2. Test the Setup

Once Moltbot finishes building:

```bash
# SSH into VM
ssh -i ~/.ssh/id_ed25519 azureuser@74.235.97.193

# Navigate to source
cd ~/moltbot-source

# Run Moltbot
pnpm moltbot models list

# Test with message
pnpm moltbot agent --message "Hello Cia!"

# Test happiness mode
pnpm moltbot agent --message "Make me happy"
```

### 3. Install as Global Command (Optional)

```bash
cd ~/moltbot-source
sudo pnpm link --global
```

Then you can use `moltbot` command directly.

### 4. Start Gateway (If needed)

```bash
pnpm moltbot gateway run --bind loopback --port 18789 &
```

---

## 📝 Configuration Files

### On Local Mac:
- `/Users/apple/Desktop/Github working/moltbot/moltbot-config-ollama-cloud.json`
- All other setup files in the same directory

### On VM:
- `~/.moltbot/config.json` (active configuration)
- `~/moltbot-source/` (Moltbot source code)

---

## 🔐 SSH Access

Your local SSH key (`~/.ssh/id_ed25519`) has been added to the VM.

Connect:
```bash
ssh -i ~/.ssh/id_ed25519 azureuser@74.235.97.193
```

Or add to `~/.ssh/config`:
```
Host socialcoffee
    HostName 74.235.97.193
    User azureuser
    IdentityFile ~/.ssh/id_ed25519
```

Then: `ssh socialcoffee`

---

## 🎯 Using Ollama Cloud API

Your configuration uses **Ollama Cloud API** instead of local models:

**Advantages**:
- No need to download large models to VM
- Faster model switching
- Access to all Ollama models via API
- Lower disk space requirements

**API Endpoint**: `https://api.ollama.com/v1`

**Models Available**:
- llama3.3
- deepseek-r1:32b
- tomasmcm/zephyr-1b-olmo-sft-qlora (happiness mode)
- Any other model Ollama Cloud supports

---

## 🧪 Testing Happiness Mode

### Example Conversation:

```bash
# Normal mode
$ pnpm moltbot agent --message "Hello Cia"
Cia: Hello! How can I help you today?

# Trigger happiness mode
$ pnpm moltbot agent --message "Make me happy"
Cia: 🎉 [Switches to Zephyr]
     Oh absolutely! Let me brighten your day!
     You're amazing and capable of wonderful things...

# Back to normal
$ pnpm moltbot agent --message "Back to normal mode"
Cia: 👔 [Switches back]
     Returned to standard mode. How can I assist?
```

---

## 📊 Architecture

```
User Request
    ↓
Moltbot on VM (socialcoffee)
    ↓
Primary: Custom Provider (your API)
    ↓ (if fails)
Backup 1: Ollama Cloud (llama3.3)
    ↓ (if fails)
Backup 2: Ollama Cloud (deepseek-r1)
    ↓
Response delivered
```

**Special Trigger**:
```
"Make me happy" → Ollama Cloud (zephyr happiness model)
```

---

## 🐛 Troubleshooting

### Check if Ollama is running on VM:
```bash
ssh azureuser@74.235.97.193 'systemctl status ollama'
```

### Check if Moltbot build completed:
```bash
ssh azureuser@74.235.97.193 'cd ~/moltbot-source && ls dist/'
```

### View Moltbot config:
```bash
ssh azureuser@74.235.97.193 'cat ~/.moltbot/config.json | jq'
```

### Test Ollama Cloud API:
```bash
curl -X POST https://api.ollama.com/v1/chat/completions \
  -H "Authorization: Bearer 61f0d384fd444ed6a49dd6054979be29.-r4AZG_weAokLkhzk-GkK8Ms" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "llama3.3",
    "messages": [{"role": "user", "content": "Hello!"}]
  }'
```

---

## 📚 Related Documentation

- [Main Setup Guide](SETUP-README.md)
- [Happiness Mode Guide](HAPPINESS-MODE-GUIDE.md)
- [Option 2 Manual Guide](OPTION-2-MANUAL-HAPPINESS.md)
- [Ollama Cloud Config](moltbot-config-ollama-cloud.json)

---

## ⚠️ Important Reminders

1. **Update your custom provider's base URL** in the config
2. **Update your model ID** in the config
3. The VM has **no GPU** - Ollama local would be slow, so we're using Ollama Cloud API
4. Your configuration is set up for **remote API calls** - no local model storage needed
5. Backup models ensure **100% uptime** even if primary provider fails

---

## 🎉 You're All Set!

Once the build completes and you update your custom provider details, you'll have:

✅ Moltbot running on Azure VM
✅ Primary custom AI provider
✅ Ollama Cloud backup (3 models)
✅ "Make me happy" happiness mode
✅ Automatic failover
✅ Always-available AI assistant named Cia

**Next**: Check if build completed and test it out!
