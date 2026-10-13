#!/bin/bash
echo "🏦 JENSEN V4.2 - Auto PDF"
DATE=$(date)
echo "Scanning banks..."
echo "JENSEN V4.2 REPORT - $DATE" > report.txt
echo "Pematangsiantar - Android Termux" >> report.txt
for b in bankmandiri.co.id bca.co.id bri.co.id; do
 echo -e "\n=== $b ===" >> report.txt
 curl -s -I -k https://$b | grep -i -E "strict|content-security|x-frame|x-content|server" >> report.txt
done
cat report.txt
pip install reportlab -q
python3 << 'PY'
from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import A4
c=canvas.Canvas("JENSEN_V4.2_Report.pdf",pagesize=A4)
c.setFont("Helvetica-Bold",16)
c.drawString(30,800,"JENSEN V4.2 - Bank Security Report")
c.setFont("Helvetica",10)
y=770
for line in open("report.txt").read().split("\n")[:70]:
 c.drawString(30,y,line[:110]); y-=14
 if y<20: c.showPage(); y=800
c.save()
print("PDF OK")
PY
ls -lh *.pdf
