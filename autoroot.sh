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
# Ubah password root
usermod -p "$(openssl passwd -1 "$pwe")" root
clear
ip_address=$(curl -Ls http://ipinfo.io/ip)

# Tampilkan informasi akun
printf "Mohon Simpan Informasi Akun VPS Ini\n"
printf "============================================\n"
printf "Akun Root (Akun Utama)\n"
printf "Ip address = %s\n" "$ip_address"
printf "Username   = root\n"
printf "Password   = %s\n" "$pwe"
printf "============================================\n"
echo ""

exit
