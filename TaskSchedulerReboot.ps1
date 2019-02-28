hostname = hostname

Start-Transcript -path C:\OBS_Workdesk\$hostname -append
date
Stop-Transcript
ipmo ScheduledTasks 

$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-NoProfile -WindowStyle Hidden -command "$hostname = hostname ; Get-Date | out-file -FilePath C:\OBS_Workdesk\$hostname ; Get-Service | Out-File -FilePath C:\OBS_Workdesk\$hostname -Append ; shutdown -r -t 1"' 

$trigger =  New-ScheduledTaskTrigger -Weekly -DaysOfWeek Tuesday -At 01:00am

$stp = New-ScheduledTaskPrincipal -UserId "SYSTEM" -RunLevel Highest -LogonType ServiceAccount

Register-ScheduledTask -Action $action -principal $stp -Trigger $trigger -TaskName "WeeklyReboot" -Description "Weekly reboot by Ansible" 
