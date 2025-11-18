 <#
.SYNOPSIS
   This script enforces STIG control WN11-CC-000290 by configuring the system to ignore 
   unauthorized NetBIOS name release requests. It creates the required registry path if missing
   and sets NoNameReleaseOnDemand=1 to harden NetBIOS behavior and reduce exposure to spoofing attacks. Reboot required.

.NOTES
    Author          : Ernest Dicks
    LinkedIn        : linkedin.com/in/ernest-dicks/
    GitHub          : github.com/ernestdicks06
    Date Created    : 2025-11-18
    Last Modified   : 2025-11-18
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000290

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WWN11-CC-000290.ps1 
#>
<#
WN11-CC-000290 – Set RDS client connection encryption level to High
Sets MinEncryptionLevel = 3
#>

$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
$Name = "MinEncryptionLevel"
$Value = 3   # 3 = High

if (-not (Test-Path $Path)) {
    New-Item -Path $Path -Force | Out-Null
}

New-ItemProperty -Path $Path -Name $Name -Value $Value -PropertyType DWord -Force | Out-Null
Write-Host "WN11-CC-000290 applied: RDS encryption level set to High." -ForegroundColor Green
