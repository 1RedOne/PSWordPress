Function Test-WordPressToken{
<#
.Synopsis
   This is used to test the current token
.DESCRIPTION
   Used to ensure that token stored is valid for the user
.EXAMPLE
   Test-WordPressToken
#>[CmdletBinding()]
param($clientID=$global:clientID,$accessToken=$global:accessToken)
    try {
        $result =Invoke-RestMethod "https://public-api.wordpress.com/oauth2/token-info?client_id=$clientID&token=$accessToken" -ErrorAction STOP
        $err=$false
    }
    catch {
        Write-Warning "Double check that you're providing a Token, and not an access code";$err=$true}
    finally {
        if (-not($err)){
            Write-Output "Token is valid, for the following user"
            $result
            }
    }
}
