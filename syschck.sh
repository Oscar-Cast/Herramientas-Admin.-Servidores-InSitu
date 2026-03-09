#!/bin/bash
# Hace un chequeo de componentes del sistema y envia los resultados a logs en un directorio de destino
#Script by MAGGICC
salida=$1

if [ ! -d "$salida" ]; then
 	echo "Directorio no encontrado."
 	exit 1
 fi

# CPU [Topología e integridad de nucleos]
lscpu > "$salida"/check_cpu.txt
lscpu -e >> "$salida"/check_cpu.txt

# PCI [Hardware y controladores activos]
lspci -knn > "$salida"/check_pci.txt 

# Almacenamiento [Estructura de bloques y números de serie]
lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINT,SERIAL > "$salida"/check_blk.txt

#RAM [Intenta con free, respalda con meminfo]
if ! free > "$salida"/check_ram.txt; then
	cat /proc/meminfo > "$salida"/check_ram.txt
fi

 # INTEGRIDAD [Errores críticos del kernel (Hardware fallando)]
 # Esto busca fallos de lectura, voltajes y errores de bus
 dmesg -T --level=err,crit,alert > "$salida"/check_hardwarefail.txt

 # SOFTWARE [Verificar integridad de paquetes instalados]
 # Compara hashes de archivos actuales vs instalación original
 echo "Verificando integridad de archivos de sistema (esto puede tardar)..."
 dpkg --verify > "$salida"/check_softwareint.txt
 
 echo "Diagnóstico completado con éxito."
