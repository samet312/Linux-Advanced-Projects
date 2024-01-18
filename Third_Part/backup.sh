#!/bin/bash

# Check if we are root privilage or not

if [ "$(id -u)" -ne 0 ]; then
  echo "Lütfen scripti root yetkileriyle çalıştırın."
  exit 1
fi

# Which files are we going to back up. Please make sure to exist /home/ec2-user/data file
kaynak_dizin="/home/ec2-user/data"


# Where do we backup to. Please crete this file before execute this script
yedek_dizin="/mnt/backup"


# Create archive filename based on time
zaman_temsilcisi=$(date +"%Y%m%d-%H%M%S")
yedek dosya="${yedek_dizin}/backup_${zaman_temsilcisi}.tgz"


# Print start status message.

echo "Yedekleme işlemi başlatılıyor..."

# Backup the files using tar.

tar czf "$yedek_dosya" -C /home/ec2-user data

# Print end status message.

echo "Yedekleme tamamlandı. Arşiv şuraya kaydedildi: $yedek_dosya"

# Long listing of files in $dest to check file sizes.

ls -lh "$yedek_dizin"

-------------

# To set this script for executing in every 5 minutes, we'll create cronjob
# Crontab düzenleyicisini açın
#crontab -e

# Aşağıdaki satırı ekleyerek scriptin her 5 dakikada bir çalışmasını sağlayın
# */5 * * * * /scriptinizin/tam/yolu.sh