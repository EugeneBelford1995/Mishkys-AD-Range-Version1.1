netsh advfirewall firewall set rule group="Network Discovery" new enable=Yes

#Disable IPv6 
$NIC = (Get-NetAdapter).InterfaceAlias
Disable-NetAdapterBinding -InterfaceAlias $NIC -ComponentID ms_tcpip6

Install-WindowsFeature -Name "RSAT" -IncludeAllSubFeature
Rename-Computer -NewName "US-Client" -PassThru -Restart -Force