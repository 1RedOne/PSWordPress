<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
Function Get-WordPressSite {
[CmdletBinding()]
param([Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,
                   Position=0)]$domainName,
                   $accessToken=$Global:accessToken)


Invoke-RestMethod https://public-api.wordpress.com/rest/v1.1/sites/$domainName -Method Get -Headers @{"Authorization" = "Bearer $accessToken"} | select *,@{Name='DomainName';Exp={$domainName}}

}
