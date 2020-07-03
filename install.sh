#!/bin/bash
#Should run as root
#User should download propietary linux deb file from Netacad.com

#Check user folder for deb file
USERF="
FOLDER="/tmp/PacketTracer/"
if [ -d "$FOLDER" ]; then
	rm -rf "$FOLDER"
else
fi

cp PacketTracer_730_amd.deb /tmp/PacketTracer/
cd /tmp/PacketTracer/
ar -xv PacketTracer_730_amd64.deb
mkdir control
tar -C data -Jxf control.tar.xz
mkdir data
tar -C data -Jxf data.tar.xz
cd data
