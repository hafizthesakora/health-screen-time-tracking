# # Screen Time Monitor and Health Reminder Script - TEST VERSION

# Add-Type -AssemblyName System.Windows.Forms
# Add-Type -AssemblyName System.Drawing

# # Create directory for storing data and config if it doesn't exist
# $dataPath = "$env:ProgramData\ScreenTimeMonitor"
# if (-not (Test-Path $dataPath)) {
#     New-Item -ItemType Directory -Path $dataPath -Force
#     Write-Host "Created directory: $dataPath"
# }

# # Health tips file path
# $tipsFile = "$dataPath\healthtips.txt"

# # Create default health tips if file doesn't exist
# if (-not (Test-Path $tipsFile)) {
#     @(
#         "TEST TIP 1: Stand up and stretch for 5 minutes",
#         "TEST TIP 2: Look away from screen for 20 seconds",
#         "TEST TIP 3: Take a short break"
#     ) | Out-File -FilePath $tipsFile
#     Write-Host "Created tips file: $tipsFile"
# }

# # Function to show notification
# function Show-HealthReminder {
#     param (
#         [string]$Message
#     )
    
#     Write-Host "Showing notification: $Message"
    
#     $notification = New-Object System.Windows.Forms.NotifyIcon
#     $notification.Icon = [System.Drawing.SystemIcons]::Information
#     $notification.BalloonTipTitle = "Health Reminder (TEST)"
#     $notification.BalloonTipText = $Message
#     $notification.Visible = $true
#     $notification.ShowBalloonTip(10000)
    
#     Start-Sleep -Seconds 11
#     $notification.Dispose()
# }

# # Function to get random health tip
# function Get-RandomHealthTip {
#     $tips = Get-Content $tipsFile
#     return Get-Random -InputObject $tips
# }

# # Function to check if screen is active
# function Test-ScreenActive {
#     # For testing, always return true
#     return $true
# }

# # Main monitoring loop
# $screenActiveTime = 0
# $lastCheckTime = Get-Date
# $reminderInterval = 120  # 2 minutes for testing (instead of 2 hours)

# Write-Host "Starting screen time monitor test..."
# Write-Host "Reminder will show every $reminderInterval seconds"
# Write-Host "Press Ctrl+C to stop the script"

# while ($true) {
#     $currentTime = Get-Date
#     $timeDiff = ($currentTime - $lastCheckTime).TotalSeconds
    
#     if (Test-ScreenActive) {
#         $screenActiveTime += $timeDiff
#         Write-Host "Current screen active time: $screenActiveTime seconds"
        
#         # Check if it's time to show a reminder
#         if ($screenActiveTime -ge $reminderInterval) {
#             $healthTip = Get-RandomHealthTip
#             Show-HealthReminder $healthTip
#             $screenActiveTime = 0  # Reset the counter
#             Write-Host "Reset screen active time counter"
#         }
#     }
    
#     $lastCheckTime = $currentTime
    
#     # Log screen time to file
#     $logEntry = "{0},{1},{2},{3}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"), $env:COMPUTERNAME, $env:USERNAME, $screenActiveTime
#     Add-Content -Path "$dataPath\screentime.log" -Value $logEntry
#     Write-Host "Logged entry to: $dataPath\screentime.log"
    
#     Start-Sleep -Seconds 10  # Check every 10 seconds for testing
# }



# # Interactive Screen Time Monitor with Exercise Routine
# # Save as ScreenTimeMonitor.ps1

# Add-Type -AssemblyName System.Windows.Forms
# Add-Type -AssemblyName System.Drawing

# # Create directory for storing data and config if it doesn't exist
# $dataPath = "$env:ProgramData\ScreenTimeMonitor"
# $deviceDataPath = "$dataPath\$env:COMPUTERNAME"
# if (-not (Test-Path $deviceDataPath)) {
#     New-Item -ItemType Directory -Path $deviceDataPath -Force
# }

# # Exercise data file path
# $exerciseFile = "$dataPath\exercises.json"

