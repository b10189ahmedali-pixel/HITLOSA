#!/bin/bash

clear
echo "=== Hilos Host Installer ==="

# Clone project
git clone https://github.com/b10189ahmedali-pixel/hilos-host.git
cd hilos-host/src || exit

# Ask Admin Info
read -p "Admin Username: " adminuser
read -p "Admin Password: " adminpass
read -p "Admin Email: " adminemail
read -p "First Name: " firstname
read -p "Last Name: " lastname

cat > admin.json <<EOF
{
  "username": "$adminuser",
  "password": "$adminpass",
  "email": "$adminemail",
  "first_name": "$firstname",
  "last_name": "$lastname"
}
EOF

# Ask Node Info
read -p "Node Token: " nodetoken
read -p "Token ID: " tokenid
read -p "Panel Link: " panellink
read -p "Panel ID: " panelid

cat > nodes.json <<EOF
{
  "token": "$nodetoken",
  "token_id": "$tokenid",
  "panel_link": "$panellink",
  "panel_id": "$panelid"
}
EOF

mkdir -p servers

npm install
node index.js
