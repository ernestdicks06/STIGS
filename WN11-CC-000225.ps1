 <#
.SYNOPSIS
  This script enforces STIG control WN11-CC-000225 by enabling File 
  Explorer’s shell protocol protected mode. It sets PreXPSP2ShellProtocolBehavior=0 to 
  ensure older, unsafe shell protocol behavior is blocked.

.NOTES
    Author          : Ernest Dicks
    LinkedIn        : linkedin.com/in/ernest-dicks/
    GitHub          : github.com/ernestdicks06
    Date Created    : 2025-11-18
    Last Modified   : 2025-11-18
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000225

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000225.ps1 
#>

<#
WN11-CC-000225 – Enable File Explorer shell protocol protected mode
Sets PreXPSP2ShellProtocolBehavior = 0
#>

$Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
$Name = "PreXPSP2ShellProtocolBehavior"
$Value = 0

if (-not (Test-Path $Path)) {
    New-Item -Path $Path -Force | Out-Null
}

New-ItemProperty -Path $Path -Name $Name -Value $Value -PropertyType DWord -Force | Out-Null
Write-Host "WN11-CC-000225 applied: shell protocol protected mode enabled." -ForegroundColor Green
