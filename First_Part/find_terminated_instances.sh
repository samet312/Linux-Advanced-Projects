#!/bin/bash

# event history dosyası
event_history_file="event_history.csv"

# Sonuç dosyası
result_file="result.txt"

# Hedef kullanıcı adı
target_user="Paul"

# Gerekli filtreleme ve dize manipülasyonu

# result.txt dosyasına başlıkları ekleyerek oluşturma
printf "Sıra  | KullanıcıAdı  | InstanceID          | İşlem\n" > "$result_file"

# event_history.csv dosyasında $target_user tarafından gerçekleştirilen işlemlerden terminate ettiği instanceları filtreliyoruz
grep -i "$target_user" "$event_history_file" | grep -i "TerminateInstances" |  
egrep -o "i-.{17}" | # Instance ID'lerini çıkarma
sort | # sıralama
uniq | # Tekilleştirme
# 'awk' komutuyla her bir satır için belirli genişlikte({printf "%-6s| %-14s| %-20s| %-16s\n") alanlara sahip bir tablo oluşturulur ve çıktı 'result.txt' dosyasına eklenir.
awk '{printf "%-6s| %-14s| %-20s| %-16s\n", NR, "paul", $0, "TerminateInstances"}' >> "$result_file"

# Toplam terminate instance sayısını "result.txt" dosyasına ekliyoruz. (wc -l) komutu bir dosyanın kaç satırdan oluştuğunu sayar. Filtreleme olduğu için ilk satır dikkate alınmaz
printf "\nToplam: %s\n" "$(grep -i "paul" "$event_history_file" | grep -i "TerminateInstances" | egrep -o "i-.{17}" | sort | uniq  | wc -l)" >> "$result_file"

echo "Paul kullanıcısı tarafından sonlandırılan instance ID'leri '$result_file' dosyasına yazıldı."
