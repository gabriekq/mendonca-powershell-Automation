
$currentUserFolder = $env:USERNAME

$userFolder = '\Users\'

$pathScheduledTask =  $userFolder + $currentUserFolder

## One note script

$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-file D:\Programacao\Power-shell\bkp\script-bkpOnote-files.ps1'

$trigger = New-ScheduledTaskTrigger -Weekly -At 9:20:00am -DaysOfWeek Monday, Friday

$config = New-ScheduledTaskSettingsSet -StartWhenAvailable -Compatibility Win8 -DontStopOnIdleEnd -ExecutionTimeLimit (New-TimeSpan -Hours 1) -Hidden 

Register-ScheduledTask -Action $action -Trigger $trigger -Settings $config -TaskName 'BkpOneNote-files' -Description 'one note bkp script' -TaskPath $pathScheduledTask

#Firefox

$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-file D:\Programacao\Power-shell\bkp\script-bkpFirefox-files.ps1'

$trigger = New-ScheduledTaskTrigger -Weekly -At 1:15:00pm -DaysOfWeek Wednesday, Saturday 

$config = New-ScheduledTaskSettingsSet -StartWhenAvailable -Compatibility Win8 -DontStopOnIdleEnd -ExecutionTimeLimit (New-TimeSpan -Hours 1) -Hidden


Register-ScheduledTask -Action $action -Trigger $trigger -Settings $config -TaskName 'bkpFirefox-files' -Description 'Firefox bkp script' -TaskPath $pathScheduledTask


# Purge data 

$actionPurgeFirefox = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-file D:\Programacao\Power-shell\purge\purge-firefox-Files.ps1'

$actionPurgeOneNote = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-file D:\Programacao\Power-shell\purge\purge-onote-Files.ps1' 

$trigger = New-ScheduledTaskTrigger -Weekly -WeeksInterval 5 -DaysOfWeek Sunday -At 3pm


$config = New-ScheduledTaskSettingsSet -StartWhenAvailable -Compatibility Win8 -DontStopOnIdleEnd -ExecutionTimeLimit (New-TimeSpan -Hours 1) -Hidden

$actions = @($actionPurgeFirefox,$actionPurgeOneNote)

Register-ScheduledTask -Action $actions -Trigger $trigger -Settings $config -TaskName 'Purge-files' -Description 'Purge bkp files' -TaskPath $pathScheduledTask



