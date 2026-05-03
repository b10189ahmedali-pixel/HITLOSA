#!/bin/bash

clear
echo "=================================="
echo "       HITLOSA AUTO INSTALLER     "
echo "=================================="

# Update packages
sudo apt update -y

# Install required packages
sudo apt install -y curl git unzip build-essential

# Install Node.js 20 if missing
if ! command -v node >/dev/null 2>&1; then
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt install -y nodejs
fi

# Install PM2 globally
sudo npm install -g pm2

# Clone project
git clone https://github.com/b10189ahmedali-pixel/HITLOSA.git
cd HITLOSA || exit

# Ask Admin Details
echo ""
echo "====== Admin Setup ======"
read -p "Username: " ADMIN_USER
read -p "Password: " ADMIN_PASS
read -p "Email: " ADMIN_EMAIL
read -p "First Name: " ADMIN_FIRST
read -p "Last Name: " ADMIN_LAST

cat > admin.json <<EOF
{
  "username": "$ADMIN_USER",
  "password": "$ADMIN_PASS",
  "email": "$ADMIN_EMAIL",
  "first_name": "$ADMIN_FIRST",
  "last_name": "$ADMIN_LAST"
}
EOF

# Ask Node Details
echo ""
echo "====== Node Setup ======"
read -p "Node Token: " NODE_TOKEN
read -p "Token ID: " TOKEN_ID
read -p "Panel Link: " PANEL_LINK
read -p "Panel ID: " PANEL_ID

cat > nodes.json <<EOF
{
  "token": "$NODE_TOKEN",
  "token_id": "$TOKEN_ID",
  "panel_link": "$PANEL_LINK",
  "panel_id": "$PANEL_ID"
}
EOF

# Create folders
mkdir -p servers
mkdir -p logs

# Install dependencies
echo ""
echo "Installing dependencies..."
npm install

# Build React + TypeScript frontend
if [ -f package.json ]; then
    npm run build || true
fi

# Start app with PM2
pm2 start npm --name "hitlosa" -- start
pm2 save
pm2 startup

echo ""
echo "=================================="
echo " HITLOSA INSTALLED SUCCESSFULLY "
echo "=================================="
echo "Panel Running with PM2"
echo "Use: pm2 logs hitlosa"
echo "Use: pm2 restart hitlosa"
echo "Use: pm2 stop hitlosa"
