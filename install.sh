#!/bin/bash

# AUTO INSTALL DXCP.

echo "Installing nvm..."
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
source ~/.profile

echo "Installing Node.js v19.8.1..."
nvm install v19.8.1

echo "Installing pm2..."
npm install pm2 -g

echo "Installation completed!"
