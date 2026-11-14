

$folder = "D:\bkpSistemaArquivos\"
$folderName = 'bkp-gabriel'

$fullFolder=$folder+$folderName


function get-Files-Delete{
param($filesToRemoveParam)

$filesRemoved =dir -Filter *.onepkg | Sort-Object -Property LastWriteTime | Select-Object -First $filesToRemoveParam

foreach($file in $filesRemoved){
 
 Write-Host  $file+' will be deleted'
 Remove-Item $fullFolder'\'$file -Force
 

}



}


cd $fullFolder


$oneNoteCountFiles = dir -Filter *.onepkg
$NumberFiles =$oneNoteCountFiles.Count


if($NumberFiles -gt 3){

$filesToRemoveCount = $NumberFiles - 3

get-Files-Delete($filesToRemoveCount)



}