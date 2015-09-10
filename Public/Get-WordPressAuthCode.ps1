Function Get-WordPressAuthCode{
param($ClientID,$blogURL)
    $url = "https://public-api.wordpress.com/oauth2/authorize?client_id=$clientID&redirect_uri=$blogURL&response_type=code"

    #region mini window, made by (Insert credits here)
    Function Show-OAuthWindow {
    Add-Type -AssemblyName System.Windows.Forms
 
    $form = New-Object -TypeName System.Windows.Forms.Form -Property @{Width=440;Height=640}
    $web  = New-Object -TypeName System.Windows.Forms.WebBrowser -Property @{Width=420;Height=600;Url=($url -f ($Scope -join "%20")) }
    $DocComp  = {
            $Global:uri = $web.Url.AbsoluteUri
            if ($Global:Uri -match "error=[^&]*|code=[^&]*") {$form.Close() }
    }
 
    $web.Add_DocumentCompleted($DocComp)
    $form.Controls.Add($web)
    $form.Add_Shown({$form.Activate()})
    $form.ShowDialog() | Out-Null
    }
    #endregion

    #login to get an access code 
    Show-OAuthWindow

    #After this, there should be a variable called $uri, which has our code!!!!!!!!!!!
    #(?<=code=)(.*)(?=&)
    $regex = '(?<=code=)(.*)(?=&)'
    $global:authCode  = ($uri | Select-string -pattern $regex).Matches[0].Value
    Write-output "Received an authCode, $authcode"
}
#Next, get an access token by presenting the code