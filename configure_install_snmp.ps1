########################################################################
# Author: jmutkawoa@gmail.com

########################################################################

#Check if SNMP-Service is already installed
$check = Get-WindowsFeature -Name SNMP-Service

If ($check.Installed -ne "True") {

#Installing and Enablig SNMP-SERVICE HERE.....

Write-Host "SNMP Service Installing..."
Get-WindowsFeature -Name *snmp* | Install-WindowsFeature  | Out-Null
}
 
New-ItemProperty -Path 'hklm:\SYSTEM\CurrentControlSet\services\SNMP\Parameters\ValidCommunities' -Name "public" -PropertyType Dword -Value 4

New-ItemProperty -Path 'hklm:\SYSTEM\CurrentControlSet\services\SNMP\Parameters\PermittedManagers' -Name "2"  -Value "10.1.1.1"

Restart-Service -Name SNMP 
