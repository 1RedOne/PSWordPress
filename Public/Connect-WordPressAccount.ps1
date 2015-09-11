Function Connect-WordPressAccount {
param($ClientID,$blogURL,$clientSecret)


$configDir = "$Env:AppData\WindowsPowerShell\Modules\PSWordPress\0.1\Config.ps1xml"
if (-not ( Test-Path $configDir)){
    New-item -Force $configDir 
    }
    else{
        $password = Import-Clixml $configDir | ConvertTo-SecureString
        $Ptr = [System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode($password)
        $result = [System.Runtime.InteropServices.Marshal]::PtrToStringUni($Ptr)
        [System.Runtime.InteropServices.Marshal]::ZeroFreeCoTaskMemUnicode($Ptr)
        $global:accessToken = $result 
        Write-Output "Found cached Cred"
        break
    }


Get-WordPressAuthCode -ClientID $ClientID -blogURL $blogURL

Get-WordPressAuthToken -ClientID $ClientID -clientSecret $clientSecret -blogURL $blogURL -authCode $authCode -Debug

#store the token
$password = ConvertTo-SecureString $accessToken -AsPlainText -Force
$password | ConvertFrom-SecureString | Export-Clixml $configDir -Force


}