# ✅ VM 24/7 Configuration Complete

## 🎉 What's Configured:

### 1. **Auto-Shutdown: DISABLED**
- VM will stay running 24/7
- No automatic stops
- Only stops if manually stopped

### 2. **Auto-Start on Boot**
- Gateway automatically starts when VM boots
- Cron job: `@reboot ~/start-moltbot.sh`
- Logs to: `/tmp/moltbot-startup.log`

### 3. **Current Status**
- ✅ VM: Running
- ✅ Gateway: Running (PID 1505)
- ✅ Telegram: @AssistantGc_bot active
- ✅ SSH Tunnel: localhost:18789 active

---

## 📊 Cost Implications:

**Azure VM running 24/7:**
- Standard B2s: ~$30-60/month
- Check your Azure cost dashboard
- Can reduce costs with reserved instances

---

## 🔧 Management Commands:

### Check VM Status:
```bash
az vm get-instance-view --name socialcoffee --resource-group SOCIALCOFFEE_GROUP --query "instanceView.statuses[?starts_with(code, 'PowerState/')].displayStatus" -o tsv
```

### Check Gateway Status:
```bash
ssh moltbot-vm 'ps aux | grep moltbot-gateway | grep -v grep'
```

### View Gateway Logs:
```bash
ssh moltbot-vm 'tail -f /tmp/moltbot-gateway.log'
```

### View Startup Logs:
```bash
ssh moltbot-vm 'cat /tmp/moltbot-startup.log'
```

### Manual Restart Gateway:
```bash
ssh moltbot-vm 'pkill -f moltbot-gateway && cd ~/moltbot && nohup pnpm moltbot gateway run --bind loopback --port 18789 --force > /tmp/moltbot-gateway.log 2>&1 &'
```

---

## 🚨 If VM Gets Stopped (Manual or Accidental):

### Quick Recovery (One Command):
```bash
az vm start --name socialcoffee --resource-group SOCIALCOFFEE_GROUP && sleep 60 && ssh -f -N -L 18789:localhost:18789 moltbot-vm
```

### What Happens:
1. VM starts (takes ~1 minute)
2. Auto-start script runs (waits 30 seconds)
3. Gateway starts automatically
4. SSH tunnel reconnects (manual)

**Note**: The SSH tunnel needs to be recreated manually after VM restart.

---

## 🔄 Auto-Start Script Details:

**Location**: `/home/azureuser/start-moltbot.sh`

**What it does**:
1. Waits 30 seconds for system to stabilize
2. Checks if gateway is already running
3. Starts gateway if not running
4. Logs start time

**Cron Job**:
```
@reboot /home/azureuser/start-moltbot.sh >> /tmp/moltbot-startup.log 2>&1
```

---

## 📱 Access Methods:

### Telegram (Always Works):
- No tunnel needed
- Message: `@AssistantGc_bot`
- Works even when MacBook is off

### Web Chat (Needs Tunnel):
- URL: `http://localhost:18789/chat`
- Requires SSH tunnel active
- Command: `ssh -f -N -L 18789:localhost:18789 moltbot-vm`

### VS Code:
- Run: `./connect-vm.sh`
- Or double-click: `Moltbot-VM.code-workspace`

---

## 🎯 Monitoring:

### Check if Everything is Running:
```bash
# All-in-one status check
ssh moltbot-vm 'echo "=== Gateway ===" && ps aux | grep moltbot-gateway | grep -v grep && echo "" && echo "=== Last 5 Log Lines ===" && tail -5 /tmp/moltbot-gateway.log'
```

### Create Alert (Optional):
Set up Azure Monitor alerts for:
- VM stopped
- High CPU/Memory
- Network issues

---

## 💡 Tips:

1. **Bookmark**: `http://localhost:18789/chat`
2. **Save**: The recovery command above
3. **Monitor**: Check Azure cost dashboard weekly
4. **Test**: Reboot VM once to verify auto-start works

---

## 🔐 Security:

- Gateway only binds to localhost (not exposed to internet)
- Telegram uses secure WebSocket connection
- SSH tunnel encrypts all traffic
- No public ports open (except SSH)

---

## ✅ Summary:

**Your setup NOW:**
- VM runs 24/7 (unless you manually stop it)
- Gateway auto-starts on boot
- Cia available 24/7 via Telegram
- Web chat available when tunnel is active

**What you don't need to worry about:**
- ✅ VM auto-stopping
- ✅ Gateway starting after reboot
- ✅ Telegram bot availability

**What you still need to manage:**
- SSH tunnel for localhost (manual after VM restart)
- Monthly Azure costs
- Occasional updates/maintenance

---

**Everything is configured for 24/7 operation!** 🎉

Your Telegram bot `@AssistantGc_bot` will now work continuously!
