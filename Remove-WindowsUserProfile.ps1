function Remove-WindowsProfile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,Position=0)]
        [string]$Username
    )
    $RegKey = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList"
    $SID = (Get-WmiObject -Class Win32_UserProfile | Where-Object { $_.LocalPath.split('\')[-1] -eq $Username }).SID
    if ($SID) {
        $UserPath = Join-Path -Path "C:\Users" -ChildPath $Username
        Remove-Item -Path $UserPath -Recurse -Force
        $RegPath = Join-Path -Path $RegKey -ChildPath $SID
        Remove-Item -Path $RegPath -Recurse -Force
        Write-Output "Profile for $Username has been deleted."
    } else {
        Write-Output "Profile for $Username was not found."
    }
}
