$services_disable_list = @('AssignedAccessManagerSvc',
                           'tzautoupdate',
                           'BDESVC',
                           'BTAGService',
                           'bthserv',
                           'DiagTrack',
                           'DusmSvc',
                           'dmwappushservice',
                           'diagsvc',
                           'DPS',
                           'WdiServiceHost',
                           'WdiSystemHost',
                           'DialogBlockingService',
                           'lfsvc',
                           'diagnosticshub.standardcollector.service',
                           'AppVClient',
                           'MsKeyboardFilter',
                           'NetTcpPortSharing',
                           'ssh-agent',
                           'WpcMonSvc',
                           'RemoteRegistry',
                           'RemoteAccess',
                           'SensorService',
                           'shpamsvc',
                           'SQLBrowser',
                           'UevAgentService',
                           'WalletService',
                           'WbioSrvc',
                           'WerSvc',
                           'XboxGipSvc',
                           'XblAuthManager',
                           'XblGameSave',
                           'XboxNetApiSvc')


## 33
$services_disable = Get-Service -ServiceName $services_disable_list -ErrorAction SilentlyContinue | Select-Object -Property Name, StartType, Status

## 4
$google_services=Get-Service | Where-Object {($_.Name -like '*Google*'  )}

## 37 services to be disable

$services_manual=Get-Service -ServiceName @('MSSQLSERVER','SQLTELEMETRY','SQLWriter') -ErrorAction SilentlyContinue | Select-Object -Property Name, StartType, Status

foreach( $service in $services_disable){
Set-Service -Name $service.Name -StartupType Disabled
}

foreach( $service in $google_services){
Set-Service -Name $service.Name -StartupType Disabled
}

foreach($service in $services_manual){
Set-Service -Name $service.Name -StartupType Manual
} 





