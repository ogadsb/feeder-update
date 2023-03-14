#! /bin/bash


if [ $(id -u) -ne 0 ]; then
  echo -e "This script must be run as root. \n"
  exit 1
fi

echo -e "\n\n  APT clean"
apt autoremove -y
apt clean -y

echo -e "\n\n RESET UUID"
rm -f /boot/adsbfi-uuid

echo -e "\n RESET SSH"
rm /etc/ssh/ssh_host_*

echo -e "\n REMOVE BASH HISTORY"
rm /home/pi/.bash_history

# fail if this directory doesn't exist
if ! [[ -d /adsbfi/update/boot-configs ]]; then
    exit 1
fi

pushd /adsbfi/update/boot-configs &>/dev/null
for file in *; do
    echo -e "\n RESET /boot/$file"
    cp --remove-destination -f -T "$file" "/boot/$file"
done
popd &>/dev/null

echo -e "\n RESET WPA_SUPPLICANT CONF"
rm -f /etc/wpa_supplicant/wpa_supplicant.conf


exit 0
