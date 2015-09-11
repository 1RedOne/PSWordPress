Function Get-WordPressAccount {
param($accessToken=$Global:accessToken,[switch]$Insights)

if ($Insights){
    Invoke-RestMethod https://public-api.wordpress.com/rest/v1.1/insights -Method Get -Headers @{"Authorization" = "Bearer $accessToken"}
    }

Invoke-RestMethod https://public-api.wordpress.com/rest/v1.1/me/ -Method Get -Headers @{"Authorization" = "Bearer $accessToken"}

}
