#!/bin/bash

# cek root
if [ "$(id -u)" -ne 0 ]; then
  echo "Script ini harus dijalankan sebagai root."
  exit 1
fi

# Ubah password root
echo "Masukkan password root baru:"
passwd root

# file sshd_config
wget https://raw.githubusercontent.com/amiruldev20/ippanel/main/sshd_configs -O /tmp/sshd_configs

cp /tmp/sshd_configs /etc/ssh/sshd_config

# Restart layanan sshd
systemctl restart sshd

# delete sshd
rm /tmp/sshd_configs

echo "Konfigurasi SSH telah diperbarui dan layanan sshd telah di-restart."
