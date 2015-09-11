Function Connect-WordPressAccount {
param($ClientID,$blogURL,$clientSecret,[Switch]$force)


$configDir = "$Env:AppData\WindowsPowerShell\Modules\PSWordPress\0.1\Config.ps1xml"
if (-not (Test-Path $configDir) -or $force){
        "`$force detected"
        New-item -Force -Path "$configDir" -ItemType File
    
        Get-WordPressAuthCode -ClientID $ClientID -blogURL $blogURL

        Get-WordPressAuthToken -ClientID $ClientID -clientSecret $clientSecret -blogURL $blogURL -authCode $authCode -Debug

        #store the token
        $password = ConvertTo-SecureString $accessToken -AsPlainText -Force
        $password | ConvertFrom-SecureString | Export-Clixml $configDir -Force
    }
    else{
        $password = Import-Clixml -Path $configDir | ConvertTo-SecureString
        $Ptr = [System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode($password)
        $result = [System.Runtime.InteropServices.Marshal]::PtrToStringUni($Ptr)
        [System.Runtime.InteropServices.Marshal]::ZeroFreeCoTaskMemUnicode($Ptr)
        $global:accessToken = $result 
        'Found cached Cred'
        continue
    }

}