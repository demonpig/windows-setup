# windows-setup

## Windows Installation

- Download the Windows ISO from Microsoft Evaluation Center website
- Download the [Red Hat Virtio Drivers for Windows](https://github.com/virtio-win/virtio-win-pkg-scripts)
- Setup VM in LibVirt 
  - TODO: Write out command to create VM
- Proceed with installing windows

## Post Installation Steps

Run these series of commands in order to finish the setup process. The goal for these steps is to be minimal as possible as most of the configuration should be done in the `configure-windows.ps1` script. This script is executed upon first launch of the Windows VM.

- Format the disk to remove the recovery partition

  ```
  Invoke-WebRequest https://raw.githubusercontent.com/demonpig/windows-setup/main/scripts/diskpart.txt -OutFile C:\Windows\System32\Sysprep\diskpart.txt
  ```

  ```
  diskpart /s C:\Windows\System32\Sysprep\diskpart.txt
  ```

- Install the rest of the Virtio drivers

  ```
  msiexec /i E:\virtio-win-gt-x64.msi /passive
  ```

  ```
  E:\virtio-win-guest-tools.exe /passive
  ```

- Configure the answer file and related scripts for out of box experience (OOBE)

  ```
  Invoke-WebRequest https://raw.githubusercontent.com/demonpig/windows-setup/main/Unattend.xml -OutFile C:\Windows\System32\Sysprep\Unattend.xml
  ```

  ```
  (Get-Content C:\Windows\System32\Sysprep\Unattend.xml).replace('INIT_PASSWORD', '$REPLACE_ME').replace('POST_PASSWORD', '$REPLACE_ME_AGAIN') | Set-Content C:\Windows\System32\Sysprep\Unattend.xml
  ```

  **Note:** Be sure to replace the variables `$REPLACE_ME` and `$REPLACE_ME_AGAIN` with appropriate values

  ```
  Invoke-WebRequest https://raw.githubusercontent.com/demonpig/windows-setup/main/scripts/configure-windows.ps1 -OutFile C:\Windows\System32\Sysprep\configure-windows.ps1
  ```

  ```
  C:\Windows\System32\Sysprep\sysprep.exe /generalize /oobe /shutdown
  ```