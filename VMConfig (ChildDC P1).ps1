netsh advfirewall firewall set rule group="Network Discovery" new enable=Yes
$NIC = (Get-NetAdapter).InterfaceAlias

#Disable IPv6 
Disable-NetAdapterBinding -InterfaceAlias $NIC -ComponentID ms_tcpip6

Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
Rename-Computer -NewName "US-DC" -PassThru -Restart -Force