#!/data/data/com.termux/files/usr/bin/bash
# JENSEN V4.1 - FIX BCA/BRI
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; CYAN='\033[0;36m'; NC='\033[0m'; BOLD='\033[1m'
TMPDIR=$PREFIX/tmp
echo -e "${CYAN} JENSEN V4.1 FIX${NC}"
echo -e "${BOLD}${YELLOW} BANK SCANNER - BCA/BRI REAL SCAN${NC}"
scan_domain() {
  domain=$1; label=$2
  echo ""; echo -e "${BOLD}${CYAN}▶ SCANNING: $label ($domain)${NC}"
  headers=$(curl -s -I -L -m 15 -A "Mozilla/5.0 (Linux; Android 13)" https://$domain 2>/dev/null)
  echo "$headers" | head -20
  score=0
  echo -e "${YELLOW}[1] Headers:${NC}"
  for h in "strict-transport-security" "content-security-policy" "x-frame-options" "x-content-type-options" "referrer-policy" "x-xss-protection"; do
    if echo "$headers" | grep -iq "$h"; then echo -e " ${GREEN}✔ $h${NC}"; ((score+=16)); else echo -e " ${RED}✘ $h Missing${NC}"; fi
  done
  if [ $score -gt 100 ]; then score=100; fi
  echo -e "${YELLOW}[2] SSL:${NC}"
  ssl=$(echo | openssl s_client -connect $domain:443 -servername $domain 2>/dev/null | openssl x509 -noout -dates 2>/dev/null | grep notAfter)
  if [ -n "$ssl" ]; then echo -e " ${GREEN}$ssl${NC}"; else echo -e " ${RED}SSL fail${NC}"; fi
  echo -e "${YELLOW}[3] Score: ${GREEN}${BOLD}$score/100${NC}"
  echo "$label|$domain|$score" >> $TMPDIR/jensen-v4.txt
}
rm -f $TMPDIR/jensen-v4.txt
echo -e "1 - All Banks\n2 - BCA & BRI Only\n3 - Custom"; read -p "Pilih [1/2/3]: " mode
if [ "$mode" = "1" ]; then scan_domain "bca.co.id" "BCA"; scan_domain "bri.co.id" "BRI"; scan_domain "bankmandiri.co.id" "Mandiri"; scan_domain "bni.co.id" "BNI"; scan_domain "bsi.co.id" "BSI"
elif [ "$mode" = "2" ]; then scan_domain "bca.co.id" "BCA"; scan_domain "bri.co.id" "BRI"
else read -p "Domain: " custom; scan_domain "$custom" "CUSTOM"; fi
echo ""; echo "═══ SUMMARY ═══"; cat $TMPDIR/jensen-v4.txt 2>/dev/null
