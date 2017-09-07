# Script to get system infortation
# By Andrew Botschagow

# Lines 5 to 19 will deal with getting time info
Write-Host "Time:"
# Will get and print current time
$CurrentTime = Get-Date
$DisplayTime = "Current Time: " + $CurrentTime
$DisplayTime

# Will display time zone
$TimeZone = Get-TimeZone
Write-Host "Time Zone: " $TimeZone.Id

# Will display uptime of machine
$os = Get-WmiObject win32_operatingsystem
$uptime = (Get-Date) - ($os.ConvertToDateTime($os.lastbootuptime))
$Display = "Uptime: " + $Uptime.Days + " days, " + $Uptime.Hours + " hours, " + $Uptime.Minutes + " minutes"
$Display

# Lines 23 to 29 will get Windows Version

Write-Host `n
Write-Host "Windows Version:"
$winver = [System.Environment]::OSVersion.Version.Major
Write-Host "Windows" $winver
[System.Environment]::OSVersion.Version

# Lines 30 to 0 will get hardware
Write-Host `n
Write-Host "System Hardware Specs:"

$Hardware = Get-WmiObject -Class Win32_Processor 
Write-Host "CPU: " $Hardware.Name
$PhysicalRAM = (Get-WMIObject -class Win32_PhysicalMemory |Measure-Object -Property capacity -Sum | % {[Math]::Round(($_.sum / 1GB),2)})
Write-Host "Installed Ram: " $PhysicalRAM
$hhdsize = gwmi win32_logicaldisk
Write-Host "Hard Drive Size: " $hhdsize.size
Write-Host "Listing Hard Drives and Filesystems: "
Get-PSDrive
Get-CimInstance Win32_ComputerSystem | select-object Name,PrimaryOwnerContact,UserName,Description,DNSHostName,Domain,workgroup,Manufacturer,Model,SystemFamily,SystemSKUNumber,SystemType,TotalPhysicalMemory 