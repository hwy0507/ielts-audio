# ========================================
# GitHub 自动上传脚本
# ========================================

Write-Host "🚀 开始上传到GitHub..." -ForegroundColor Green
Write-Host ""

# 检查是否已经在ielts-audio目录中
$currentPath = Get-Location
if ($currentPath.Path -like "*ielts-audio") {
    Write-Host "✅ 已在仓库目录中" -ForegroundColor Green
} else {
    Write-Host "❌ 请先运行克隆命令，或cd到ielts-audio目录" -ForegroundColor Red
    exit
}

Write-Host ""
Write-Host "📁 开始复制文件..." -ForegroundColor Cyan

# 复制剑桥雅思16
if (Test-Path "..\剑桥雅思16") {
    Write-Host "  复制 剑桥雅思16 ..." -ForegroundColor Yellow
    Copy-Item "..\剑桥雅思16" -Recurse -Destination ".\" -Force
    Write-Host "  ✅ 剑桥雅思16 复制完成" -ForegroundColor Green
} else {
    Write-Host "  ⚠️  找不到 剑桥雅思16 文件夹" -ForegroundColor Red
}

# 复制剑桥雅思17
if (Test-Path "..\剑桥雅思17") {
    Write-Host "  复制 剑桥雅思17 ..." -ForegroundColor Yellow
    Copy-Item "..\剑桥雅思17" -Recurse -Destination ".\" -Force
    Write-Host "  ✅ 剑桥雅思17 复制完成" -ForegroundColor Green
} else {
    Write-Host "  ⚠️  找不到 剑桥雅思17 文件夹" -ForegroundColor Red
}

# 复制剑桥雅思18
if (Test-Path "..\剑桥雅思18") {
    Write-Host "  复制 剑桥雅思18 ..." -ForegroundColor Yellow
    Copy-Item "..\剑桥雅思18" -Recurse -Destination ".\" -Force
    Write-Host "  ✅ 剑桥雅思18 复制完成" -ForegroundColor Green
} else {
    Write-Host "  ⚠️  找不到 剑桥雅思18 文件夹" -ForegroundColor Red
}

# 复制HTML文件
if (Test-Path "..\剑桥雅思听力音频.html") {
    Write-Host "  复制 HTML文件 ..." -ForegroundColor Yellow
    Copy-Item "..\剑桥雅思听力音频.html" -Destination ".\" -Force
    Write-Host "  ✅ HTML文件 复制完成" -ForegroundColor Green
} else {
    Write-Host "  ⚠️  找不到 剑桥雅思听力音频.html 文件" -ForegroundColor Red
}

Write-Host ""
Write-Host "📝 创建README文件..." -ForegroundColor Cyan
@"
# 🎧 剑桥雅思听力音频集

Cambridge IELTS Listening Audio Collection

## 📚 内容

- 剑桥雅思16：听力音频 + PDF资料
- 剑桥雅思17：听力音频 + PDF资料
- 剑桥雅思18：听力音频 + PDF资料

## 🌐 在线访问

访问地址：https://hwy0507.github.io/ielts-audio/剑桥雅思听力音频.html

## 📖 使用方法

1. 在线访问上面的链接
2. 或下载HTML文件后本地打开
3. 点击播放音频，点击PDF链接下载资料

## 📊 统计信息

- 总文件数：51 个
- 音频文件：48 个
- PDF文件：3 个
- 总大小：约 537 MB

---

生成时间：2025年10月23日
"@ | Out-File -FilePath "README.md" -Encoding UTF8

Write-Host "  ✅ README文件 创建完成" -ForegroundColor Green

Write-Host ""
Write-Host "📤 准备提交到Git..." -ForegroundColor Cyan

# 查看状态
Write-Host ""
Write-Host "当前状态：" -ForegroundColor Yellow
git status

Write-Host ""
$continue = Read-Host "是否继续提交并上传到GitHub？(y/n)"

if ($continue -eq "y" -or $continue -eq "Y") {
    Write-Host ""
    Write-Host "📦 添加文件到Git..." -ForegroundColor Cyan
    git add .
    
    Write-Host ""
    Write-Host "💾 提交到本地仓库..." -ForegroundColor Cyan
    git commit -m "上传剑桥雅思16、17、18听力音频和PDF资料"
    
    Write-Host ""
    Write-Host "🚀 推送到GitHub（这可能需要5-15分钟）..." -ForegroundColor Cyan
    Write-Host "⚠️  如果需要登录，请使用GitHub Token而不是密码" -ForegroundColor Yellow
    Write-Host "Token获取地址: https://github.com/settings/tokens" -ForegroundColor Yellow
    Write-Host ""
    
    git push origin main
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "🎉 上传成功！" -ForegroundColor Green
        Write-Host ""
        Write-Host "下一步：" -ForegroundColor Cyan
        Write-Host "1. 访问 https://github.com/hwy0507/ielts-audio 查看文件"
        Write-Host "2. 进入 Settings > Pages 启用GitHub Pages"
        Write-Host "3. 等待1-2分钟后访问 https://hwy0507.github.io/ielts-audio/"
        Write-Host ""
    } else {
        Write-Host ""
        Write-Host "❌ 上传失败，请检查错误信息" -ForegroundColor Red
        Write-Host ""
        Write-Host "常见问题：" -ForegroundColor Yellow
        Write-Host "1. 需要Token登录：访问 https://github.com/settings/tokens"
        Write-Host "2. 网络问题：检查网络连接或使用VPN"
        Write-Host "3. 权限问题：确保已登录正确的GitHub账号"
    }
} else {
    Write-Host ""
    Write-Host "⏸️  已取消上传" -ForegroundColor Yellow
    Write-Host "文件已复制到本地仓库，您可以稍后手动执行：" -ForegroundColor Cyan
    Write-Host "  git add ."
    Write-Host "  git commit -m '上传文件'"
    Write-Host "  git push origin main"
}

Write-Host ""
Write-Host "按任意键退出..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
