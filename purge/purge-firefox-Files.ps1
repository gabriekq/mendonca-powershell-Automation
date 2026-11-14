

$fullFolderPurge='D:\bkpSistemaArquivos\bkp-gabriel\bkp-bookmark-firefox'


cd $fullFolderPurge

$filesList = dir -Filter '*.jsonlz4'

$filesCount =$filesList.Count

if($filesCount -gt 3){

$filesToBeRemovedCount = $filesCount -3


$filesRemoved = dir | Sort-Object -Property CreationTime | Select-Object -First $filesToBeRemovedCount

foreach($fileRemoved in $filesRemoved ){

Write-Host $fileRemoved+' will be removed'

Remove-Item $fullFolderPurge'\'$fileRemoved -Force

}


}