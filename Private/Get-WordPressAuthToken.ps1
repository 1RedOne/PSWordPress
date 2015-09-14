Function Get-WordPressAuthToken{
[CmdletBinding()]
param($ClientID,$blogURL,$clientSecret,$authCode)
#params 

    #The money shot, this will have our token that we'll use
    try { 
        $result = Invoke-RestMethod https://public-api.wordpress.com/oauth2/token -Method Post -Body @{client_id=$clientId; client_secret=$clientSecret; redirect_uri=$blogURL; grant_type="authorization_code"; code=$authCode} -ContentType "application/x-www-form-urlencoded" -ErrorAction STOP
     }
    catch{
    Write-Warning "Something didn't work"
    Write-debug "Test the -body params for the Rest command"
    }
    
    Write-Debug 'go through the results of $result, looking for our token'
    if ($result.access_token){
        Write-Output "Updated Authorization Token"
        $result
        $global:accessToken = $result.access_token}
    
}
#test a token