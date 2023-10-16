#!/bin/bash

# Spécifiez le chemin complet vers le fichier CSV contenant les informations des utilisateurs
fichier_csv="/home/chips/bureau/job09/Shell_Userlist.csv"

# Fonction pour créer un utilisateur et définir les permissions sudo
creer_utilisateur() {
  local nom_utilisateur="$1"
  local est_admin="$2"

  # Créer l'utilisateur
  sudo useradd "$nom_utilisateur"

  # Si l'utilisateur est un administrateur, ajouter aux sudoers
  if [ "$est_admin" -eq 1 ]; then
    sudo usermod -aG sudo "$nom_utilisateur"
  fi
}

# Vérifier si le fichier CSV a été modifié depuis la dernière exécution
if [ -e "$fichier_csv" ]; then
  if [ "$fichier_csv" -nt "$fichier_csv_derniere_modif" ]; then
    fichier_csv_derniere_modif=$(date -r "$fichier_csv" +"%s")
    
    # Lire le fichier CSV ligne par ligne
    while IFS=, read -r nom_utilisateur est_admin
    do
      creer_utilisateur "$nom_utilisateur" "$est_admin"
    done < "$fichier_csv"
  fi
fi

