#!/bin/bash

# Variables
DIR_BASE="/var/www/html"
SITIOS=("pagina1" "pagina2" "pagina3" "pagina4")
PUERTOS=(8081 8082 8083 8084)

# Verificar si el script se está ejecutando como root
if [ "$(id -u)" -ne 0 ]; then
    echo "Este script debe ejecutarse como root."
    exit 1
fi

# Instalar Apache2 si no está instalado
if ! dpkg -l | grep -q apache2; then
    echo "Instalando Apache2..."
    apt update
    apt install -y apache2
fi

# Crear directorios y archivos index.html para cada página
echo "Creando directorios y archivos index.html para cada página..."
for i in "${!SITIOS[@]}"; do
    mkdir -p "$DIR_BASE/${SITIOS[i]}"
    echo "<h1>${SITIOS[i]}</h1>" > "$DIR_BASE/${SITIOS[i]}/index.html"
done

# Crear archivos de configuración virtual host
echo "Creando archivos de configuración para cada sitio..."
for i in "${!SITIOS[@]}"; do
    CONF_FILE="/etc/apache2/sites-available/${SITIOS[i]}.conf"
    echo "<VirtualHost *:${PUERTOS[i]}>
    DocumentRoot $DIR_BASE/${SITIOS[i]}
    DirectoryIndex index.html
</VirtualHost>" > "$CONF_FILE"
done

# Abrir puertos en el archivo ports.conf
echo "Abriendo puertos en Apache..."
for puerto in "${PUERTOS[@]}"; do
    if ! grep -q "Listen $puerto" /etc/apache2/ports.conf; then
        echo "Listen $puerto" >> /etc/apache2/ports.conf
    fi
done

# Habilitar los sitios y reiniciar Apache
echo "Habilitando sitios y reiniciando Apache..."
for sitio in "${SITIOS[@]}"; do
    a2ensite "${sitio}.conf"
done

systemctl restart apache2

echo "¡La configuración ha sido completada!"
echo "Accede a tus páginas web en los siguientes puertos:"
for i in "${!PUERTOS[@]}"; do
    echo "http://localhost:${PUERTOS[i]} para ${SITIOS[i]}"
done
