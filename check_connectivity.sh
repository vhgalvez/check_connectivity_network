#!/bin/bash

# Definir el archivo de reporte
reporte="reporte_conectividad.log"

# Limpiar el archivo de reporte anterior
> "$reporte"

# Encabezado de la tabla
echo -e "IP Address\t\tHostname\t\t\tStatus" >> "$reporte"
echo -e "----------\t\t--------\t\t\t------" >> "$reporte"

# Lista de direcciones IP y sus nombres de host correspondientes
declare -A ips=(
    ["10.17.4.21"]="master1.cefaslocalserver.com"
    ["10.17.4.22"]="master2.cefaslocalserver.com"
    ["10.17.4.23"]="master3.cefaslocalserver.com"
    ["10.17.4.24"]="worker1.cefaslocalserver.com"
    ["10.17.4.25"]="worker2.cefaslocalserver.com"
    ["10.17.4.26"]="worker3.cefaslocalserver.com"
    ["10.17.3.11"]="freeipa1.cefaslocalserver.com"
    ["10.17.3.12"]="loadbalancer1.cefaslocalserver.com"
    ["10.17.3.13"]="postgresql1.cefaslocalserver.com"
    ["10.17.3.14"]="bootstrap1.cefaslocalserver.com"
    ["10.17.4.1"]="virbr1 (gateway)"
    ["10.17.3.1"]="virbr0 (gateway)"
    ["8.8.8.8"]="Google DNS"
    ["192.168.0.20"]="bastion1.cefaslocalserver.com"
)

# Función para hacer ping y guardar errores
ping_and_log() {
    local ip=$1
    local name=$2
    if ping -c 4 "$ip" > /dev/null 2>> "$reporte"; then
        echo -e "$ip\t\t$name\t\tSuccess" >> "$reporte"
    else
        echo -e "$ip\t\t$name\t\tFailed" >> "$reporte"
    fi
}

# Función para mostrar la barra de progreso
show_progress() {
    local progress=$1
    local total=$2
    local percent=$(( progress * 100 / total ))
    local bar=""
    
    for ((i = 0; i < percent; i += 2)); do
        bar="${bar}#"
    done
    
    printf "\r[%-50s] %d%%" "$bar" "$percent"
}

# Realizar pings y registrar resultados en la tabla con barra de progreso
total_ips=${#ips[@]}
i=0
for ip in "${!ips[@]}"; do
    ping_and_log "$ip" "${ips[$ip]}"
    show_progress $((++i)) $total_ips
done

echo

# Comprobar si hubo errores y agregar el resultado final
if grep -q "Failed" "$reporte"; then
    echo -e "\nConectividad Fallida" >> "$reporte"
else
    echo -e "\nConectividad Exitosa" >> "$reporte"
fi

# Mostrar el reporte
cat "$reporte"