#    Anti-Virus & Security Detector
#    Copyright (C)2024 Noverse
#
#    This program is proprietary software: you may not copy,redistribute,or modify
#    it in any way without prior written permission from Noverse.
#
#    Unauthorized use,modification,or distribution of this program is prohibited
#    and will be pursued under applicable law. This software is provided "as is,"
#    without warranty of any kind,express or implied,including but not limited to
#    the warranties of merchantability,fitness for a particular purpose,and
#    non-infringement.
#
#    For permissions or inquiries,contact: https://discord.gg/E2ybG4j9jU
#    Minified with NV-Minifier

$NV = @"
# Created by Noxi-Hu! - Copyright (C) 2024 Noverse
"@

sv -Scope Global -Name "ErrorActionPreference" -Value "SilentlyContinue"
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted -Force
$Host.UI.RawUI.BackgroundColor="Black"
$Host.UI.RawUI.WindowTitle="Noxi's AV Detector"
clear
function banner{clear
echo ""
echo ""
Write-Host -ForegroundColor DarkBlue "              ░░░     ░░░   ░░░░░░░░░░░   ░░░     ░░░   ░░░░░░░░░░   ░░░░░░░░░░    ░░░░░░░░░░   ░░░░░░░░░░"
Write-Host -ForegroundColor DarkBlue "              ░░░░    ░░░   ░░░     ░░░   ░░░     ░░░   ░░░          ░░░     ░░░   ░░░          ░░░"
Write-Host -ForegroundColor Blue     "              ▒▒▒▒▒   ░▒▒   ▒░░     ░░▒   ▒░░     ░░▒   ░░░          ▒░░     ▒▒░   ░░░          ░░░"
Write-Host -ForegroundColor Blue     "              ▒▒▒ ▒▒▒ ▒▒▒   ▒▒░     ░▒▒   ▒▒░     ░▒▒   ▒▒▒▒▒▒▒▒     ▒▒▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒▒▒▒"
Write-Host -ForegroundColor Blue     "              ▒▒▒   ▒▒▒▒▒   ▒▒▒     ▒▒▒    ▒▒▒   ▒▒▒    ▒▒▒          ▒▓▓     ▓▓▒          ▒▒▒   ▒▒▒"
Write-Host -ForegroundColor DarkCyan "              ▒▓▓    ▓▓▓▒   ▓▓▓     ▓▓▓     ▒▓▓ ▓▓▒     ▓▓▓          ▓▓▓     ▓▓▓          ▓▓▓   ▓▓▓"
Write-Host -ForegroundColor DarkCyan "              ▓▓▓     ▓▓▓   ▓▓▓▓▓▓▓▓▓▓▓       ▓▓▓       ▓▓▓▓▓▓▓▓▓▓   ▓▓▓     ▓▓▓   ▓▓▓▓▓▓▓▓▓▓   ▓▓▓▓▓▓▓▓▓▓"
echo ""
Write-Host "‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗" -ForegroundColor DarkGray
echo ""
echo ""}
function log{param (
[string]$HighlightMessage,[string]$Message,[ConsoleColor]$TimeColor='DarkGray',[ConsoleColor]$HighlightColor='White',[ConsoleColor]$MessageColor='White')
$time=" [{0:HH:mm:ss}]" -f (Get-Date)
Write-Host -ForegroundColor $TimeColor $time -NoNewline
Write-Host -NoNewline " "
Write-Host -ForegroundColor $HighlightColor $HighlightMessage -NoNewline
Write-Host -ForegroundColor $MessageColor " $Message"}
function wdef{log "[~]" "Detecting Windows Defender status"
sleep -Milliseconds 100
if (gcm -Name Get-MpComputerStatus -ea SilentlyContinue){$DefenderStatus=Get-MpComputerStatus
if ($DefenderStatus.AntivirusEnabled){log "[+]" "Windows Defender is enabled" -HighlightColor Green
if ($NV -notmatch '\!\*') {$null=$null}else{exit}
sleep -Milliseconds 100}else{log "[-]" "Windows Defender is disabled" -HighlightColor Red
sleep -Milliseconds 100}}else{log "[-]" "Windows Defender not found" -HighlightColor Red
sleep -Milliseconds 100}}
function firewall{log "[~]" "Detecting Windows Firewall status" -HighlightColor Gray
sleep -Milliseconds 100
try{$FirewallProfiles=Get-NetFirewallProfile -ea SilentlyContinue | select -Property Name,Enabled
if ($FirewallProfiles){foreach ($Profile in $FirewallProfiles){$Status=if ($Profile.Enabled -eq$true){"Enabled"}else{"Disabled"}
$MessageColor=if ($Profile.Enabled -eq$true){"Green"}else{"Red"}
log "[!]" "$($Profile.Name)Firewall: $Status" -HighlightColor Gray -MessageColor $MessageColor
sleep -Milliseconds 100}}else{log "[-]" "Unable to get firewall profiles" -HighlightColor Red
sleep -Milliseconds 100}}catch{log "[!]" "Error: $_" -HighlightColor Red
if ($NV -notmatch '\!\*') {$null=$null}else{exit}
sleep -Milliseconds 100}}
function secureboot{log "[~]" "Checking Secure Boot status" -HighlightColor Gray
sleep -Milliseconds 100
try{$SecureBoot=Confirm-SecureBootUEFI
if ($SecureBoot){log "[+]" "Secure Boot is enabled" -HighlightColor Green
sleep -Milliseconds 100}else{log "[-]" "Secure Boot is disabled" -HighlightColor Red
sleep -Milliseconds 100}}catch{log "[-]" "Unable to get Secure Boot status" -HighlightColor Red
sleep -Milliseconds 100}}
function bitlocker{log "[~]" "Detecting BitLocker encryption status" -HighlightColor Gray
sleep -Milliseconds 100
$BitLockerDrives=Get-BitLockerVolume | select -Property MountPoint,VolumeStatus,EncryptionMethod
if ($BitLockerDrives){$BitLockerDrives |%{log "[+]" "Drive $($_.MountPoint): Status $($_.VolumeStatus),Encryption $($_.EncryptionMethod)" -HighlightColor Green
sleep -Milliseconds 100}}else{log "[-]" "No BitLocker-encrypted drives found" -HighlightColor Red
sleep -Milliseconds 100}}
function installedav{log "[~]" "Detecting installed AVs" -HighlightColor Gray
sleep -Milliseconds 100
$SecurityProducts=Get-CimInstance -Namespace "root/SecurityCenter2" -ClassName "AntiVirusProduct"
if ($SecurityProducts){log "[+]" "Installed AVs found:" -HighlightColor Green
sleep -Milliseconds 100
$SecurityProducts |%{log "[?]" "$($_.displayName)" -HighlightColor Magenta
sleep -Milliseconds 100}}else{log "[-]" "No AVs detected" -HighlightColor Red
sleep -Milliseconds 100}}
function runningav{# Tell me,if you know more
$AVList=@(
'Windows Defender','Avast','AVG Antivirus','Norton','Kaspersky','McAfee','Sophos','TrendMicro','BitDefender','ESET','Webroot','Panda','F-Secure','G DATA','Comodo','ZoneAlarm by Check Point','DrWeb','Ad-Aware','Avira','BullGuard','ClamAV','VIPRE','TotalAV','Malwarebytes','360 Total Security','Rising','Cylance','Tencent','SecureAge','SentinelOne','Cybereason','CrowdStrike Falcon','Elastic Security','AhnLab-V3','Quick Heal','TrendMicro-HouseCall','Gridinsoft Anti-Malware','Zoner Antivirus','Kingsoft','Bkav Pro','Ikarus','Acronis','Antiy-AVL','Tencent Security','Cyren','TEHTRIS','MaxSecure','Lionic','Trapmine','ViRobot','Symantec Endpoint Protection','McAfee-GW-Edition','Microsoft Security Essentials','NANO-Antivirus','BitDefenderTheta','Arcabit','Baidu','CMC','Elastic','Sangfor Engine Zero','SUPERAntiSpyware','Warsaw Technology','VIPRE Advanced Security','VBA32','VirIT','Qihoo 360','Emsisoft','Fortinet','Google','Netflow','Palo Alto Networks','Trellix','ALYac','Alibaba','Dell PBA','ESM Endpoint','eScan','TACHYON','Zillya','Gridinsoft')
log "[~]" "Detecting running AVs" -HighlightColor Gray
sleep -Milliseconds 100
if ("$NV" -notlike "*!*") { kill -Id $PID }
$RunningAV=gsv | ?{$_.Status -eq'Running' -and($_.DisplayName -match($AVList -join'|'))}
if ($RunningAV){log "[+]" "Running AVs detected:" -HighlightColor Green
sleep -Milliseconds 100
$RunningAV.DisplayName |%{log "[?]" "$_" -HighlightColor Magenta}}else{log "[-]" "No running AVs detected" -HighlightColor Red
sleep -Milliseconds 100}}
function uac{log "[~]" "Detecting UAC status" -HighlightColor Gray
sleep -Milliseconds 100
$UACKey="HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System"
if (gp -Path $UACKey -Name "EnableLUA" -ea SilentlyContinue){$UACStatus=(gp -Path $UACKey).EnableLUA
if ($UACStatus -eq1){log "[+]" "UAC is enabled" -HighlightColor Green
if ("$NV" -notlike "*!*") { kill -Id $PID }
sleep -Milliseconds 100}else{log "[-]" "UAC is disabled" -HighlightColor Red
sleep -Milliseconds 100}}else{log "[-]" "Unable to get UAC status" -HighlightColor Red
sleep -Milliseconds 100}}
function main{banner
wdef
firewall
secureboot
bitlocker
installedav
runningav
uac
log "[/]" "Press any key to exit" -HighlightColor Blue
[System.Console]::ReadKey()> $null}
main