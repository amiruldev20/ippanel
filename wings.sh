#!/bin/bash
# AUTO INSTALL WINGS BY AMIRUL DEV 
WINGS_SSL=$1
WINGS_FQDN=$2

dist=$(lsb_release -is 2>/dev/null || echo "unknown")
dist=$(echo "$dist" | tr '[:upper:]' '[:lower:]')

wings(){
    if [ "$dist" = "debian" ] || [ "$dist" = "ubuntu" ]; then
        apt install dnsutils certbot curl tar unzip -y
    elif [ "$dist" = "centos" ]; then
        yum install bind-utils certbot policycoreutils policycoreutils-python selinux-policy selinux-policy-targeted libselinux-utils setroubleshoot-server setools setools-console mcstrans tar unzip zip -y
    fi

    if [ "$WINGSNOQUESTIONS" = "true" ]; then
        WINGS_FQDN_STATUS=false
        wings_full
    elif [ "$WINGSNOQUESTIONS" = "false" ]; then
        clear
        echo ""
        echo "[!] Before installation, we need some information."
        echo ""
        wings_fqdn
    fi
}

wings_fqdnask(){
    # Remove the read command, as the input is now taken from args
    if [[ "$WINGS_SSL" =~ [Yy] ]]; then
        panel_fqdn
    fi
    if [[ "$WINGS_SSL" =~ [Nn] ]]; then
        WINGS_FQDN_STATUS=false
        wings_full
    fi
}

wings_full(){
    if [ "$dist" = "debian" ] || [ "$dist" = "ubuntu" ]; then
        apt-get update && apt-get -y install curl tar unzip

        if ! command -v docker &> /dev/null; then
            curl -sSL https://get.docker.com/ | CHANNEL=stable bash
            systemctl enable --now docker
        else
            echo "[!] Docker is already installed."
        fi

        if ! mkdir -p /etc/pterodactyl; then
            echo "[!] An error occurred. Could not create directory." >&2
            exit 1
        fi

        if [ "$WINGS_FQDN_STATUS" =  "true" ]; then
            systemctl stop nginx apache2
            apt install -y certbot && certbot certonly --standalone -d $WINGS_FQDN --staple-ocsp --no-eff-email --agree-tos
        fi

        curl -L -o /usr/local/bin/wings "https://github.com/pterodactyl/wings/releases/latest/download/wings_linux_$([[ "$(uname -m)" == "x86_64" ]] && echo "amd64" || echo "arm64")"
        curl -o /etc/systemd/system/wings.service https://raw.githubusercontent.com/guldkage/Pterodactyl-Installer/main/configs/wings.service
        chmod u+x /usr/local/bin/wings
        clear
        echo ""
        echo "[!] Pterodactyl Wings successfully installed."
        echo "    You still need to setup the Node"
        echo "    on the Panel and restart Wings after."
        echo ""

        if [ "$INSTALLBOTH" = "true" ]; then
            INSTALLBOTH="0"
            finish
        fi
    else
        echo "[!] Your OS is not supported for installing Wings with this installer"
    fi
}

wings_fqdn(){
    # Remove the read command, as the input is now taken from args
    IP=$(dig +short myip.opendns.com @resolver2.opendns.com -4)
    DOMAIN=$(dig +short ${WINGS_FQDN})
    if [ "${IP}" != "${DOMAIN}" ]; then
        echo ""
        echo "FQDN canceled. Either FQDN is incorrect or you left this blank."
        WINGS_FQDN_STATUS=false
        wings_full
    else
        WINGS_FQDN_STATUS=true
        wings_full
    fi
}

# Main execution starts here
wings