#!/bin/bash
#
# This script creates a new user on the local system.
# You will be prompted to enter the username (login), the person name, and a password.
# The username, password, and host for the account will be displayed.

# Make sure the script is being executed with superuser privileges.
if [ "$(id -u)" != "0" ]; then
  echo "root yetkisi gerekli." 1>&2
  exit 1
fi

# Get the username (login).
read -p "Yeni hesap için kullanıcı adını girin: " username

# Get the real name (contents for the description field).

read -p "Kullanıcının gerçek adını girin: " realname

# Get the password.
read -s -p "Yeni hesap için şifreyi girin: " password

# Create the account.

useradd -c "$realname" -m "$username"

# Check to see if the useradd command succeeded.
# We don't want to tell the user that an account was created when it hasn't been.

if [ $? -ne 0 ]; then
  echo "Hesap oluşturulamadı."
  exit 1
fi

# Set the password.

echo "$username:$password" | chpasswd
# Check to see if the passwd command succeeded.
if [ $? -ne 0 ]; then
  echo "Şifre ayarlanamadı."
  exit 1
fi


# Force password change on first login.
passwd -e "$username"

# Display the username, password, and the host where the user was created.
echo "Kullanıcı adı: $username"
echo "Şifre: $password"
echo "Hesap oluşturulduğu makine adı: $(hostname)"