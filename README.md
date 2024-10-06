# Proyecto: Configuración Automática de Páginas Web con Apache2

Este proyecto automatiza la creación de 4 páginas web utilizando Apache2 en un servidor Linux. Cada página web será accesible a través de un puerto diferente. El script `scriptApache.sh` se encarga de realizar la configuración completa del entorno, incluyendo la creación de directorios, configuración de virtual hosts y apertura de puertos en Apache2.

## Requisitos

- Sistema operativo: Linux 
- Apache2 instalado (el script lo instalará si no está )

## Estructura del Proyecto

- `/var/www/html/pagina1`: Carpeta con la página 1 (puerto 8081)
- `/var/www/html/pagina2`: Carpeta con la página 2 (puerto 8082)
- `/var/www/html/pagina3`: Carpeta con la página 3 (puerto 8083)
- `/var/www/html/pagina4`: Carpeta con la página 4 (puerto 8084)
  
- `/etc/apache2/sites-available/pagina1.conf`: Archivo de configuración para la página 1
- `/etc/apache2/sites-available/pagina2.conf`: Archivo de configuración para la página 2
- `/etc/apache2/sites-available/pagina3.conf`: Archivo de configuración para la página 3
- `/etc/apache2/sites-available/pagina4.conf`: Archivo de configuración para la página 4

## Instalación

Sigue los siguientes pasos para instalar y configurar el proyecto:

1. **Clonar el repositorio (si lo tienes en GitHub):**

   ```bash
   git clone https://github.com/Chakerr/Server-Apache.git
   cd Server-Apache
   ```
2. **Otorgar permisos de ejecución al script:**

   ```bash
   chmod +x scriptApache.sh
   ```
3. **Ejecutar el script:

Ejecuta el script como root o utilizando `sudo` para realizar la configuración:**

   ```bash
   sudo ./scriptApache.sh
   ```
El script realizará lo siguiente:

Instalación de Apache2
- Creación de 4 directorios en `/var/www/html`
- Creación de archivos `index.html` en cada directorio
- Configuración de virtual hosts para cada página en puertos diferentes (8081, 8082, 8083, 8084)
- Modificación del archivo `ports.conf` de Apache2 para escuchar en los nuevos puertos
- Reinicio del servicio Apache2

## Uso:
Una vez finalizada la ejecución del script, puedes acceder a las páginas web desde tu navegador web, utilizando los siguientes enlaces:
  - Página 1 - Puerto 8081
  - Página 2 - Puerto 8082
  - Página 3 - Puerto 8083
  - Página 4 - Puerto 8084
Si estás accediendo desde otra máquina, reemplaza `localhost` con la dirección IP del servidor.

## Personalización
Puedes personalizar las páginas web editando los archivos index.html en las carpetas correspondientes:

   ```bash
    /var/www/html/pagina1/index.html
    /var/www/html/pagina2/index.html
    /var/www/html/pagina3/index.html
    /var/www/html/pagina4/index.html
   ```

## Problemas frecuentes
- Apache2 no arranca después de modificar `ports.conf`: Verifica que los puertos no estén siendo utilizados por otros servicios. Puedes revisar esto con el comando:
- 
   ```bash
   sudo netstat -tuln | grep 808
   ```
- Permisos de archivos: Asegúrate de que los directorios y archivos en `/var/www/html` tengan los permisos correctos:
   ```bash
   sudo chown -R www-data:www-data /var/www/html/
   sudo chmod -R 755 /var/www/html/
   ```

Licencia
Este proyecto está bajo la licencia MIT. Consulta el archivo LICENSE para más detalles.
