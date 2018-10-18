################################################################################
##  File:  Install-VS2012.ps1
##  Team:  CI-Build
##  Desc:  Install Visual Studio 2012
################################################################################

Import-Module -Name ImageHelpers -Force

$InstallerURI = 'https://download.microsoft.com/download/d/b/0/db03922c-ff91-4845-b7f2-fc68595ab730/vs_ultimate.exe'
$InstallerName = 'vs_ultimate.exe'
$ArgumentList = ('/Full', '/Quiet', '/NoRestart')
$exitCode = Install-EXE -Url $InstallerURI -Name $InstallerName -ArgumentList $ArgumentList

$InstallerURI = 'https://download.microsoft.com/download/A/F/9/AF95E6F8-2E6E-49D0-A48A-8E918D7FD768/VS2013.5.exe'
$InstallerName = 'VS2013.5'
$ArgumentList = ('/Full', '/Quiet', '/NoRestart')
$exitCode = Install-EXE -Url $InstallerURI -Name $InstallerName -ArgumentList $ArgumentList
$devenvPath = "C:\Program Files (x86)\Microsoft Visual Studio 11.0\Common7\IDE\devenv.exe";

# Find the version of VS installed for this instance
$VisualStudioVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($devenvPath).ProductVersion
Write-Host "Visual Studio version $VisualStudioVersion installed"

# Initialize Visual Studio Experimental Instance for integration testing
&"$devenvPath" /RootSuffix Exp /ResetSettings General.vssettings /Command File.Exit | Wait-Process

exit $exitCode