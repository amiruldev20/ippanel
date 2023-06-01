#!/bin/bash

# AUTO INSTALL DXCP.

echo "Installing nvm..."
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
source ~/.profile

echo "Installing Node.js v19.8.1..."
nvm install v19.8.1
nvm use v19.8.1
nvm install --latest-npm

echo "Installing pm2..."
npm install pm2 -g

echo "Exporting pm2 path..."
mkdir -p ~/.bin
ln -s ~/node_modules/pm2/bin/pm2 ~/.bin/pm2
echo 'export PATH=$PATH:~/.bin' >> ~/.bashrc
source ~/.bashrc

echo "Installation completed!"