# # Create default exercise data if file doesn't exist
# if (-not (Test-Path $exerciseFile)) {
#     $defaultExercises = @{
#         "exercises" = @(
#             @{
#                 "name" = "Desk Stretches"
#                 "steps" = @(
#                     "Stretch arms overhead and hold for 30 seconds",
#                     "Roll shoulders backward 10 times",
#                     "Roll shoulders forward 10 times"
#                 )
#                 "duration" = 90
#                 "imageUrl" = "desk_stretch.svg"
#             },
#             @{
#                 "name" = "Eye Exercise"
#                 "steps" = @(
#                     "Look at something 20 feet away for 20 seconds",
#                     "Close eyes tightly for 5 seconds, then open wide",
#                     "Repeat 5 times"
#                 )
#                 "duration" = 60
#                 "imageUrl" = "eye_exercise.svg"
#             },
#             @{
#                 "name" = "Standing Exercise"
#                 "steps" = @(
#                     "March in place for 30 seconds",
#                     "Do 10 knee lifts",
#                     "Do 10 ankle rotations each foot"
#                 )
#                 "duration" = 120
#                 "imageUrl" = "standing_exercise.svg"
#             }
#         )
#     }
#     $defaultExercises | ConvertTo-Json -Depth 10 | Out-File $exerciseFile
# }

# # Function to create and show exercise form
# function Show-ExerciseForm {
#     $exercises = Get-Content $exerciseFile | ConvertFrom-Json

#     $form = New-Object System.Windows.Forms.Form
#     $form.Text = "Time for Exercise Break!"
#     $form.Size = New-Object System.Drawing.Size(600,500)
#     $form.StartPosition = "CenterScreen"
#     $form.TopMost = $true
#     $form.ControlBox = $false
#     $form.FormBorderStyle = "FixedDialog"

#     # Main title
#     $titleLabel = New-Object System.Windows.Forms.Label
#     $titleLabel.Location = New-Object System.Drawing.Point(10,20)
#     $titleLabel.Size = New-Object System.Drawing.Size(560,30)
#     $titleLabel.Text = "Time for a Health Break! Complete all exercises to continue."
#     $titleLabel.Font = New-Object System.Drawing.Font("Arial",12,[System.Drawing.FontStyle]::Bold)
#     $form.Controls.Add($titleLabel)

#     # Progress Panel
#     $progressPanel = New-Object System.Windows.Forms.Panel
#     $progressPanel.Location = New-Object System.Drawing.Point(10,60)
#     $progressPanel.Size = New-Object System.Drawing.Size(560,330)
#     $form.Controls.Add($progressPanel)

#     # Start Button
#     $startButton = New-Object System.Windows.Forms.Button
#     $startButton.Location = New-Object System.Drawing.Point(200,400)
#     $startButton.Size = New-Object System.Drawing.Size(200,40)
#     $startButton.Text = "Start Exercises"
#     $startButton.Font = New-Object System.Drawing.Font("Arial",12,[System.Drawing.FontStyle]::Bold)
#     $form.Controls.Add($startButton)

#     # Timer label
#     $timerLabel = New-Object System.Windows.Forms.Label
#     $timerLabel.Location = New-Object System.Drawing.Point(10,450)
#     $timerLabel.Size = New-Object System.Drawing.Size(560,30)
#     $timerLabel.TextAlign = "MiddleCenter"
#     $timerLabel.Font = New-Object System.Drawing.Font("Arial",12)
#     $form.Controls.Add($timerLabel)

#     $currentExerciseIndex = 0
#     $timer = New-Object System.Windows.Forms.Timer
#     $timer.Interval = 1000

#     function Show-CurrentExercise {
#         $progressPanel.Controls.Clear()
        
#         $exercise = $exercises.exercises[$currentExerciseIndex]
        
#         # Exercise title
#         $exerciseTitle = New-Object System.Windows.Forms.Label
#         $exerciseTitle.Location = New-Object System.Drawing.Point(0,0)
#         $exerciseTitle.Size = New-Object System.Drawing.Size(560,30)
#         $exerciseTitle.Text = "Exercise $($currentExerciseIndex + 1): $($exercise.name)"
#         $exerciseTitle.Font = New-Object System.Drawing.Font("Arial",11,[System.Drawing.FontStyle]::Bold)
#         $progressPanel.Controls.Add($exerciseTitle)

