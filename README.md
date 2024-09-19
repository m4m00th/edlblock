# edlblock

La idea es simple, teniendo de fuente una lista dinamica externa de direciones IP (EDL) 
publica o privada (en este caso se necesitaria claves de logueo) se puedan bloquear en 
un equipo endpoint Windows (Proximamente MacOS y Linux)

El proceso sera:

Windows:

1- Acceder a la lista.
2- Trabajar el archivo via Powershell.
3- Bloquer en firewall de Windows equipo via netsh.exe

A modo de ejemplo usararemos la lista libre
https://rules.emergingthreats.net/blockrules/compromised-ips.txt

Requistos:

1- El equipo Windows debe contar con acceso a https://rules.emergingthreats.net/blockrules/compromised-ips.txt
2- La cuenta de usuario que ejecute el script en powershell debe tener permisos de ejecucion a netsh.exe

Recomendaciones.

Si el equipo Windows no forma de una red coorporativa o domestica en donde NO necesite publicasr servicios (Ejemplo compartir archivos)
Se recomienda Bloquear todas las conexiones entrantes (Que el origen sea externo) y no solo la lista de origenes mailiciosos de la lista.