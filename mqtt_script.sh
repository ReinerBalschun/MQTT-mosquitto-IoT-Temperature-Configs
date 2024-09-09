#!/bin/bash

# Funktion zum Überprüfen, ob eine Zahl zwischen 15 und 35 liegt
function is_valid_number() {
  local number="$1"
  if [[ "$number" =~ ^[1-9][5-9]$|^[2-3][0-5]$ ]]; then
    return 0
  else
    return 1
  fi
}

# Eingabeaufforderung für 10 Zahlen
read -p "Gib bitte 10 Zahlen zwischen 15 und 35 ein (durch Leerzeichen getrennt): " numbers
# Zahlen in ein Array speichern und überprüfen
numbers_array=($numbers)
for number in "${numbers_array[@]}"; do
  if ! is_valid_number "$number"; then
    echo "Ungültige Zahl: $number. Bitte nur Zahlen zwischen 15 und 35 eingeben."
    exit 1
  fi
done

# MQTT-Topic
topic="Temp"

# Veröffentliche jede Zahl als separate Nachricht und gib sie aus
for number in "${numbers_array[@]}"; do
  mosquitto_pub -d -u "rb" --pw "rbdvm2024" -t "$topic" -m "$number"
  echo "Gesendet: $number"
  sleep 5
done