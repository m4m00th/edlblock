# TODO SE PUEDE OPTIMIZAR LO MOSTRAMOS PASO A PASO PARA QUE CUALQUIERA LO LOGRE ENTENDER
# Incluso creamos archivos de paso

# Dirección de la lista a utilizar
$url = "https://rules.emergingthreats.net/blockrules/compromised-ips.txt"

# user y password en caso de que la lista esta expuesta en un servidor con autenticacion basica http.
# $user = ""
# $password = ""

# Definicion de archivos temporales.
$archivoEntrada= "C:\Windows\Temp\iocipv4_temp01"
$archivoSalida = "C:\Windows\Temp\iocipv4_temp02"
$archivoFinal = "C:\Windows\Temp\iocipv4.txt"

# Creando el cliente web
$webclient = New-Object System.Net.WebClient

# Basic authentication encoding.
# $basic = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($user + ":" + $password));

# Seteo de información Authorization HTTP header con Basic authentication.
# $webclient.Headers["Authorization"] = "Basic $basic"

# Exportar el contenido a un archivo temporal.
$webclient.DownloadFile($url, $archivoEntrada)

# Lee todas las líneas del archivo original
$lineas = Get-Content $archivoEntrada
# Une las líneas separadas por comas
$lineaUnica = $lineas -join ','

# Escribe el resultado en el archivo de salida
Set-Content $archivoSalida -Value $lineaUnica

# Borrando caracteres en Blanco en caso de que existan
(Get-Content -Path $archivoSalida) -replace '\s+', '' | Set-Content -Path $archivoFinal

# Borrando archivos temporales
Remove-Item $archivoEntrada
Remove-Item $archivoSalida

# Aplicando politicas
$IoC = Get-content -Path $archivoFinal

# Bloquea conexiones de salida hacia los destinos maliciosos de la lista en firewall de windows.
netsh advfirewall firewall del rule name="01-RuleOutBlockIPList"
netsh advfirewall firewall add rule name="01-RuleOutBlockIPList" dir=out interface=any action=block remoteip=$IoC

# OJO!!!!! Bloquea conexiones de entrada de cualquier IP de origen en firewall de windows.
netsh advfirewall firewall del rule name="01-RuleInBlockAny"
netsh advfirewall firewall add rule name="01-RuleInBlockAny" dir=in interface=any action=block remoteip=any

# Bloquea conexiones de entrada solo de las IP origen de la lista .
# netsh advfirewall firewall del rule name="01-RuleInBlockIPList"
# netsh advfirewall firewall add rule name="01-RuleInBlockIPList" dir=in interface=any action=block remoteip=$IoC

# Borrando archivo final
Remove-Item $archivoFinal