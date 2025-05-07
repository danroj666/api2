#!/bin/bash

# Rango de fechas (del 19 de marzo de 2025 al 7 de mayo de 2025)
start_date="2025-03-19"
end_date="2025-05-07"

# Obtener los timestamps de las fechas de inicio y fin
start_timestamp=$(date -d "$start_date" +%s)
end_timestamp=$(date -d "$end_date" +%s)

# Realizar commits por cada día entre el rango
current_timestamp=$start_timestamp
while [ $current_timestamp -le $end_timestamp ]; do
  # Obtener la fecha en formato "YYYY-MM-DD"
  current_date=$(date -d "@$current_timestamp" "+%Y-%m-%d")
  
  # Hacer commits en cada minuto del día (puedes ajustar el número de commits por día)
  for i in {1..15}  # Cambia este número para hacer más o menos commits por día
  do
    # Ajuste para que los minutos tengan dos dígitos correctamente
    if [ $i -lt 10 ]; then
      minute="0$i"
    else
      minute="$i"
    fi

    # Establecer la fecha para el autor y el committer
    export GIT_COMMITTER_DATE="$current_date 12:$minute:00"
    GIT_AUTHOR_DATE="$current_date 12:$minute:00" git commit --allow-empty -m "Commit del día $current_date, número $i" --date="$current_date 12:$minute:00"
  done

  # Incrementar el timestamp para el siguiente día
  current_timestamp=$((current_timestamp + 86400))  # Incrementar un día (86400 segundos)
done

# Push al repositorio remoto
git push origin main

