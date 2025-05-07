#!/bin/bash

# Función para hacer 24 commits en un día específico
hacer_commits() {
  dia=$1
  mes=$2
  anio=$3

  for i in {1..24}  # 24 commits por día
  do
    minute=$(printf "%02d" $((i % 60)))  # Para asegurar minutos válidos (aunque nunca pasará de 24)
    hour=$((10 + (i / 6)))  # Distribuye commits entre horas 10-14

    export GIT_COMMITTER_DATE="$anio-$mes-$dia $hour:$minute:00"
    GIT_AUTHOR_DATE="$anio-$mes-$dia $hour:$minute:00" git commit --allow-empty -m "Commit del día $anio-$mes-$dia, número $i" --date="$anio-$mes-$dia $hour:$minute:00"
  done
}

# ---- COMIENZAN LOS COMMITS ----

# Del 14 al 20 de marzo de 2025
for d in {14..20}
do
  hacer_commits $d "03" "2025"
done

# Del 22 al 30 de marzo de 2025
for d in {22..30}
do
  hacer_commits $d "03" "2025"
done

# 1 y 2 de abril de 2025
for d in {1..2}
do
  hacer_commits $(printf "%02d" $d) "04" "2025"
done

# Del 3 al 10 de mayo de 2025 (excepto 7)
for d in {3..10}
do
  if [ "$d" -eq 7 ]; then
    continue
  fi
  hacer_commits $(printf "%02d" $d) "05" "2025"
done

# ---- HACER PUSH ----
git push origin main

