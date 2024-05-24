#!/bin/bash

# Definir el archivo de reporte
reporte="reporte_conectividad.log"

# Limpiar el archivo de reporte anterior
> "$reporte"

# Encabezado de la tabla
echo -e "IP Address\t\tStatus" >> "$reporte"   # Encabezado de la tabla con columnas de IP Address y Status
echo -e "----------\t\t------" >> "$reporte"   # Línea divisoria entre el encabezado y los datos

# Lista de direcciones IP a verificar
ips=("192.168.0.20" "10.17.4.20" "10.17.3.11" "10.17.4.1" "10.17.3.1" "8.8.8.8")

# Función para hacer ping a una IP y registrar el resultado en el archivo de reporte
ping_and_log() {
    local ip=$1
    if ping -c 4 "$ip" > /dev/null 2>> "$reporte"; then  # Se realiza un ping a la IP, se descarta la salida estándar y se guarda la salida de error en el archivo de reporte
        echo -e "$ip\t\tSuccess" >> "$reporte"           # Si el ping tiene éxito, se registra "Success" en el archivo de reporte
    else
        echo -e "$ip\t\tFailed" >> "$reporte"            # Si el ping falla, se registra "Failed" en el archivo de reporte
    fi
}

# Función para mostrar una barra de progreso
show_progress() {
    local progress=$1
    local total=$2
    local percent=$(( progress * 100 / total ))
    local bar=""

    for ((i = 0; i < percent; i += 2)); do
        bar="${bar}#"   # Se construye una barra de progreso basada en el porcentaje completado
    done

    printf "\r[%-50s] %d%%" "$bar" "$percent"   # Se muestra la barra de progreso en la consola
}

# Realizar pings a las IPs y registrar los resultados en el archivo de reporte con una barra de progreso
total_ips=${#ips[@]}
for i in "${!ips[@]}"; do
    ping_and_log "${ips[$i]}"      # Se realiza un ping a cada IP de la lista y se registra el resultado en el archivo de reporte
    show_progress $((i + 1)) $total_ips  # Se muestra una barra de progreso para indicar el avance
done

echo

# Comprobar si hubo errores y agregar el resultado final al archivo de reporte
if grep -q "Failed" "$reporte"; then
    echo -e "\nConectividad Fallida" >> "$reporte"   # Si se encontraron fallos, se registra "Conectividad Fallida" en el archivo de reporte
else
    echo -e "\nConectividad Exitosa" >> "$reporte"   # Si no se encontraron fallos, se registra "Conectividad Exitosa" en el archivo de reporte
fi

# Mostrar el contenido del archivo de reporte en la consola
cat "$reporte"   # Se muestra el contenido del archivo de reporte al finalizar