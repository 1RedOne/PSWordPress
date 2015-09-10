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