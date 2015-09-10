#first, a user has to authorize
$authURL = 'https://public-api.wordpress.com/oauth2/authorize'
#this gives you a code, you provide this auth code and then this results in a token, which can be used forever

#make a token call
#look for your API provider's page ending in /token

$clientID = '37880'
#need these from WPCreds.txt 
$blogURL  = 'http://www.foxdeploy.com'
$username = 'sred13@gmail.com'

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



