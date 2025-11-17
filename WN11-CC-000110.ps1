 <#
.SYNOPSIS
This script enforces STIG control WN11-CC-000110 by disabling HTTP-based printing.
It creates the required registry path if missing and sets DisableHTTPPrinting=1
to prevent insecure HTTP printing and reduce exposure to spoofing attacks.
Reboot recommended.

.NOTES
    Author          : Ernest Dicks
    LinkedIn        : linkedin.com/in/ernest-dicks/
    GitHub          : github.com/ernestdicks06
    Date Created    : 2025-11-17
    Last Modified   : 2025-11-17
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000110

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000110.ps1 
#>

<#

WN11-CC-000110 – Disable HTTP printing
This script enforces STIG control WN11-CC-000110 by disabling HTTP-based printing.

#>

# Elevation check
$principal = New-Object Security.Principal.WindowsPrincipal(
    [Security.Principal.WindowsIdentity]::GetCurrent()
)
if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "[ERROR] Run this script as Administrator." -ForegroundColor Red
    exit 1
}

Write-Host "Applying STIG fix WN11-CC-000110 (Disable HTTP printing)..." -ForegroundColor Cyan

$path = 'HKLM:\Software\Policies\Microsoft\Windows NT\Printers'

if (-not (Test-Path $path)) {
    New-Item -Path $path -Force | Out-Null
}

Set-ItemProperty -Path $path -Name 'DisableHTTPPrinting' -Type DWord -Value 1

Write-Host "[OK] DisableHTTPPrinting set to 1." -ForegroundColor Green
Write-Host "Reboot is recommended for the change to fully apply." -ForegroundColor Yellow

 
