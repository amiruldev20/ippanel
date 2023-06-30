#!/bin/bash

echo "Installing nvm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
source ~/.nvm/nvm.sh

echo "Installing Node.js v19.8.1..."
nvm install v19.8.1
nvm use v19.8.1

echo "Installing pm2..."
npm install pm2 -g

echo "Installation completed!"
