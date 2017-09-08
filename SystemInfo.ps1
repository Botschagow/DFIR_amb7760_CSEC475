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

# Lines 30 to 40 will get hardware
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

# Lines 43 to 44 will get domain info
Write-Host "Listing Host Names and Domain: "
Get-CimInstance Win32_ComputerSystem | select-object Name,PrimaryOwnerContact,UserName,Description,DNSHostName,Domain,workgroup,Manufacturer,Model,SystemFamily,SystemSKUNumber,SystemType,TotalPhysicalMemory

# Lines 46 to 48 will get user info
Write-Host "Listing User Info: "
Get-LocalUser | select-object Name,ObjectClass,PrincipleSource,LastLogon,PasswordRequired,PasswordLastSet,FullName,Description,SID,Enabled

# Lines 51 to 52 will get user event log info
Write-Host "UserEventLog: "
Get-EventLog -ComputerName "." System -Source Microsoft-Windows-Winlogon

# Lines 55 to 56 will get startup programs
Write-Host "Startup Programs: "
Get-CimInstance Win32_StartupCommand | select-object Name,User,Caption,UserSID,Location

# Lines 59 to 60 will get scheduled tasks
Write-Host "Scheduled Tasks: "
Get-ScheduledTask | select Author,TaskName,Date,State,TaskPath,Triggers,Actions

# Lines 63 to 64 will get network info
Write-Host "Network Information: "
Get-NetAdapterHardwareInfo | Select Name,ifDesc,Bus,Device,Slot,Caption,Description,InterfaceDescription,SystemName,SlotNumber

# Lines 67 to 68 will get network config of system 
Get-CimInstance Win32_NetworkAdapterConfiguration | select MACAddress,IPAddress,DHCPLEaseObtained,DHCPLeaseExpires,DHCPServer,DNSDomain,Description,DefaultGateway

# Lines 70 to 71 will get DNS cache info
Write-Host "DNS Cache Information: "
Get-DnsClientCache | select Name,Entry,Data,Section

# Lines 74 to 75 will get printer info
Write-Host "Printer Information: "
Get-Printer | Select Name,PrinterStatus,Type,DeviceType,DataType,DriverName,PortName,PrintProcessor

# Lines 78 to 79 will get list of software
Write-Host "List Of Software: "
Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate

# Lines 81 to 83 will get process list 
Write-Host "Process' List: "
Get-Process | select processname,path,id

# Lines 86 to 87 will get driverlist
Write-Host "DriverList: "
Get-WmiObject Win32_PnpSignedDriver | select DeviceName,DriverVersion,Manufacturer
 