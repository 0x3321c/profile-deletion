$Username = "Enter_Username_Here"
$RegKey = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList"

# Get SID of user profile
$SID = (Get-WmiObject -Class Win32_UserProfile | Where-Object { $_.LocalPath.split('\')[-1] -eq $Username }).SID

# Remove the user profile
if ($SID) {
    $UserPath = Join-Path -Path "C:\Users" -ChildPath $Username
    Remove-Item -Path $UserPath -Recurse -Force
    
    # Remove the user profile from registry
    $RegPath = Join-Path -Path $RegKey -ChildPath $SID
    Remove-Item -Path $RegPath -Recurse -Force
    Write-Output "Profile for $Username has been deleted."
} else {
    Write-Output "Profile for $Username was not found."
}
