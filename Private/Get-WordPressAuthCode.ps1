Function Get-WordPressAuthCode{
param($ClientID,$blogURL)
    $url = "https://public-api.wordpress.com/oauth2/authorize?client_id=$clientID&redirect_uri=$blogURL&scope=global&response_type=code"
    
    If($ClientID -eq $null){
        Write-warning "Must provide the `-ClientID of your WordPress App to display a login Window"
        break}

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