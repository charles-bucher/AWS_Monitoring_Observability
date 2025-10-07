#!/bin/bash

# ORGANIZER SCRIPT FOR Proactive-monitoring-with-cloudwatch-sns

# Ensure we're inside the repo
if [ ! -f "README.md" ]; then
    echo "Error: No README.md found. Run this script inside the repo root."
    exit 1
fi

echo "🔹 Starting repo organization..."

# Step 1 — Create standard folders
mkdir -p screenshots scripts terraform docs modules assets

# Step 2 — Move screenshots into screenshots folder
echo "📷 Organizing screenshots..."
shopt -s nocaseglob
mv *.png screenshots/ 2>/dev/null
mv *.jpg screenshots/ 2>/dev/null
mv screenshots* screenshots/ 2>/dev/null
shopt -u nocaseglob

# Step 3 — Move scripts into scripts folder
echo "🛠 Organizing scripts..."
mv *.sh scripts/ 2>/dev/null
mv push-fresh.ps1 scripts/ 2>/dev/null

# Step 4 — Move Terraform files
echo "📂 Organizing Terraform..."
mv *.tf terraform/ 2>/dev/null
mv terraform/* terraform/ 2>/dev/null

# Step 5 — Move docs
echo "📚 Organizing docs..."
mv docs/* docs/ 2>/dev/null

# Step 6 — Move modules
echo "📦 Organizing modules..."
mv modules/* modules/ 2>/dev/null

# Step 7 — Move assets
echo "🎨 Organizing assets..."
mv assets/* assets/ 2>/dev/null

# Step 8 — Create .gitignore if missing
if [ ! -f ".gitignore" ]; then
    echo "Creating .gitignore..."
    cat <<EOL > .gitignore
# System files
.DS_Store
Thumbs.db

# Logs
*.log

# Terraform
*.tfstate
*.tfstate.*

# IDEs
.vscode/
.idea/
EOL
fi

# Step 9 — Clean up duplicates
echo "🧹 Cleaning up unnecessary files..."
rm -rf "__MACOSX" "* - Copy" "*.bak"

echo "✅ Repo organization complete!"
