Function Connect-WordPressAccount {
<#
.Synopsis
    Use this cmdlet to connect to a WordPress account for management via PowerShell
.DESCRIPTION
    With one cmdlet, you can connect to your WordPress account via the REST API.  After using this cmdlet, you can use the rest of the cmdlets in the PSWordPress PowerShell module to Get-WordPressStats, make a New-WordPressPost or other activities
.EXAMPLE
    Connect-WordPressAccount -ClientID [String] -BlogURL [(Redirect URL)] -ClientSecret [ClientSecret]

    Sign up at developer.wordpress.com and make a new application ID, which is needed to query to WordPress API.  While you're there, specify a redirect URL, which should be the URL of your blog.  You'll receive a ClientID, ClientSecret and RedirectURL, which you must provide to this cmdlet.

    Upon running, a Internet Explorer com object window will be displayed, prompting you to login and authorize your Application ID (PowerShell, effectively) to interact with your WordPress account.  Click the appropriate boxes, and then close the browser window when you see your blog displayed.

    Behind the scenes, this cmdlet will retrieve an Access Token, convert it to an Authorization Token, and store it safely within your profile.  Other PSWordpress API calls require this Authorization token, and it will be automatically provided when needed.
.EXAMPLE
    Connect-WordpressAccount -Force

    If you need to renew your API key (roughly once a month), then rerun the cmdlet with -Force
#>
[CmdletBinding()]
param($ClientID,$blogURL,$clientSecret,[Switch]$force)

#load private functions
$PrivateFunctions = get-childitem "$((Get-Module PSWordPress).ModuleBase)\Private" 

Foreach ($import in $PrivateFunctions)
    {
        Try
        {
            . $import.fullname
        }
        Catch
        {
            Write-Error -Message "Failed to import function $($import.fullname): $_"
        }
    }


$configDir = "$Env:AppData\WindowsPowerShell\Modules\PSWordPress\0.1\Config.ps1xml"
if (-not (Test-Path $configDir) -or $force){
        if ($force){"`$force detected"}
        New-item -Force -Path "$configDir" -ItemType File
    
        Get-WordPressAuthCode -ClientID $ClientID -blogURL $blogURL

        Get-WordPressAuthToken -ClientID $ClientID -clientSecret $clientSecret -blogURL $blogURL -authCode $authCode -Debug

        #store the token
        $password = ConvertTo-SecureString $accessToken -AsPlainText -Force
        $password | ConvertFrom-SecureString | Export-Clixml $configDir -Force
    }
    else{
        try {
             $password = Import-Clixml -Path $configDir -ErrorAction STOP | ConvertTo-SecureString

             }
      catch {
        Write-Warning "Corrupt Password file found, rerun with -Force to fix this"
        BREAK
       }
        $Ptr = [System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode($password)
        $result = [System.Runtime.InteropServices.Marshal]::PtrToStringUni($Ptr)
        [System.Runtime.InteropServices.Marshal]::ZeroFreeCoTaskMemUnicode($Ptr)
        $global:accessToken = $result 
        'Found cached Cred'
        continue
    }

}