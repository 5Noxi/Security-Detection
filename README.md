# Security Detection

Preview:
![avpre](https://github.com/5Noxi/Security-Detector/blob/main/sec.png?raw=true)
⠀
__It outputs:__
- Windows Defender status 
  - `Get-MpComputerStatus` - `AntivirusEnabled`
- Status of all firewall profiles 
  - `Get-NetFirewallProfile | Select-Object -Property Name, Enabled`
- Secure boot state
  - `Confirm-SecureBootUEFI`, outputs `True` or `False`
- BitLocker encryption status for drives
  - `Get-BitLockerVolume | Select-Object -Property MountPoint, VolumeStatus, EncryptionMethod, ProtectionStatus`
- Installed AV programs
- Currently running antivirus services
  - Searches for services including a predefined pattern (AV names), this might be a bit faulty
- UAC status (`UserAccountControlSettings.exe`):
`Always notify me when: ...`
```ps
RegSetValue    HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\EnableLUA    Type: REG_DWORD, Length: 4, Data: 1
RegSetValue    HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\ConsentPromptBehaviorAdmin    Type: REG_DWORD, Length: 4, Data: 2
RegSetValue    HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\PromptOnSecureDesktop    Type: REG_DWORD, Length: 4, Data: 1
```
`Notify me only when apps try to make changes to my computer (default)`
```ps
RegSetValue    HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\EnableLUA    Type: REG_DWORD, Length: 4, Data: 1
RegSetValue    HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\ConsentPromptBehaviorAdmin    Type: REG_DWORD, Length: 4, Data: 5
RegSetValue    HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\PromptOnSecureDesktop    Type: REG_DWORD, Length: 4, Data: 1
```
`Notify me only when apps try to make changes to my computer (do not dim my desktop)`
```ps
RegSetValue    HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\EnableLUA    Type: REG_DWORD, Length: 4, Data: 1
RegSetValue    HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\ConsentPromptBehaviorAdmin    Type: REG_DWORD, Length: 4, Data: 5
RegSetValue    HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\PromptOnSecureDesktop    Type: REG_DWORD, Length: 4, Data: 0
```
`Never notify me when: ...`
```ps
RegSetValue    HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\EnableLUA    Type: REG_DWORD, Length: 4, Data: 1
RegSetValue    HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\ConsentPromptBehaviorAdmin    Type: REG_DWORD, Length: 4, Data: 0
RegSetValue    HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\PromptOnSecureDesktop    Type: REG_DWORD, Length: 4, Data: 0
```
Disable UAC:
```bat
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f
```

__References:__
> https://learn.microsoft.com/en-us/powershell/module/defender/get-mpcomputerstatus?view=windowsserver2025-ps
> https://learn.microsoft.com/en-us/powershell/module/netsecurity/get-netfirewallprofile?view=windowsserver2025-ps (`Select-Object -Property Name, Enabled`)
> https://learn.microsoft.com/en-us/powershell/module/secureboot/confirm-securebootuefi?view=windowsserver2025-ps
> https://learn.microsoft.com/en-us/powershell/module/bitlocker/get-bitlockervolume?view=windowsserver2025-ps (`Select-Object -Property MountPoint, VolumeStatus, EncryptionMethod, ProtectionStatus`)
> https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.security/get-executionpolicy?view=powershell-7.5

## Discord Server 
- https://discord.gg/E2ybG4j9jU
