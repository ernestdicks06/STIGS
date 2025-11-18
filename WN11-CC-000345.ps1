 <#
.SYNOPSIS
  This script enforces STIG control WN11-CC-000345 by disabling Basic 
  authentication for WinRM. It sets AllowBasic=0 to prevent unencrypted 
  credentials from being sent over the network.

.NOTES
    Author          : Ernest Dicks
    LinkedIn        : linkedin.com/in/ernest-dicks/
    GitHub          : github.com/ernestdicks06
    Date Created    : 2025-11-18
    Last Modified   : 2025-11-18
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000345

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WWN11-CC-000345.ps1 
#>
<#
WN11-CC-000345 – Disable Basic auth for WinRM Service
Sets AllowBasic = 0
#>

$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service"
$Name = "AllowBasic"
$Value = 0

if (-not (Test-Path $Path)) {
    New-Item -Path $Path -Force | Out-Null
}

New-ItemProperty -Path $Path -Name $Name -Value $Value -PropertyType DWord -Force | Out-Null
Write-Host "WN11-CC-000345 applied: WinRM Basic authentication disabled." -ForegroundColor Green

Write-Host ""
Write-Host "STIG remediation complete for WN11-CC-000035." -ForegroundColor Green
Write-Host "You should reboot for the change to fully apply." -ForegroundColor Yellow
