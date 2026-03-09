#!/bin/bash
# Lista de direcciones IP o dominios
dispositivos=("8.8.8.8" "1.1.1.1" "google.com" "192.168.1.1")
echo "Verificando conectividad..."
for ip in "${dispositivos[@]}"
do
	echo "Probando conexión con $ip"
	ping -c 2 $ip > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "$ip -> Conectividad OK"
	else
		echo "$ip -> Sin conexión"
	fi
		echo "---------------------------"
done

echo "Prueba finalizada"
