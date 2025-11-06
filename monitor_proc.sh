#!/bin/bash

# Crear carpeta de logs si no existe
mkdir -p /home/jav/proc_monitor/logs

LOG_FILE="/home/jav/proc_monitor/logs/proc_log_$(date +%Y%m%d).txt"

# Captura de señales
trap 'echo "$(date) - Proceso monitor_proc.sh recibido SIGHUP – reiniciando conteo" >> "$LOG_FILE"' SIGHUP
trap 'echo "$(date) - Proceso monitor_proc.sh terminado por SIGTERM" >> "$LOG_FILE"; exit 0' SIGTERM

# Bucle infinito de monitoreo
while true; do
    FECHA=$(date '+%Y-%m-%d %H:%M:%S')
    echo "===== Registro de procesos - $FECHA =====" >> "$LOG_FILE"
    echo "Top 5 procesos por CPU:" >> "$LOG_FILE"
    ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6 >> "$LOG_FILE"
    echo "Top 5 procesos por MEMORIA:" >> "$LOG_FILE"
    ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 6 >> "$LOG_FILE"
    echo -e "\n--------------------------\n" >> "$LOG_FILE"

    sleep 60  # Espera 60 segundos antes de la siguiente iteración
done

