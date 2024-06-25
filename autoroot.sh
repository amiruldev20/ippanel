#!/bin/bash
# mod by amiruldev

if [ "$(id -u)" -ne 0 ]; then
  echo "Script ini harus dijalankan sebagai root."
  exit 1
fi

wget -qO /etc/ssh/sshd_config https://raw.githubusercontent.com/amiruldev20/ippanel/main/sshd_configs
systemctl restart sshd
clear
echo -e "Masukkan Password baru root:"
read -s pwe
usermod -p "$(openssl passwd -1 "$pwe")" root
clear
echo -e "Masukkan Hostname baru:"
read new_hostname
hostnamectl set-hostname "$new_hostname"
banner_file="/etc/motd"
echo "============================================" > "$banner_file"
echo "Welcome to $new_hostname VPS" >> "$banner_file"
echo "Managed by amiruldev" >> "$banner_file"
echo "============================================" >> "$banner_file"

ip_address=$(curl -Ls http://ipinfo.io/ip)

printf "Mohon Simpan Informasi Akun VPS Ini\n"
printf "============================================\n"
printf "Akun Root (Akun Utama)\n"
printf "Hostname   = %s\n" "$new_hostname"
printf "Ip address = %s\n" "$ip_address"
printf "Username   = root\n"
printf "Password   = %s\n" "$pwe"
printf "Made by Amirul Dev"
printf "============================================\n"
echo ""

exit
