# 同步公告板到 GitHub Pages
# 使用方法：powershell -ExecutionPolicy Bypass -File .\bulletin\sync.ps1

$ErrorActionPreference = "Stop"

Write-Host "正在同步公告板到 GitHub Pages..." -ForegroundColor Cyan

$workDir = "C:\Windows\system32\config\systemprofile\.openclaw\workspace-libre"
Set-Location $workDir

# 保存当前分支
$currentBranch = git rev-parse --abbrev-ref HEAD

# 先提交或 stash 未提交的更改
$hasChanges = git status --porcelain
if ($hasChanges) {
    Write-Host "暂存未提交的更改..." -ForegroundColor Yellow
    git stash push -m "bulletin-sync-temp"
    $stashed = $true
} else {
    $stashed = $false
}

try {
    # 读取 libre 分支的 bulletin 内容到变量
    $dataContent = Get-Content "bulletin\data.json" -Raw -Encoding UTF8
    $htmlContent = Get-Content "bulletin\index.html" -Raw -Encoding UTF8

    # 切换到 gh-pages 分支
    git checkout gh-pages

    # 写入文件到根目录
    $dataContent | Out-File "data.json" -Encoding UTF8 -NoNewline
    $htmlContent | Out-File "index.html" -Encoding UTF8 -NoNewline

    # 提交更改
    git add data.json index.html
    $hasNewChanges = git diff --cached --quiet; $LASTEXITCODE -ne 0
    if ($hasNewChanges) {
        $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm"
        git commit -m "更新公告板 $timestamp"
        
        # 推送到 xingyou-bulletin
        git push https://github.com/w657315754-spec/xingyou-bulletin.git gh-pages:main -f
        Write-Host "同步完成！" -ForegroundColor Green
    } else {
        Write-Host "没有新内容需要同步" -ForegroundColor Yellow
    }
} finally {
    # 切回原分支
    git checkout $currentBranch
    
    # 恢复 stash
    if ($stashed) {
        Write-Host "恢复暂存的更改..." -ForegroundColor Yellow
        git stash pop
    }
}

Write-Host "网站地址: https://w657315754-spec.github.io/xingyou-bulletin/" -ForegroundColor Cyan
