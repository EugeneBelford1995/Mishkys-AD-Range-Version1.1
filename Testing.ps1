$ADRoot = (Get-ADDomain).DistinguishedName
$FQDN = (Get-ADDomain).DNSRoot

#Test how to see if a VMSwitch exists already
Function Find-SW
{
$Test = Get-VMSwitch | Where-Object {$_.Name -eq "X"}
If($Test -eq "$null")
{"Switch doesn't exist!"}
Else{Write-Host "SW exists"}
}

#Test if a function can use a variable that's outside of it. Workds :)
Function Find-Info
{$ADRoot ; $FQDN}