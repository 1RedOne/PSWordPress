Function Get-WordPressAuthCode{
param($ClientID,$blogURL)
    $url = "https://public-api.wordpress.com/oauth2/authorize?client_id=$clientID&redirect_uri=$blogURL&response_type=code"
     
    Show-OAuthWindow

    #After this, there should be a variable called $uri, which has our code!!!!!!!!!!!
    #(?<=code=)(.*)(?=&)
    $regex = '(?<=code=)(.*)(?=&)'
    $authCode  = ($uri | Select-string -pattern $regex).Matches[0].Value
    "new auth code $authCode"
    $global:authCode = $authCode
    Write-output "Received an authCode, $authcode"
}
#Next, get an access token by presenting the code