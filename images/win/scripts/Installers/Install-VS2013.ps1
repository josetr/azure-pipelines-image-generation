################################################################################
##  File:  Install-VS2013.ps1
##  Team:  CI-Build
##  Desc:  Install Visual Studio 2013
################################################################################

Import-Module -Name ImageHelpers -Force

$InstallerURI = 'https://download.microsoft.com/download/E/2/A/E2ADF1BE-8FA0-4436-A260-8780444C8355/vs_ultimate.exe'
$InstallerName = 'vs_ultimate.exe'
$ArgumentList = ('/Full', '/Quiet', '/NoRestart' )
$exitCode = Install-EXE -Url $InstallerURI -Name $InstallerName -ArgumentList $ArgumentList
$devenvPath = "C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE\devenv.exe";

# Find the version of VS installed for this instance
$VisualStudioVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($devenvPath).ProductVersion
Write-Host "Visual Studio version $VisualStudioVersion installed"

# Initialize Visual Studio Experimental Instance for integration testing
&"$devenvPath" /RootSuffix Exp /ResetSettings General.vssettings /Command File.Exit | Wait-Process

exit $exitCode