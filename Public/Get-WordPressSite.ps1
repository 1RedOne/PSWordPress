<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Get-WordPressSite -domainName FoxDeploy.com


ID                : 56752040
name              : FoxDeploy.com
description       : PowerShell tools and tool-making Tails from the fox hole
URL               : http://foxdeploy.com
post_count        : 184
subscribers_count : 15
DomainName        : FoxDeploy.com

Get basic information about your site, useful for piping into another cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
Function Get-WordPressSite {
[CmdletBinding()]
param([Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,
                   Position=0)]$domainName,
                   $accessToken=$Global:accessToken)


Invoke-RestMethod https://public-api.wordpress.com/rest/v1.1/sites/$domainName -Method Get -Headers @{"Authorization" = "Bearer $accessToken"} | select ID,name,Description,URL,post_count,subscribers_count,@{Name='DomainName';Exp={$domainName}} -ExcludeProperty options

}
