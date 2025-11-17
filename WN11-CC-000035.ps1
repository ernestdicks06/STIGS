 <#
.SYNOPSIS
   This script enforces STIG control WN11-CC-000035 by configuring the system to ignore 
   unauthorized NetBIOS name release requests. It creates the required registry path if missing
   and sets NoNameReleaseOnDemand=1 to harden NetBIOS behavior and reduce exposure to spoofing attacks. Reboot required.

.NOTES
    Author          : Ernest Dicks
    LinkedIn        : linkedin.com/in/ernest-dicks/
    GitHub          : github.com/ernestdicks06
    Date Created    : 2025-11-17
    Last Modified   : 2025-11-17
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WWN11-CC-000035.ps1 
#>

# Run in PowerShell ISE as Administrator

Write-Host "Applying STIG Fix: WN11-CC-000035" -ForegroundColor Cyan
Write-Host "Setting NoNameReleaseOnDemand = 1 (ignore NetBIOS name-release requests)" -ForegroundColor Cyan

$regPath = 'HKLM:\SYSTEM\CurrentControlSet\Services\NetBT\Parameters'

# Make sure the key exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set NoNameReleaseOnDemand to 1
Set-ItemProperty -Path $regPath -Name 'NoNameReleaseOnDemand' -Type DWord -Value 1

Write-Host ""
Write-Host "STIG remediation complete for WN11-CC-000035." -ForegroundColor Green
Write-Host "You should reboot for the change to fully apply." -ForegroundColor Yellow
