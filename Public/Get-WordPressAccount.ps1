Function Get-WordPressAccount {
param($accessToken=$Global:accessToken)


Invoke-RestMethod https://public-api.wordpress.com/rest/v1.1/me/ -Method Get -Headers @{"Authorization" = "Bearer $accessToken"}

}
