#Get the VM's default GW: (Get-NetIPConfiguration -InterfaceAlias "vEthernet (Testing)").IPv4DefaultGateway.NextHop
#Get the VM's current IP: (Get-NetIPConfiguration -InterfaceAlias "vEthernet (Testing)").IPv4Address.IPAddress

#Disable IPv6
$NIC = (Get-NetIPConfiguration).InterfaceAlias
Disable-NetAdapterBinding -InterfaceAlias $NIC -ComponentID ms_tcpip6

$DC_GW = (Get-NetIPConfiguration -InterfaceAlias (Get-NetAdapter).InterfaceAlias).IPv4DefaultGateway.NextHop
$DC_IP = (Get-NetIPAddress | Where-Object {$_.InterfaceAlias -eq"$NIC"}).IPAddress
$DC_Prefix = (Get-NetIPAddress | Where-Object {$_.InterfaceAlias -eq"$NIC"}).PrefixLength

$FirstOctet =  $DC_IP.Split("\.")[0]
$SecondOctet = $DC_IP.Split("\.")[1]
$ThirdOctet = $DC_IP.Split("\.")[2]
$NetworkPortion = "$FirstOctet.$SecondOctet.$ThirdOctet"
$Gateway = $DC_GW
#$NIC = (Get-NetAdapter).InterfaceAlias
$IP = "$NetworkPortion.140"

If($FirstOctet -eq "169")
{
$NetworkPortion = "192.168.0"
$IP = "192.168.0.140"
$DC_Prefix = "24"
}

#Set IPv4 address, gateway, & DNS servers
New-NetIPAddress -InterfaceAlias $NIC -AddressFamily IPv4 -IPAddress $IP -PrefixLength $DC_Prefix -DefaultGateway $Gateway
Set-DNSClientServerAddress -InterfaceAlias $NIC -ServerAddresses ("$NetworkPortion.140", "$NetworkPortion.141", "$NetworkPortion.145", "1.1.1.1", "8.8.8.8")

netsh advfirewall firewall set rule group="Network Discovery" new enable=Yes
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
Rename-Computer -NewName "Lab-DC" -PassThru -Restart -Force