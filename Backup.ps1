<# 
Title: System Image Backup
Author: Luke Hagerdon
Created: 6.28.2019
Description: The script was made to create a backup and share it to a server's shared folder. You will have to set a unique shared
             folder path and enter the credentials for the shared computer. Once information is entered, you are set. For a daily backup
             create a new scheduled task which includes the path to this file.
#>

# Variables
$backupFolder = "\\serverName\Test Backup"
$newDir = $env:COMPUTERNAME + " Backup"
$serverIP = 0.0.0.0

function waitForConnection{
    do {
     $ping = test-connection -comp $serverIP -count 1 -Quiet
    } until ($ping)
    Write-Host "You are connected to the network"
    startBackup
}

function startBackup{
    # Logs into the network folder
    net use $backupFolder /user:$username $password

    # Navigates to the shared directory
    Set-Location $backupFolder

    # If a folder with that computer name does not exist it creates a new one
    # and if there is a folder with that name, it changes its directory to that

    if(!(Test-Path -Path $newDir)){
        Write-Host "New Folder Created: " $newDir -ForegroundColor Green
        mkdir $newDir
    } else {
        Write-Host "No New Folder Created" -ForegroundColor Yellow
    }

    Set-Location $newDir
    #wbAdmin start backup -backupTarget:$newDir -include:C: -allCritical -quiet
}

<#
    - Make an automatic emailing whenever backup has completed
    - Make it automatically scheduling
    - Store server username and password securely 
#>