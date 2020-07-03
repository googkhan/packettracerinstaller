#!/bin/bash
#Should run as root
#User should download propietary linux deb file from Netacad.com

#Check user folder for deb file
FOLDER="/tmp/PacketTracer/"
if [ -d "$FOLDER" ]; then
	rm -rf "$FOLDER"
else
	mkdir /tmp/PacketTracer/
fi

#Open deb file

cp PacketTracer_730_amd.deb /tmp/PacketTracer/
cd /tmp/PacketTracer/
ar -xv PacketTracer_730_amd64.deb
mkdir control
tar -C data -Jxf control.tar.xz
mkdir data
tar -C data -Jxf data.tar.xz
cd data

#Cleaning

rm -rf /opt/pt
rm -rf /usr/share/applications/cisco-pt7.desktop
rm -rf /usr/share/applications/cisco-ptsa7.desktop
rm -rf /usr/share/icons/hicolor/48x48/apps/pt7.png

#Libraries
ln -s /usr/lib64/libdouble-conversion.so.3.1.5 /usr/lib64/libdouble-conversion.so.1

#Icons Menus Mimedb
xdg-desktop-menu install /usr/share/applications/cisco-pt7.desktop
xdg-desktop-menu install /usr/share/applications/cisco-ptsa7.desktop
update-mime-database /usr/share/mime
gtk-update-icon-cache --force --ignore-theme-index /usr/share/icons/gnome
xdg-mime default cisco-ptsa7.desktop x-scheme-handler/pttp

#Link install
ln -sf /opt/pt/packettracer /usr/local/bin/packettracer

#Enviroinment vars
cat << "EOF" >> /etc/profile.local
PT7HOME=/opt/pt
export PT7HOME
QT_DEVICE_PIXEL_RATIO=auto
export QT_DEVICE_PIXEL_RATIO
EOF

#Cleaning
rm -rf /tmp/PacketTracer/

echo "Enter to continue..."
read
echo \n
