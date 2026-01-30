# Moltbot Skills - Installation Summary

## ✅ Successfully Installed & Ready (8 skills):

| Skill | Description | Status |
|-------|-------------|--------|
| 🔄 **api-switcher** | Switch between OpenAI/Ollama via commands | ✅ **⭐ NEW!** |
| 🐙 **github** | GitHub CLI (gh) integration | ✅ **NEWLY READY** |
| 🎞️ **video-frames** | Extract frames from videos (ffmpeg) | ✅ **NEWLY READY** |
| 📦 **bluebubbles** | BlueBubbles iMessage plugin | ✅ Ready |
| 🧩 **coding-agent** | Run coding agents | ✅ Ready |
| 📦 **skill-creator** | Create new skills | ✅ Ready |
| 🧵 **tmux** | Terminal multiplexer control | ✅ Ready |
| 🌤️ **weather** | Weather forecasts | ✅ Ready |

### What You Can Do Now:

1. **API Switcher** ⭐ NEW! - Ask Cia:
   - "make me happy" (switch to free Ollama Cloud)
   - "be normal" (switch to premium OpenAI)
   - Save money by using free API most of the time!

2. **GitHub** - Ask Cia:
   - "Create a GitHub issue in my repo"
   - "List my open PRs"
   - "Show me recent commits"

3. **Video Frames** - Ask Cia:
   - "Extract frames from this video"
   - "Get a thumbnail from this clip"

4. **Weather** - Ask Cia:
   - "What's the weather like?"
   - "Show me the forecast"

5. **Tmux** - Ask Cia:
   - "Create a tmux session"
   - "Send commands to tmux"

---

## ⚠️ Partially Installed (Need Additional Setup):

### 📜 **session-logs** - Analyze Chat History
**Status**: Dependencies installed (jq), but skill not auto-detected
**What's needed**: May need manual enabling or configuration
**Use case**: Search your past conversations with Cia

### 🧾 **summarize** - Summarize URLs/Content
**Status**: Dependencies installed (yt-dlp, ffmpeg), but skill not auto-detected
**What's needed**: May need additional CLI or manual enabling
**Use case**: Summarize YouTube videos, podcasts, articles

---

## ❌ Not Installed (Require Additional CLIs/APIs):

### 📝 **notion** - Notion Integration
**Requires**:
- Notion API key
- Notion integration setup
**Setup**: https://developers.notion.com/
**Use case**: Create/manage Notion pages and databases

### 📧 **himalaya** - Email Management
**Requires**:
- Himalaya CLI installation
- IMAP/SMTP credentials
**Install**: `cargo install himalaya` (requires Rust)
**Use case**: Manage emails from terminal

### 🎮 **gog** - Google Workspace
**Requires**:
- gog CLI installation
- Google Workspace API credentials
**Setup**: Complex OAuth setup needed
**Use case**: Gmail, Calendar, Drive, Docs automation

---

## 📊 Current Status:

- **Total Skills**: 52
- **Ready to Use**: 8 (was 5, +3 today!)
- **Could Enable with Setup**: 3 (session-logs, summarize, notion/himalaya/gog with API keys)
- **Not Practical on Linux**: ~20 (macOS-only apps)
- **Remaining**: ~21 (various specialized tools)

---

## 🎯 Next Steps:

### Option 1: Test Ready Skills
Try the 7 ready skills, especially the new ones:
```
"Hey Cia, what's the weather?"
"Hey Cia, list my GitHub repos"
```

### Option 2: Enable Session-Logs & Summarize
These have dependencies but might need manual enabling. I can investigate further.

### Option 3: Set Up API-Based Skills
If you use Notion or Google Workspace, I can help set those up with your API keys.

---

## 💡 Most Useful Skills Available Now:

1. **API Switcher** ⭐⭐⭐⭐⭐⭐ **NEW!**
   - Switch between free and paid APIs with voice commands
   - Save money using Ollama Cloud when possible
   - Instant switching: "make me happy" / "be normal"

2. **GitHub** ⭐⭐⭐⭐⭐
   - Manage repos, issues, PRs
   - Check CI/CD runs
   - No additional setup needed!

3. **Weather** ⭐⭐⭐⭐
   - Quick weather checks
   - No API key needed!

4. **Video-Frames** ⭐⭐⭐
   - Extract video thumbnails
   - Process video content

5. **Coding-Agent** ⭐⭐⭐⭐
   - Run coding assistants
   - Programmatic control

6. **Tmux** ⭐⭐⭐
   - Terminal session management
   - Run persistent commands

---

## 🚀 How to Use Skills:

Just ask Cia naturally! For example:

### GitHub:
```
"Show me my open GitHub issues"
"Create an issue: Bug in login form"
"List PRs for my repo"
```

### Weather:
```
"What's the weather?"
"Will it rain tomorrow?"
"Show me the 5-day forecast"
```

### Video:
```
"Extract frames from this video: [URL]"
"Get thumbnails from this clip"
```

---

## 📚 Documentation:

For each skill, check:
```bash
cd ~/moltbot/skills/[skill-name]/
cat skill.ts  # See what it does
```

---

## ✅ Summary:

**Achievements Today**:
- ✅ Installed GitHub CLI
- ✅ Installed ffmpeg/yt-dlp
- ✅ Installed jq
- ✅ Created custom API switcher skill
- ✅ **8 skills now ready** (up from 5!)

**What Works Right Now**:
- **⭐ API Switching** (voice commands to switch providers!)
- GitHub integration (repos, issues, PRs)
- Weather forecasts
- Video frame extraction
- Tmux control
- Coding agents
- Skill creation
- BlueBubbles

**What You Can Do**:
Just talk to Cia naturally and use these skills!

---

**Try it now**: Message `@AssistantGc_bot` on Telegram:
```
"make me happy"
"Hey Cia, what's the weather in my location?"
"be normal"
"Show me my GitHub repos"
```

🎉 **Enjoy your new skills!**

---

## 🔥 Featured: API Switcher

The **api-switcher** skill lets you switch between OpenAI and Ollama Cloud with simple commands:

- Say **"make me happy"** → Switch to FREE Ollama Cloud
- Say **"be normal"** → Switch to PAID OpenAI

This can save you **$40-80/month** by using the free API for casual conversations!

📖 **Full Documentation**: See [TELEGRAM-API-SWITCHING.md](TELEGRAM-API-SWITCHING.md)
