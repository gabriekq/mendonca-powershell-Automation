

$folder = "D:\bkpSistemaArquivos\"
$folderName = 'bkp-gabriel'

$fullFolder=$folder+$folderName

Stop-Process -Name 'ONENOTE' -ErrorAction SilentlyContinue -Force
Start-Sleep -Seconds 1.5



function check-folderOpend{

$objShell = New-Object -ComObject "Shell.Application"

$windowOpendCount = $objShell.Application.Windows().Count

for($index=0; $index -lt $windowOpendCount; $index++  ){
 
   $currenWindow = $objShell.Application.Windows()[$index].LocationURL

  if( $currenWindow.Contains('bkp-gabriel') -and $currenWindow.Contains('bkpSistemaArquivos')  ){
     Write-Host "this window needs to be closed "$currenWindow
     $objShell.Application.Windows()[$index].Quit() 
     Start-Sleep -Seconds 0.5

  }

    
}

$objShell =$null 

}

function exist-Path ($folderParam){

 if(Test-Path -Path $folderParam ){

    return [bool]1

  }else{
    return [bool]0
  }

}

function create-sub-Folder{
param($folder,$folderName)


New-Item -Path $folder -Name $folderName -ItemType Directory -Force

}

function get-count-Files{
param($fileTypeParam)

$count = dir -Filter $fileTypeParam

return $count.Count 

}


function export-oneNote{

Write-Host 'export-oneNote'

cd $fullFolder

$OneNote = New-Object -ComObject OneNote.Application

[xml]$Hierarchy = ""
$OneNote.GetHierarchy("",[Microsoft.Office.Interop.OneNote.HierarchyScope]::hsPages, [ref]$Hierarchy)
Start-Sleep -Seconds 0.3
    $oneNoteID=$Hierarchy.Notebooks.ChildNodes[0].ID
    $countFileType=get-count-Files('*.onepkg')

    if($countFileType -eq 0  ){ 
      $Name = $Hierarchy.Notebooks.ChildNodes[0].name
    }else{
       $Name=get-newFile-Name
       
    }
     
    
    Write-Host "Exporting Notebook:" $Name

    # onepkg
    $OnepkgPath = Join-Path -Path $fullFolder -ChildPath "$($Name).onepkg"
    Start-Sleep -Seconds 0.3
    $OneNote.Publish($oneNoteID, $OnepkgPath, 1, "") 
 
}



function get-newFile-Name{

cd $fullFolder
 #dir
$onoteFiles = dir -Filter *.onepkg | Sort-Object -Property LastWriteTime -Descending | Select-Object -First 1

 $versionNumber=$onoteFiles[0].Name.Split('-')[2].Split('.')[0]
 $versionNumber = [long]$versionNumber + 1L

 if($versionNumber -gt 99990){
   $versionNumber = 1L
 }

 $currentYear = Get-Date -Format 'yyyy'

 return 'BKP-'+$currentYear+'-'+$versionNumber

}

[System.GC]::Collect()
[System.GC]::WaitForPendingFinalizers()

check-folderOpend

if(exist-Path($fullFolder) -is [bool]1  ){

 Write-Host 'Folder exist'

   $nameNewFile=export-oneNote
}else{

  Write-Host 'Folder does not exist!!'
  Write-Host 'creating Folder'
  cd $folder
  create-sub-Folder($folder,$folderName)
   $nameNewFile=export-oneNote
  
}

$oneNoteProcess= Get-Process -Name 'ONENOTE' ##| Select-Object Id , 


$oneNoteProcess.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::High

Wait-Process -Id $oneNoteProcess.Id -Timeout 240 -ErrorAction Stop

$oneNoteProcess.WaitForExit()



Write-Host 'Done'
