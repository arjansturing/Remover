<# Remover.ps1

Powershell script for removing files in selected folder and in chosen subfolders based on pattern.
By: Arjan Sturing

Automate the World! #PowerShell

#>
Clear-Host
Function Banner {
Write-Host "RRRRRR  EEEEEEE MM    MM  OOOOO  VV     VV EEEEEEE RRRRRR"   -ForegroundColor Red
Write-Host "RR   RR EE      MMM  MMM OO   OO VV     VV EE      RR   RR"  -ForegroundColor Red
Write-Host "RRRRRR  EEEEE   MM MM MM OO   OO  VV   VV  EEEEE   RRRRRR  " -ForegroundColor Red
Write-Host "RR  RR  EE      MM    MM OO   OO   VV VV   EE      RR  RR  " -ForegroundColor Red
Write-Host "RR   RR EEEEEEE MM    MM  OOOO0     VVV    EEEEEEE RR   RR " -ForegroundColor Red
Write-Host ""
Write-Host "Remove files in folder and subfolders based on pattern and age of files" -ForegroundColor Yellow
Write-Host "By: Arjan Sturing" -ForegroundColor Yellow
Write-Host ""                                                           
}
Banner
Write-Host "Choose directory" -ForegroundColor Green
Add-Type -AssemblyName System.Windows.Forms
$SourceFolder = New-Object System.Windows.Forms.FolderBrowserDialog
[void]$SourceFolder.ShowDialog()
Clear-Host
$Pattern = Read-Host "Enter filename pattern"
$Days = Read-Host "Enter maximum age of file in days"
$choicerecurse = Read-Host "Do you want to include subfolders? y/n"


If ($choicerecurse -eq "y"){
$command = Get-ChildItem -Path $SourceFolder.SelectedPath -Filter "*$Pattern*" -Recurse | Where {$_.LastWriteTime -gt (Get-Date).AddDays(-$days)}
}
Else {$command = Get-ChildItem -Path $SourceFolder.SelectedPath -Filter "*$Pattern*" | Where {$_.LastWriteTime -gt (Get-Date).AddDays(-$days)}
}
Clear-Host
$command | Remove-Item -WhatIf


$choiceremove = Read-Host "Are you sure you want to remove the mentioned files? y/n"

If ($choiceremove -eq "y"){
Clear-Host
$command | Remove-Item
Clear-Host
Write-Host "Files with $Pattern in filename are removed!" -ForegroundColor Red
Start-Sleep 10
Clear-Host
Exit}
Else {
Clear-Host
Write-Host "Files with $Pattern in filename are not removed!" -ForegroundColor Red
Start-Sleep 10
Clear-Host
Exit}
