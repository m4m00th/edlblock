#!/bin/bash

# Dirección de la lista a utilizar
URL="https://rules.emergingthreats.net/blockrules/compromised-ips.txt"

# Ruta donde se guardará el archivo descargado
DESTINATION_PATH="./iocipv4.txt"

# Descargar el archivo usando curl
echo "Descargando el archivo desde $URL..."

curl -o "$DESTINATION_PATH" "$URL"

# Verificar si la descarga fue exitosa
if [ $? -eq 0 ]; then
    echo "Archivo descargado con éxito en: $DESTINATION_PATH"
else
    echo "Error: No se pudo descargar el archivo."
    exit 1
fi

# Archivo de configuración para pf
PF_CONF="/etc/pf.conf"
# Archivo temporal para las reglas nuevas
PF_TEMP_CONF="/tmp/pf_temp.conf"

# Archivo de texto que contiene las IPs a bloquear (una IP por línea)
IP_LIST_FILE="iocipv4.txt"

# Verificar si el archivo de IPs existe
if [ ! -f "$IP_LIST_FILE" ]; then
    echo "Error: No se encontró el archivo $IP_LIST_FILE"
    exit 1
fi

# Backup del archivo pf.conf actual
sudo cp $PF_CONF ${PF_CONF}.bak

# Crear archivo de configuración temporal con las reglas actuales
sudo cp $PF_CONF $PF_TEMP_CONF

# Agregar las reglas de bloqueo de salida
echo "" >> $PF_TEMP_CONF
echo "# Bloquear tráfico de salida hacia direcciones IP del archivo $IP_LIST_FILE" >> $PF_TEMP_CONF

# Leer IPs desde el archivo y agregar reglas
while IFS= read -r ip; do
    # Evitar líneas vacías
    if [[ ! -z "$ip" ]]; then
        echo "block drop out from any to $ip" >> $PF_TEMP_CONF
    fi
done < "$IP_LIST_FILE"

# Reemplazar el archivo de configuración original
sudo cp $PF_TEMP_CONF $PF_CONF

# Recargar la configuración del firewall pf
sudo pfctl -f $PF_CONF
sudo pfctl -e  # Habilitar pf si no estaba habilitado

# Limpiar archivo temporal
rm $PF_TEMP_CONF
rm $DESTINATION_PATH

echo "Las direcciones IP del archivo $IP_LIST_FILE han sido bloqueadas para tráfico de salida."