# Security Detection

Preview:
![avpre](https://github.com/5Noxi/Security-Detector/blob/main/sec.png?raw=true)

## Script Output

| Category                 | Source / Command | Details |
|--------------------------|------------------|----------------------|
| **Windows Defender Status** | `Get-MpComputerStatus` | `AntivirusEnabled` |
| **Firewall Profiles**    | `Get-NetFirewallProfile \| Select-Object -Property Name, Enabled` | Displays the status of all firewall profiles, including profile `Name` and whether it is `Enabled` |
| **Secure Boot State**    | `Confirm-SecureBootUEFI` | Outputs `True` or `False` depending on whether Secure Boot is enabled |
| **BitLocker Status**     | `Get-BitLockerVolume \| Select-Object -Property MountPoint, VolumeStatus, EncryptionMethod, ProtectionStatus` | Shows drive letter, status, encryption method, and protection status for each volume |
| **Installed AV Programs** | System Query | Lists installed antivirus software on the system |
| **Running AV Services**  | Service Search (pattern match) | Searches for running services that match known antivirus names *(may not always be fully accurate)* |

## UAC status (`UserAccountControlSettings.exe`):
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

References:
> https://learn.microsoft.com/en-us/powershell/module/defender/get-mpcomputerstatus?view=windowsserver2025-ps  
> https://learn.microsoft.com/en-us/powershell/module/netsecurity/get-netfirewallprofile?view=windowsserver2025-ps (`Select-Object -Property Name, Enabled`)  
> https://learn.microsoft.com/en-us/powershell/module/secureboot/confirm-securebootuefi?view=windowsserver2025-ps  
> https://learn.microsoft.com/en-us/powershell/module/bitlocker/get-bitlockervolume?view=windowsserver2025-ps (`Select-Object -Property MountPoint, VolumeStatus, EncryptionMethod, ProtectionStatus`)  
> https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.security/get-executionpolicy?view=powershell-7.5  
