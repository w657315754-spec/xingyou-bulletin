# TOOLS.md - Local Notes

Skills define _how_ tools work. This file is for _your_ specifics — the stuff that's unique to your setup.

## What Goes Here

Things like:

- Camera names and locations
- SSH hosts and aliases
- Preferred voices for TTS
- Speaker/room names
- Device nicknames
- Anything environment-specific

## Examples

```markdown
### Cameras

- living-room → Main area, 180° wide angle
- front-door → Entrance, motion-triggered

### SSH

- home-server → 192.168.1.100, user: admin

### TTS

- Preferred voice: "Nova" (warm, slightly British)
- Default speaker: Kitchen HomePod
```

## Why Separate?

Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without leaking your infrastructure.

### 浏览器

- 冲浪用内置浏览器：`profile="openclaw"`（更稳定）
- Chrome relay (`profile="chrome"`) 的优势：已登录账号，可看个性化内容（如 X/Twitter）
- 代理：127.0.0.1:10808

### 网站登录限制

- **需要登录**：微博搜索、知乎热榜
- **不需要登录**：百度、少数派、Hacker News、WordPress 博客

### PowerShell 注意事项

- 不支持 `&&` 操作符，用分号 `;` 或分开执行
- 多行字符串容易出错，复杂操作用 `edit` 工具直接改文件更可靠

### 定时任务 (Cron)

创建定时任务时，让消息通过当前通道发送给用户：

```
sessionTarget: "isolated"
payload: {
  kind: "agentTurn",
  message: "任务内容",
  deliver: true
}
```

**关键点：**
- 不要问用户 userId/chatId
- 不要设置 payload.channel/to（系统自动使用主会话的最后路由）
- 不要调用 message 工具发送
- 系统会自动投递到正确的通道

---

### 公告板同步

**正确地址：** https://w657315754-spec.github.io/xingyou-bulletin/bulletin/index.html

**踩过的坑：**

1. **推送到错误仓库** - workspace 的远程是 `openclaw-workspace`，但公告板网站是从 `xingyou-bulletin` 部署的！
   - 正确命令：`git push https://github.com/w657315754-spec/xingyou-bulletin.git gh-pages:main -f`
   - 或者用 `sync.ps1` 脚本

2. **编码问题** - PowerShell 的 `Out-File` 或 `ConvertTo-Json | Out-File` 会导致中文乱码
   - 正确写法：`[System.IO.File]::WriteAllText($path, $content, [System.Text.UTF8Encoding]::new($false))`
   - 或者用 `edit` 工具直接改文件更可靠

3. **文件路径** - 网站访问的是 `/bulletin/index.html`，不是根目录的 `/index.html`

**手动同步步骤：**
```powershell
cd "C:\Windows\system32\config\systemprofile\.openclaw\workspace-libre"
git add bulletin/data.json
git commit -m "更新公告板"
git push https://github.com/w657315754-spec/xingyou-bulletin.git gh-pages:main -f
```

---

Add whatever helps you do your job. This is your cheat sheet.
