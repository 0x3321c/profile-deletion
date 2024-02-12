<!-- Back to top link -->
<a name="readme-top"></a>

<!-- NAME -->
# REMOVE USER PROFILE 

<!-- ABSTRACT -->
## ABSTRACT 
The Cmdlet. Remove-WindowsUserProfile.ps1 deletes Microsoft Windows user profile.

<!-- ABOUT THE PROJECT -->
## DESCRIPTION
This PowerShell cmdlet deletes a user profile from a local machine by specifying the username. It removes both the user profile directory and associated registry keys.

* What is it ?
    - Script to be run once in a while.
    - Fonction to be added in your code
    - User Interface to be user friendly
    
* Who is it for ?
    - IT Support
    - Power User
    - Bets Tester
    
 * Why to use it ? 
    - Clean the Operating Sytem with the unused user profile.
    - Clean up on 32-bit & 64-bit
    - Delete account not supported by native Windows tools
    
 * When to use it ?
    - Whenever it is necessary to make room on the computer.
    - Remove a corrupted account
    - For testing purpose
    
 <p align="right">(<a href="#readme-top">back to top</a>)</p>
 
<!-- Getting Started -->
## QUICKSTART

### Prerequisites
Get information about
* Windows version ; Version must be 10 or alter
    * _Cmdlet_
    ```powershell
    Get-ComputerInfo
    ```
    * _Environment Class_
    ```powershell
    [Environment]::OSVersion
    ```
* Powershell version ; Version must be 6 or later
    * _Cmdlet_
    ```powershell
    Get-Host
    ```
    * _Automatic Variable_
    ```powershll
    $PSVersionTable
    ```
### Update Powershell
1. Open a prompt, Powershell or Ms-Dos with eleveted permissions
2. Run the command line
    * _PowerShell
    ```powershell
    winget install --id Microsoft.Powershell --source winget
    ```
  
    
### Installation

1. Open a PowerShell prompt with eleveted permissions
2. Set the PowerShell execution policies for Windows computers to Unrestricted
3. Download the archive of the project
4. Extract the content of the archive


 <p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ROADMAP -->
## ROADMAP

| Windows | Linux | MacOS|
| :----: | :---: | :--: |
| In progress | To be decided | To be decided |

- [ ] Windows
    - [ ] Script
    - [x] Cmdlet
    - [ ] Interface
   

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- LICENSE -->
## LICENSE

Distributed under the Unlicense. See `LICENSE` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ACKNOWLEDGMENTS -->
## SEE ALSO
* [Remove-LocalUser](https://learn.microsoft.com/en-gb/powershell/module/microsoft.powershell.localaccounts/remove-localuser)
* [Delprof2 – User Profile Deletion Tool](https://helgeklein.com/free-tools/delprof2-user-profile-deletion-tool)
* [User Profile Deletion Utility (Delprof.exe)](https://www.microsoft.com/en-us/download/details.aspx?id=5405) 

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ACKNOWLEDGMENTS -->
## ACKNOWLEDGMENTS
* [Choose an Open Source License](https://choosealicense.com)
* [README Template](https://github.com/othneildrew/Best-README-Template)
* [Emoji Cheat Sheet](https://github.com/ikatyang/emoji-cheat-sheet)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTACT -->
## CONTACT

:e-mail: RemoveWindowsUserProfile@gmail.com

<p align="right">(<a href="#readme-top">back to top</a>)</p>
