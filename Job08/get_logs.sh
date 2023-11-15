
utilisateur="chips"

nombre_connexions=$(last | grep "$utilisateur" | wc -l)

date_formattee=$(date +"%d-%m-%Y-%H:%M")

chemin="/home/chips/bureau/job08/Backup"

nom_fichier="number_connection-$date_formattee"


echo "Nombre de connexions de $utilisateur : $nombre_connexions" > "$nom_fichier.txt"


tar -cvf "$chemin/$nom_fichier.tar" "$nom_fichier.txt"

rm "$nom_fichier.txt"
