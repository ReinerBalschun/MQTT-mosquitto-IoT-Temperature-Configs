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

# Preset-Funktion
function use_preset() {
  # Hier kannst du dein gewünschtes Preset definieren
  local preset_numbers=(15 19 21 25 28 31 31 29 25 20)
  # Preset-Zahlen in das numbers_array kopieren
  numbers_array=("${preset_numbers[@]}")
}

# Eingabeaufforderung für Preset oder manuelle Eingabe
while true; do
  read -p "Möchten Sie das Preset verwenden? (y/n): " use_preset_choice
  if [[ "$use_preset_choice" == "y" || "$use_preset_choice" == "n" ]]; then
    break
  else
    echo "Bitte geben Sie nur 'y' oder 'n' ein."
  fi
done

if [[ "$use_preset_choice" == "y" ]]; then
  use_preset
else
  # Eingabeaufforderung für 10 Zahlen
  read -p "Gib bitte 10 Zahlen zwischen 15 und 35 ein (durch Leerzeichen getrennt): " numbers
  # Zahlen in ein Array speichern
  numbers_array=($numbers)
fi

# Überprüfung der Zahlen (wird für beide Fälle ausgeführt)
for number in "${numbers_array[@]}"; do
  if ! is_valid_number "$number"; then
    echo "Ungültige Zahl: $number. Bitte nur Zahlen zwischen 15 und 35 eingeben."
    exit 1
  fi
done
