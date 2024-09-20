# edlblock

La idea es simple, teniendo de fuente una lista dinámica externa de direcciones IP (EDL que este expuesta por http(s)) publica o privada (en este caso se necesitaría claves de logueo) estas se puedan bloquear directamente en un equipo endpoint:

    1.- Windows vía powershell.
    2.- MacOS vía bash (Próximamente).
    3.- Linux vía bash (Próximamente).

## **Windows:**

### Funcionamiento:

A modo de ejemplo usuraremos la lista libre https://rules.emergingthreats.net/blockrules/compromised-ips.txt

    1.- Acceder a la lista.
    2.- Trabajar el archivo vía Powershell.
    3.- Bloquer en firewall de Windows equipo vía netsh.exe

### Requisitos:

    1.- El equipo Windows debe contar con acceso a https://rules.emergingthreats.net/blockrules/compromised-ips.txt.
    2.- La cuenta de usuario que ejecute el script en powershell debe tener permisos de ejecución a netsh.exe y de 
        escritura en la ruta C:\Windows\Temp\.
    3.- Debe funcionar correctamente el Firewall de Windows.

### Recomendaciones:

    1.- Si el equipo Windows no forma de una red corporativa o doméstica en donde NO necesite publicar servicios
        (Ejemplo compartir archivos). Se recomienda Bloquear todas las conexiones entrantes (Que el origen sea externo) 
        y no solo la lista de orígenes maliciosos de la lista.
    2.- Siempre se puede borrar la política de forma manual a través de la aplicación Windows Firewall o vía netsh.exe
        de la forma netsh advfirewall firewall del rule name=**"NOMBRE_POLITICA"** via powershell.
    3.- Hay que entender que el funcionamiento de un firewall IP es poder comparar el origen y/o destino del tráfico con 
        o que uno le defina. Por lo cual es poco recomendable poner miles de IP, dado que al comparar todas las 
        comunicaciones con este listado bajara la performance del equipo.
    4.- La idea es poder tener una vía más de contención de emergencia y no reemplazar soluciones de seguridad 
        específicas que puedan en el endpoint o red.
    5.- Se puede automatizar vía PS remoto, GPO de AD, agentes que permitan ejecución de script ej: ossec, vRx 
        de Vicarius, etc. SE CREATIVO.!!!

### Próximos cambios y versiones:

    1.- Limitar regla de firewall a 500 ip por regla, creando múltiples reglas en caso de que el origen sea mayor a 500 
        direcciones.
    2.- Integracion con EDLManager para trabajo de multiples origenes y exposicion en una sola fuente.
    3.- Manejo de errores.
    4.- Creacion de archivo de log.
    5.- Creacion de funcion para revisar si existen los archivos antes de elimianrlos y/o crearlos.
    6.- Creacion de funcion para revisar si existen las reglas en el firewall de windows antes de eliminarlas y/o 
        crearlas.

Evidenicas:

1.- Politica de Bloqueo OUT por IP

![alt text](https://github.com/m4m00th/edlblock/blob/main/images/WinFW_Block_OUT_IP.png)


2.- Ambito Bloqueo OUT ANY por IP

![alt text](https://github.com/m4m00th/edlblock/blob/main/images/WinFW_Block_OUT_IP_ambito.png)


3.- Politica de Bloqueo IN ANY

![alt text](https://github.com/m4m00th/edlblock/blob/main/images/WinFW_Block_IN_all.png)


4.- Ambito Bloqueo IN ANY

![alt text](https://github.com/m4m00th/edlblock/blob/main/images/WinFW_Block_IN_all_ambito.png)



## **MacOS:**

    1.- Lanzamiento Proximamente



## **Linux:**

    1.- Lanzamiento Proximamente