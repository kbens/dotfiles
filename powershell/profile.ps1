
#######################################################################
#                               Aliases                               #
#######################################################################
Set-Alias ll ls
Set-Alias vi "C:\Program Files (x86)\Notepad++\notepad++.exe"
Set-Alias touch New-File
. "C:\Users\kbens\lib\oracle-cli\Lib\site-packages\oci_cli\bin\OciTabExpansion.ps1"

#######################################################################
#                              Functions                              #
#######################################################################
Function tfa {terraform apply}
Function tfaa {terraform apply --auto-approve}
Function tfd {terraform destroy}
# Function tfdd {terraform destroy --auto-approve}

#######################################################################
#                                Misc                                 #
#######################################################################
# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}