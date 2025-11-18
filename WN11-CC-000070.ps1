 <#
.SYNOPSIS
   This PowerShell script configures Virtualization-Based Security (VBS) on Windows 11 
   by applying the required Device Guard registry settings used in STIG hardening. 
   It enables the core security features that support VBS, including platform security 
   requirements, Hypervisor-Enforced Code Integrity (HVCI), and Credential Guard.
   These settings collectively ensure the system uses hardware-based virtualization 
   protections to isolate sensitive processes, prevent credential theft, and enhance 
   system integrity in compliance with WN11-CC-000070.

.NOTES
    Author          : Ernest Dicks
    LinkedIn        : linkedin.com/in/ernest-dicks/
    GitHub          : github.com/ernestdicks06
    Date Created    : 2025-11-17
    Last Modified   : 2025-11-17
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000070

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000070.ps1 
#>

# Enable VBS for WN11-CC-000070 using registry settings
# Run as Administrator

# 1. Confirm you are running elevated
$principal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "Run this script in an elevated PowerShell session (Run as Administrator)."
    exit 1
}

# 2. Base DeviceGuard key
$dgPath = 'HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard'

# Create the key if it doesn't exist
if (-not (Test-Path $dgPath)) {
    New-Item -Path $dgPath -Force | Out-Null
}

# 3. Enable Virtualization-Based Security
Set-ItemProperty -Path $dgPath -Name 'EnableVirtualizationBasedSecurity' -Type DWord -Value 1

# 4. Require platform security features
# 1 = Secure Boot only
# 3 = Secure Boot and DMA Protection (preferred for STIG)
Set-ItemProperty -Path $dgPath -Name 'RequirePlatformSecurityFeatures' -Type DWord -Value 3

# 5. Enable Hypervisor-Enforced Code Integrity (Memory Integrity)
Set-ItemProperty -Path $dgPath -Name 'HypervisorEnforcedCodeIntegrity' -Type DWord -Value 1

# 6. Enable Credential Guard scenario
$cgPath = Join-Path $dgPath 'Scenarios\CredentialGuard'
if (-not (Test-Path $cgPath)) {
    New-Item -Path $cgPath -Force | Out-Null
}

# 1 = Enabled without UEFI lock
# 2 = Enabled with UEFI lock (tighter, many STIGs use this – adjust if your org specifies)
Set-ItemProperty -Path $cgPath -Name 'Enabled' -Type DWord -Value 1

Write-Host "Virtualization-Based Security registry settings have been applied."
Write-Host "You must reboot for the changes to take full effect."
 
