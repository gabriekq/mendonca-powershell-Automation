

$pathDownloads=  'C:\Users\'+$env:USERNAME+'\Downloads'
$pathDesktop='C:\Users\'+$env:USERNAME+'\Desktop'

Add-MpPreference -ExclusionPath 'C:\Programas'
Add-MpPreference -ExclusionPath  $pathDownloads
Add-MpPreference -ExclusionPath 'D:\Multimidia\Pacotes de Instalacao'
Add-MpPreference -ExclusionPath 'D:\Programacao'
Add-MpPreference -ExclusionPath 'D:\programas'


Set-MpPreference -EnableControlledFolderAccess Enabled

Add-MpPreference -ControlledFolderAccessProtectedFolders 'D:\Multimidia'
Add-MpPreference -ControlledFolderAccessProtectedFolders $pathDesktop
Add-MpPreference -ControlledFolderAccessProtectedFolders 'C:\Programas'

Get-MpPreference | Select-Object -Property ExclusionPath -ExpandProperty ExclusionPath


## Remove-MpPreference -ExclusionPath 'D:\fouder' remove preferences of the windows defender