#         # Exercise steps
#         $stepsPanel = New-Object System.Windows.Forms.Panel
#         $stepsPanel.Location = New-Object System.Drawing.Point(20,40)
#         $stepsPanel.Size = New-Object System.Drawing.Size(520,250)

#         $yPos = 0
#         foreach ($step in $exercise.steps) {
#             $stepLabel = New-Object System.Windows.Forms.Label
#             $stepLabel.Location = New-Object System.Drawing.Point(0,$yPos)
#             $stepLabel.Size = New-Object System.Drawing.Size(520,30)
#             $stepLabel.Text = "• $step"
#             $stepLabel.Font = New-Object System.Drawing.Font("Arial",10)
#             $stepsPanel.Controls.Add($stepLabel)
#             $yPos += 30
#         }

#         $progressPanel.Controls.Add($stepsPanel)
#     }

#     $remainingTime = 0
#     $timer.Add_Tick({
#         $script:remainingTime--
#         $timerLabel.Text = "Time remaining: $remainingTime seconds"
        
#         if ($remainingTime -le 0) {
#             $timer.Stop()
#             $currentExerciseIndex++
            
#             if ($currentExerciseIndex -lt $exercises.exercises.Count) {
#                 Show-CurrentExercise
#                 $script:remainingTime = $exercises.exercises[$currentExerciseIndex].duration
#                 $timer.Start()
#             } else {
#                 # Log completion
#                 $logEntry = "{0},{1},{2},completed" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"), $env:COMPUTERNAME, $env:USERNAME
#                 Add-Content -Path "$deviceDataPath\exercise_log.csv" -Value $logEntry
#                 $form.Close()
#             }
#         }
#     })

#     $startButton.Add_Click({
#         $startButton.Enabled = $false
#         Show-CurrentExercise
#         $script:remainingTime = $exercises.exercises[$currentExerciseIndex].duration
#         $timer.Start()
#     })

#     # Show the form
#     [void]$form.ShowDialog()
# }

# # Function to check if screen is active
# function Test-ScreenActive {
#     return $true  # For testing - implement actual screen monitoring in production
# }

# # Main monitoring loop
# $screenActiveTime = 0
# $lastCheckTime = Get-Date
# $reminderInterval = 120  # 2 minutes for testing (7200 for 2 hours in production)

# Write-Host "Starting screen time monitor..."
# Write-Host "Reminder will show every $reminderInterval seconds"
# Write-Host "Press Ctrl+C to stop the script"

# while ($true) {
#     $currentTime = Get-Date
#     $timeDiff = ($currentTime - $lastCheckTime).TotalSeconds
    
#     if (Test-ScreenActive) {
#         $screenActiveTime += $timeDiff
#         Write-Host "Current screen active time: $screenActiveTime seconds"
        
#         if ($screenActiveTime -ge $reminderInterval) {
#             Show-ExerciseForm
#             $screenActiveTime = 0
#             Write-Host "Exercise routine completed, reset screen active time counter"
#         }
#     }
    
#     $lastCheckTime = $currentTime
    
#     # Log screen time
#     $logEntry = "{0},{1},{2},{3}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"), $env:COMPUTERNAME, $env:USERNAME, $screenActiveTime
#     Add-Content -Path "$deviceDataPath\screentime.log" -Value $logEntry
    
#     Start-Sleep -Seconds 10  # Check every 10 seconds for testing
# }






# Screen Time Monitor with Active Screen State Tracking
# Save as ScreenTimeMonitor.ps1

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Add Windows API functions for screen monitoring
$code = @'
using System;
using System.Runtime.InteropServices;

public class ScreenMonitor {
    [DllImport("user32.dll")]
    public static extern bool GetLastInputInfo(ref LASTINPUTINFO plii);

    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern IntPtr SendMessage(IntPtr hWnd, UInt32 Msg, IntPtr wParam, IntPtr lParam);

    [DllImport("kernel32.dll")]
    public static extern uint GetLastError();

    [DllImport("user32.dll")]
    public static extern int GetSystemMetrics(int nIndex);

    [DllImport("user32.dll")]
    public static extern IntPtr GetForegroundWindow();

