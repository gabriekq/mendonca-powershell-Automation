
$services_sql=Get-Service -ServiceName @('MSSQLSERVER','SQLTELEMETRY','SQLWriter') -ErrorAction SilentlyContinue | Select-Object -Property Name, DisplayName

foreach($service in $services_sql ){

$DisplayName = $service.DisplayName
Write-Host 'starting service '$DisplayName
Start-Service -Name $service.Name

}

cmd.exe /c "C:\Program Files (x86)\Microsoft SQL Server Management Studio 18\Common7\IDE\Ssms.exe"


foreach($service in $services_sql){

$DisplayName = $service.DisplayName
Write-Host 'stopping service '$DisplayName
Stop-Service -Name $service.Name
}

