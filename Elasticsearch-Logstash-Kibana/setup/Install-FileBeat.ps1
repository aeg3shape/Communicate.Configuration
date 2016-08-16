$installfolder = "Filebeat2"
$fullpath = "c:\" + $installfolder
$serviceFolder = $fullpath + "\service"
$unzippedpath = $fullpath + "\filebeat-1.2.3-windows\*.*"
$logPath = $serviceFolder + "\logs"
$dataPath = $fullpath + "\data"

function Invoke-VerifyAdministrativePrivileges 
{
    If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
    { 
        Write-Host "You need to run the script as Administrator!" -ForegroundColor Red
        Read-Host "Exiting (Press enter to continue)..." 
        exit
    }
}

function Install-FilebeatService
{
    Write-Host -ForegroundColor Green "Installing filebeat service..."
    
    $ps1path = $serviceFolder + "\install-service-filebeat.ps1"
    invoke-expression -Command "& '$ps1path'"
    Start-Service -Name "Filebeat"
    
    Write-Host -ForegroundColor Green "Installation complete"
}

function New-FilebeatFolders 
{
    Write-Host -ForegroundColor Green "Creating filebeat fodlers..."
    new-item $serviceFolder -type directory -Force
    new-item $logPath -type directory -Force
    new-item $dataPath -type directory -Force
}

function Get-Filebeat
{

    Write-Host -ForegroundColor Green "Downloading Filebeat..."
    (New-Object Net.WebClient).DownloadFile('https://download.elastic.co/beats/filebeat/filebeat-1.2.3-windows.zip', $fullpath + '\filebeat.zip');
    
    Write-Host -ForegroundColor Green "Unzipping Filebeat..."
    $shell = new-object -com shell.application
    $zip = $shell.NameSpace($fullpath + "\filebeat.zip")
    foreach($item in $zip.items())
    {
        $shell.Namespace($fullpath).copyhere($item)
    }
    Copy-Item $unzippedpath $serviceFolder
    
    Write-Host -ForegroundColor Green "Clean up temporary files..."
    Remove-Item ($fullpath + "\filebeat.zip")
    Remove-Item ($fullpath + "\filebeat-1.2.3-windows") -recurse
}

Invoke-VerifyAdministrativePrivileges

if (-Not(Test-Path $fullpath))
{    
    New-FilebeatFolders
    Get-Filebeat
    Install-FilebeatService
}






