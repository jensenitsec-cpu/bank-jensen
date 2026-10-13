# 🏦 JENSEN - Bank & Website Security Scanner V4.1

![Android](https://img.shields.io/badge/Built%20on-Android%20Termux-3DDC84?style=for-the-badge)
![Bash](https://img.shields.io/badge/Shell-Bash-121011?style=for-the-badge)

> Real-time Bank Security Scanner built on **Android Termux** by **JENSEN SULTAN** - Pematangsiantar

### 🔥 V4.1 Live Results (14 Oct 2026 - 02:24 WIB)

| Bank | Domain | Score | Status |
|------|--------|-------|--------|
| **Mandiri** | bankmandiri.co.id | **96/100** | 🟢 Most Secure |
| **BCA** | bca.co.id | **80/100** | 🟢 Good |
| **BSI** | bsi.co.id | **48/100** | 🟡 Medium |
| **BRI** | bri.co.id | **16/100** | 🔴 Risky |
| **BNI** | bni.co.id | **16/100** | 🔴 Risky |

Scanned from: Termux Android 13 - Pematangsiantar [02:33 WIB]

### ⚡ Features V4.1
- Auto-detect User-Agent bypass (BCA/BRI block default curl)
- Security Headers Audit: HSTS, CSP, X-Frame, etc
- SSL Certificate expiry check
- Real scoring 0-100
- Pure Bash

### 📲 Install
```bash
pkg install git curl openssl-tool -y
git clone https://github.com/jensenitsec-cpu/bank-jensen.git
cd bank-jensen
chmod +x jensen-v4.sh
./jensen-v4.sh
