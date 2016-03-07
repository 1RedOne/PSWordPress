<#
.Synopsis
    Use this cmdlet to retrive details on your WordPress account for management via PowerShell
.DESCRIPTION
    With one cmdlet, you can retrive the details about your WordPress account via the REST API.  
.EXAMPLE
    Get-WordPressAccount -Insights
    
    This will retrive the Additional properties that can be pulled back for your WordPress Account
.EXAMPLE
    Get-WordPressAccount

    This will retrive the Standard properties for your WordPress Account
#>
Function Get-WordPressAccount {
[Cmdletbinding()]
param($accessToken=$Global:accessToken,[switch]$Insights)

if ($Insights){
    Invoke-RestMethod https://public-api.wordpress.com/rest/v1.1/insights -Method Get -Headers @{"Authorization" = "Bearer $accessToken"}
    }

try {Invoke-RestMethod https://public-api.wordpress.com/rest/v1.1/me/ -Method Get -Headers @{"Authorization" = "Bearer $accessToken"} -ErrorAction Stop}
catch{throw "Check Credentials, error 400"}

}