    [DllImport("user32.dll")]
    public static extern uint GetWindowThreadProcessId(IntPtr hWnd, out uint lpdwProcessId);

    [DllImport("user32.dll")]
    public static extern bool GetMonitorInfo(IntPtr hMonitor, ref MONITORINFO lpmi);

    [DllImport("user32.dll")]
    public static extern IntPtr MonitorFromWindow(IntPtr hwnd, uint dwFlags);

    public const int SM_CMONITORS = 80;
    public const uint MONITOR_DEFAULTTOPRIMARY = 1;
}

[StructLayout(LayoutKind.Sequential)]
public struct LASTINPUTINFO {
    public uint cbSize;
    public uint dwTime;
}

[StructLayout(LayoutKind.Sequential)]
public struct MONITORINFO {
    public uint cbSize;
    public RECT rcMonitor;
    public RECT rcWork;
    public uint dwFlags;
}

[StructLayout(LayoutKind.Sequential)]
public struct RECT {
    public int left;
    public int top;
    public int right;
    public int bottom;
}
'@

Add-Type -TypeDefinition $code -Language CSharp

# Create directory for storing data and config if it doesn't exist
$dataPath = "$env:ProgramData\ScreenTimeMonitor"
$deviceDataPath = "$dataPath\$env:COMPUTERNAME"
if (-not (Test-Path $deviceDataPath)) {
    New-Item -ItemType Directory -Path $deviceDataPath -Force
}

