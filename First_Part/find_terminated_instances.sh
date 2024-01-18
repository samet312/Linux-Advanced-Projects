#!/bin/bash

# Cloudtrail event history dosyası
event_history_file="event_history.csv"

# Sonuç dosyası
result_file="result.txt"

# Hedef kullanıcı adı
target_user="Paul"

# Gerekli filtreleme ve dize manipülasyonu
grep -E "terminate" "$event_history_file" |     # TerminateInstances olaylarını seç
awk -F, -v user="$target_user" '{ for (i=1; i<=NF; i++) if ($i == user) {print $3; break} }' "$event_history_file" > "$result_file"


echo "Paul kullanıcısı tarafından sonlandırılan instance ID'leri 'result.txt' dosyasına yazıldı."
