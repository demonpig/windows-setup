# configure-windows.ps1
# This script should be executed by sysprep during the specialize pass.

Enable-NetFirewallRule -name RemoteDesktop-UserMode-In-TCP

winrm quickconfig --force