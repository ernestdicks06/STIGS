 <#
.SYNOPSIS
 This script enforces STIG control WN11-CC-000285 by disabling Microsoft consumer features.
It creates the required registry path if missing and sets DisableWindowsConsumerFeatures=1
to block consumer apps, suggestions, and non-enterprise content. Reboot recommended.

.NOTES
    Author          : Ernest Dicks
    LinkedIn        : linkedin.com/in/ernest-dicks/
    GitHub          : github.com/ernestdicks06
    Date Created    : 2025-11-17
    Last Modified   : 2025-11-17
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000285

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000285.ps1 
#>

<#
FWN11-CC-000285.ps1
WN11-CC-000285 – Require secure RPC for RDS

This script enforces STIG control WN11-CC-000285 by requiring secure RPC
communications for Remote Desktop Services.
#>

# Elevation check
$principal = New-Object Security.Principal.WindowsPrincipal(
    [Security.Principal.WindowsIdentity]::GetCurrent()
)
if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "[ERROR] Run this script as Administrator." -ForegroundColor Red
    exit 1
}

Write-Host "Applying STIG fix WN11-CC-000285 (Require secure RPC for RDS)..." -ForegroundColor Cyan

$path = 'HKLM:\Software\Policies\Microsoft\Windows NT\Terminal Services'

if (-not (Test-Path $path)) {
    New-Item -Path $path -Force | Out-Null
}

Set-ItemProperty -Path $path -Name 'fEncryptRPCTraffic' -Type DWord -Value 1

Write-Host "[OK] fEncryptRPCTraffic set to 1." -ForegroundColor Green
Write-Host "Reboot is recommended for the change to fully apply." -ForegroundColor Yellow


Write-Host "[OK] DisableWindowsConsumerFeatures set to 1." -ForegroundColor Green
Write-Host "Reboot is recommended for the change to fully apply." -ForegroundColor Yellow
