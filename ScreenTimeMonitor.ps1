# Screen Time Monitor and Health Reminder Script
# Save as ScreenTimeMonitor.ps1

# Required assemblies for Windows Forms notifications
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create directory for storing data and config if it doesn't exist
$dataPath = "$env:ProgramData\ScreenTimeMonitor"
if (-not (Test-Path $dataPath)) {
    New-Item -ItemType Directory -Path $dataPath -Force
}

# Health tips file path
$tipsFile = "$dataPath\healthtips.txt"

# Create default health tips if file doesn't exist
if (-not (Test-Path $tipsFile)) {
    @(
        "Stand up and stretch for 5 minutes to improve blood circulation",
        "Look at something 20 feet away for 20 seconds to reduce eye strain",
        "Do some shoulder and neck rolls to release tension",
        "Take a short walk to refresh your mind",
        "Drink water to stay hydrated"
    ) | Out-File -FilePath $tipsFile
}

# Function to show notification
function Show-HealthReminder {
    param (
        [string]$Message
    )
    
    $notification = New-Object System.Windows.Forms.NotifyIcon
    $notification.Icon = [System.Drawing.SystemIcons]::Information
    $notification.BalloonTipTitle = "Health Reminder"
    $notification.BalloonTipText = $Message
    $notification.Visible = $true
    $notification.ShowBalloonTip(10000)
    
    # Clean up notification after display
    Start-Sleep -Seconds 11
    $notification.Dispose()
}

# Function to get random health tip
function Get-RandomHealthTip {
    $tips = Get-Content $tipsFile
    return Get-Random -InputObject $tips
}

# Function to check if screen is active
function Test-ScreenActive {
    $lastInputInfo = New-Object LASTINPUTINFO
    $lastInputInfo.cbSize = [System.Runtime.InteropServices.Marshal]::SizeOf($lastInputInfo)
    [User32]::GetLastInputInfo([ref]$lastInputInfo)
    
    $lastInput = [System.Environment]::TickCount - $lastInputInfo.dwTime
    return $lastInput -lt 60000  # Consider screen active if last input was less than 1 minute ago
}

# Add required Windows API types
$code = @'
using System;
using System.Runtime.InteropServices;

public struct LASTINPUTINFO
{
    public uint cbSize;
    public uint dwTime;
}

public class User32
{
    [DllImport("User32.dll")]
    public static extern bool GetLastInputInfo(ref LASTINPUTINFO plii);
}
'@

Add-Type -TypeDefinition $code -Language CSharp

# Main monitoring loop
$screenActiveTime = 0
$lastCheckTime = Get-Date
$reminderInterval = 7200  # 2 hours in seconds

while ($true) {
    $currentTime = Get-Date
    $timeDiff = ($currentTime - $lastCheckTime).TotalSeconds
    
    if (Test-ScreenActive) {
        $screenActiveTime += $timeDiff
        
        # Check if it's time to show a reminder
        if ($screenActiveTime -ge $reminderInterval) {
            $healthTip = Get-RandomHealthTip
            Show-HealthReminder $healthTip
            $screenActiveTime = 0  # Reset the counter
        }
    }
    
    $lastCheckTime = $currentTime
    
    # Log screen time to file
    $logEntry = "{0},{1},{2}" -f $env:COMPUTERNAME, $env:USERNAME, $screenActiveTime
    Add-Content -Path "$dataPath\screentime.log" -Value $logEntry
    
    Start-Sleep -Seconds 60  # Check every minute
}
