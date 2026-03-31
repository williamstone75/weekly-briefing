#!/bin/bash
# 週報上傳 GitHub Pages 一鍵腳本
# 使用方式：在 Terminal 執行 bash push-to-github.sh

REPO="https://github.com/williamstone75/weekly-briefing.git"
FOLDER="$(cd "$(dirname "$0")" && pwd)"

echo "📁 工作資料夾：$FOLDER"
echo "🚀 開始上傳到 GitHub..."

cd "$FOLDER"

# 初始化 git（如果還沒有）
if [ ! -d ".git" ]; then
  git init
  git checkout -b main
  git config user.email "williamstone75@gmail.com"
  git config user.name "Stone"
fi

# 加入所有 HTML 檔案並 commit
git add index.html weekly-briefing-*.html
git commit -m "Add weekly briefing $(date +%Y-%m-%d)" 2>/dev/null || \
git commit --allow-empty -m "Update weekly briefing $(date +%Y-%m-%d)"

# 設定遠端（如果還沒有）
git remote remove origin 2>/dev/null
git remote add origin "$REPO"

# 推送
echo ""
echo "🔐 接下來會要求你輸入 GitHub 帳號密碼（或 Personal Access Token）"
echo "   帳號：williamstone75"
echo "   密碼：請輸入你的 Personal Access Token"
echo "   （到 github.com/settings/tokens 建立 token，需要 repo 權限）"
echo ""
git push -u origin main --force

echo ""
echo "✅ 完成！等待約 1 分鐘後前往："
echo "   👉 https://williamstone75.github.io/weekly-briefing/"
