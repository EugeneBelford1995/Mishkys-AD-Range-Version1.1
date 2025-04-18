﻿$osInfo = Get-ComputerInfo 
if ($osInfo.OsName -like "*Server*") 
{
Write-Output "Setting up Hyper-V and a vSW on Windows Server"
Install-WindowsFeature -Name Hyper-V -IncludeManagementTools
New-VMSwitch -Name "Testing" -NetAdapterName "Ethernet" ; Set-VMSwitch -Name Testing -AllowManagementOS $true
}
else 
{
Write-Output "Setting up Hyper-V and using the Default Switc on Windows 10"
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
}

New-Item C:\VM_Stuff_Share\Lab -ItemType Directory
New-Item C:\VM_Stuff_Share\ISOs -ItemType Directory
Write-Host "Grab a x64 ISO from https://www.microsoft.com/en-us/evalcenter/download-windows-server-2022 and save it in the ISOs folder."
Invoke-WebRequest -Uri "https://software-static.download.prss.microsoft.com/sg/download/888969d5-f34g-4e03-ac9d-1f9786c66749/SERVER_EVAL_x64FRE_en-us.iso" -OutFile "Windows Server 2022 (20348.169.210806-2348.fe_release_svc_refresh_SERVER_EVAL_x64FRE_en-us).iso"
Install-Module -Name Convert-WindowsImage

Write-Host "If the above fails to install Convert-WindowsImage then download it from https://github.com/x0nn/Convert-WindowsImage"
Write-Host "Save it in C:\VM_Stuff_Share\Convert-WindowsImage (from PS Gallery)"