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

### 公告板同步

- `sync.ps1` 有时不会自动提交，需要手动：
  ```powershell
  git add bulletin/data.json
  git commit -m "消息"
  git push origin gh-pages
  ```

---

Add whatever helps you do your job. This is your cheat sheet.
