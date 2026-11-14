$baseFolder='C:\Users\'

$currentUser=$env:USERNAME

$firefoxPath='\AppData\Roaming\Mozilla\Firefox\Profiles'

$firefoxBkpFolder = $baseFolder+$currentUser+$firefoxPath

$targetFolder = 'D:\bkpSistemaArquivos\bkp-gabriel\bkp-bookmark-firefox'

$installPrograms = Get-ItemProperty -Path "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*", "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*", "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" |where { $_.DisplayName -ne $null } | Select-Object DisplayName, DisplayVersion, InstallDate | Sort-Object -Property DisplayName -Unique

$programFound=$installPrograms | Select-Object DisplayName |  Select-String  -Pattern 'Firefox' | Select-Object -First 1 

if($programFound.Line.Length -eq 0 ){
      Break
}



function create-sub-Folder{
param($folder,$folderName)


New-Item -Path $folder -Name $folderName -ItemType Directory -Force

}

function exist-Path ($folderParam){
  Write-Host 'checking path'
 if(Test-Path -Path $folderParam ){

    
    return $true

  }else{
  
    return $false
  }

}


$returnTestFolder =exist-Path ($targetFolder) 

if($returnTestFolder -eq $false){
 Write-Host 'Folder does not exist'
 cd 'D:\bkpSistemaArquivos\bkp-gabriel'
 create-sub-Folder('D:\bkpSistemaArquivos\bkp-gabriel','bkp-bookmark-firefox')
}

##

cd $targetFolder
$countFiles = dir 

Write-Host 'Files on the targetFolder -> '  $countFiles.Count



cd $firefoxBkpFolder

$firefoxFolderName = dir | Sort-Object -Property LastWriteTime -Descending | Select-Object -Property Name -First 1


$bkpFolderSource = $firefoxBkpFolder+'\'+$firefoxFolderName.Name+'\bookmarkbackups'

cd $bkpFolderSource

$recentFilesSource = dir | Sort-Object -Property LastWriteTime -Descending | Select-Object -Property Name -First 3 

Write-Host $bkpFolderSource

foreach($fileCopy in $recentFilesSource){



Write-Host 'Source' $bkpFolderSource
Write-Host 'Destination' $targetFolder

robocopy $bkpFolderSource $targetFolder $fileCopy.Name

}

