# configure-windows.ps1
# This script should be executed by sysprep during the specialize pass.

# The following will enable Remote Desktop
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

winrm quickconfig -force