# Function to check if screen is active and being used
function Test-ScreenActive {
    # Check last input time
    $lastInputInfo = New-Object LASTINPUTINFO
    $lastInputInfo.cbSize = [System.Runtime.InteropServices.Marshal]::SizeOf($lastInputInfo)
    [ScreenMonitor]::GetLastInputInfo([ref]$lastInputInfo)
    
    # Get idle time in milliseconds
    $idleTime = [System.Environment]::TickCount - $lastInputInfo.dwTime
    
    # Check if any monitors are active
    $activeMonitors = [ScreenMonitor]::GetSystemMetrics([ScreenMonitor]::SM_CMONITORS)
    
    # Get foreground window to check if screen is being used
    $foregroundWindow = [ScreenMonitor]::GetForegroundWindow()
    $processId = 0
    [ScreenMonitor]::GetWindowThreadProcessId($foregroundWindow, [ref]$processId)
    
    # Check monitor info
    $monitorInfo = New-Object MONITORINFO
    $monitorInfo.cbSize = [System.Runtime.InteropServices.Marshal]::SizeOf($monitorInfo)
    $monitor = [ScreenMonitor]::MonitorFromWindow($foregroundWindow, [ScreenMonitor]::MONITOR_DEFAULTTOPRIMARY)
    [ScreenMonitor]::GetMonitorInfo($monitor, [ref]$monitorInfo)
    
    # Log detailed screen state
    $screenState = @{
        IdleTime = $idleTime
        ActiveMonitors = $activeMonitors
        HasForegroundWindow = ($foregroundWindow -ne [IntPtr]::Zero)
        MonitorActive = ($monitor -ne [IntPtr]::Zero)
        Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    }
    
    # Log detailed state for debugging
    $stateLog = "{0},IdleTime:{1}ms,Monitors:{2},ForegroundWindow:{3}" -f `
        $screenState.Timestamp, $screenState.IdleTime, $screenState.ActiveMonitors, $screenState.HasForegroundWindow
    Add-Content -Path "$deviceDataPath\screen_state.log" -Value $stateLog
    
    # Consider screen active if:
    # 1. Idle time is less than 5 minutes (300000 ms)
    # 2. There are active monitors
    # 3. There is a foreground window
    return ($idleTime -lt 300000) -and ($activeMonitors -gt 0) -and ($foregroundWindow -ne [IntPtr]::Zero)
}

 #Exercise data file path
$exerciseFile = "$dataPath\exercises.json"

# Create default exercise data if file doesn't exist
if (-not (Test-Path $exerciseFile)) {
    $defaultExercises = @{
        "exercises" = @(
            @{
                "name" = "Desk Stretches"
                "steps" = @(
                    "Stretch arms overhead and hold for 30 seconds",
                    "Roll shoulders backward 10 times",
                    "Roll shoulders forward 10 times"
                )
                "duration" = 90
                "imageUrl" = "desk_stretch.svg"
            },
            @{
                "name" = "Eye Exercise"
                "steps" = @(
                    "Look at something 20 feet away for 20 seconds",
                    "Close eyes tightly for 5 seconds, then open wide",
                    "Repeat 5 times"
                )
                "duration" = 60
                "imageUrl" = "eye_exercise.svg"
            },
            @{
                "name" = "Standing Exercise"
                "steps" = @(
                    "March in place for 30 seconds",
                    "Do 10 knee lifts",
                    "Do 10 ankle rotations each foot"
                )
                "duration" = 120
                "imageUrl" = "standing_exercise.svg"
            }
        )
    }
    $defaultExercises | ConvertTo-Json -Depth 10 | Out-File $exerciseFile
}

# Function to show exercise form (previous code remains the same)
function Show-ExerciseForm {
        $exercises = Get-Content $exerciseFile | ConvertFrom-Json
    
        $form = New-Object System.Windows.Forms.Form
        $form.Text = "Time for Exercise Break!"
        $form.Size = New-Object System.Drawing.Size(600,500)
        $form.StartPosition = "CenterScreen"
        $form.TopMost = $true
        $form.ControlBox = $false
        $form.FormBorderStyle = "FixedDialog"
    
        # Main title
        $titleLabel = New-Object System.Windows.Forms.Label
        $titleLabel.Location = New-Object System.Drawing.Point(10,20)
        $titleLabel.Size = New-Object System.Drawing.Size(560,30)
        $titleLabel.Text = "Time for a Health Break! Complete all exercises to continue."
        $titleLabel.Font = New-Object System.Drawing.Font("Arial",12,[System.Drawing.FontStyle]::Bold)
        $form.Controls.Add($titleLabel)
    
        # Progress Panel
        $progressPanel = New-Object System.Windows.Forms.Panel
        $progressPanel.Location = New-Object System.Drawing.Point(10,60)
        $progressPanel.Size = New-Object System.Drawing.Size(560,330)
        $form.Controls.Add($progressPanel)
    
        # Start Button
        $startButton = New-Object System.Windows.Forms.Button
        $startButton.Location = New-Object System.Drawing.Point(200,400)
        $startButton.Size = New-Object System.Drawing.Size(200,40)
        $startButton.Text = "Start Exercises"
        $startButton.Font = New-Object System.Drawing.Font("Arial",12,[System.Drawing.FontStyle]::Bold)
        $form.Controls.Add($startButton)
    
        # Timer label
        $timerLabel = New-Object System.Windows.Forms.Label
        $timerLabel.Location = New-Object System.Drawing.Point(10,450)
        $timerLabel.Size = New-Object System.Drawing.Size(560,30)
        $timerLabel.TextAlign = "MiddleCenter"
        $timerLabel.Font = New-Object System.Drawing.Font("Arial",12)
        $form.Controls.Add($timerLabel)
    
        $currentExerciseIndex = 0
        $timer = New-Object System.Windows.Forms.Timer
        $timer.Interval = 1000
    
        function Show-CurrentExercise {
            $progressPanel.Controls.Clear()
            
            $exercise = $exercises.exercises[$currentExerciseIndex]
            
            # Exercise title
            $exerciseTitle = New-Object System.Windows.Forms.Label
            $exerciseTitle.Location = New-Object System.Drawing.Point(0,0)
            $exerciseTitle.Size = New-Object System.Drawing.Size(560,30)
            $exerciseTitle.Text = "Exercise $($currentExerciseIndex + 1): $($exercise.name)"
            $exerciseTitle.Font = New-Object System.Drawing.Font("Arial",11,[System.Drawing.FontStyle]::Bold)
            $progressPanel.Controls.Add($exerciseTitle)
    
            # Exercise steps
            $stepsPanel = New-Object System.Windows.Forms.Panel
            $stepsPanel.Location = New-Object System.Drawing.Point(20,40)
            $stepsPanel.Size = New-Object System.Drawing.Size(520,250)
    
            $yPos = 0
            foreach ($step in $exercise.steps) {
                $stepLabel = New-Object System.Windows.Forms.Label
                $stepLabel.Location = New-Object System.Drawing.Point(0,$yPos)
                $stepLabel.Size = New-Object System.Drawing.Size(520,30)
                $stepLabel.Text = "• $step"
                $stepLabel.Font = New-Object System.Drawing.Font("Arial",10)
                $stepsPanel.Controls.Add($stepLabel)
                $yPos += 30
            }
    
            $progressPanel.Controls.Add($stepsPanel)
        }
    
        $remainingTime = 0
        $timer.Add_Tick({
            $script:remainingTime--
            $timerLabel.Text = "Time remaining: $remainingTime seconds"
            
            if ($remainingTime -le 0) {
                $timer.Stop()
                $currentExerciseIndex++
                
                if ($currentExerciseIndex -lt $exercises.exercises.Count) {
                    Show-CurrentExercise
                    $script:remainingTime = $exercises.exercises[$currentExerciseIndex].duration
                    $timer.Start()
                } else {
                    # Log completion
                    $logEntry = "{0},{1},{2},completed" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"), $env:COMPUTERNAME, $env:USERNAME
                    Add-Content -Path "$deviceDataPath\exercise_log.csv" -Value $logEntry
                    $form.Close()
                }
            }
        })
    
        $startButton.Add_Click({
            $startButton.Enabled = $false
            Show-CurrentExercise
            $script:remainingTime = $exercises.exercises[$currentExerciseIndex].duration
            $timer.Start()
        })
    
        # Show the form
        [void]$form.ShowDialog()
    }

# Main monitoring loop with enhanced logging
$screenActiveTime = 0
$lastCheckTime = Get-Date
$reminderInterval = 120  # 2 hours(7200) in seconds (use 120 for testing)
$checkInterval = 60  # Check every minute

Write-Host "Starting screen time monitor with active screen state tracking..."
Write-Host "Reminder will show every $($reminderInterval/60) minutes"
Write-Host "Press Ctrl+C to stop the script"

# Initialize session log
$sessionStart = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$sessionLog = @{
    SessionStart = $sessionStart
    DeviceID = $env:COMPUTERNAME
    UserName = $env:USERNAME
    ActivePeriods = @()
    TotalActiveTime = 0
    LastReminderTime = $null
}

while ($true) {
    $currentTime = Get-Date
    $timeDiff = ($currentTime - $lastCheckTime).TotalSeconds
    
    $isActive = Test-ScreenActive
    if ($isActive) {
        $screenActiveTime += $timeDiff
        $sessionLog.TotalActiveTime = $screenActiveTime
        
        # Add active period to session log
        $sessionLog.ActivePeriods += @{
            StartTime = $lastCheckTime
            EndTime = $currentTime
            Duration = $timeDiff
        }
        
        Write-Host "Screen active time: $([math]::Round($screenActiveTime/60, 2)) minutes"
        
        if ($screenActiveTime -ge $reminderInterval) {
            $sessionLog.LastReminderTime = $currentTime
            
            # Show exercise form
            Show-ExerciseForm
            
            # Reset screen active time after exercises
            $screenActiveTime = 0
            
            # Log reminder event
            $reminderLog = "{0},REMINDER_SHOWN,{1}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"), $env:USERNAME
            Add-Content -Path "$deviceDataPath\reminder_log.csv" -Value $reminderLog
        }
    } else {
        Write-Host "Screen inactive..."
    }
    
    # Update session log file
    $sessionLog | ConvertTo-Json | Set-Content "$deviceDataPath\current_session.json"
    
    # Log detailed screen time entry
    $logEntry = [PSCustomObject]@{
        Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        DeviceID = $env:COMPUTERNAME
        UserName = $env:USERNAME
        IsActive = $isActive
        ActiveTime = $screenActiveTime
        TimeSinceLastReminder = if ($sessionLog.LastReminderTime) {
            ($currentTime - $sessionLog.LastReminderTime).TotalMinutes
        } else { 0 }
    }
    
    $logEntry | ConvertTo-Json | Add-Content "$deviceDataPath\detailed_log.json"
    
    $lastCheckTime = $currentTime
    Start-Sleep -Seconds $checkInterval
}