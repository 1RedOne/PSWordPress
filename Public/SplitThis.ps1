#first, a user has to authorize
$authURL = 'https://public-api.wordpress.com/oauth2/authorize'
#this gives you a code, you provide this auth code and then this results in a token, which can be used forever

#make a token call
#look for your API provider's page ending in /token

$clientID = '37880'
#need these from WPCreds.txt 
$blogURL  = 'http://www.foxdeploy.com'
$username = 'sred13@gmail.com'



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


Function Get-WordPressAuthToken{
param($ClientID,$blogURL,$clientSecret,$authCode)
#params 

    #The money shot, this will have our token that we'll use
    try { 
        Invoke-RestMethod https://public-api.wordpress.com/oauth2/token -Method Post  -Body @{client_id=$clientId; client_secret=$Secret; redirect_uri=$blogURL; grant_type="authorization_code"; code=$authCode} -ContentType "application/x-www-form-urlencoded" -ErrorAction STOP
     }
    catch{
    Write-Warning "Something didn't work"
    }
    #$global:AuthToken = ''
}
#test a token

Function Test-WordPressToken{
param($clientID=$global:clientID,$authtoken=$global:AuthToken)
    try {
        $result =Invoke-RestMethod "https://public-api.wordpress.com/oauth2/token-info?client_id=$clientID&token=$authToken" -ErrorAction STOP
        $err=$false
    }
    catch {
        Write-Warning "Double check that you're providing a Token, and not an access code";$err=$true}
    finally {
        if (-not($err)){
            Write-host "Token is valid, for the following user"
            $result
            }
    }
}



