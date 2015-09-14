<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   
.EXAMPLE
   Get-WordPressSite -domainName FoxDeploy.com


ID                : 56752040
name              : FoxDeploy.com
description       : PowerShell tools and tool-making Tails from the fox hole
URL               : http://foxdeploy.com
post_count        : 184
subscribers_count : 15
DomainName        : FoxDeploy.com

Get basic information about a certain site, useful for piping into another cmdlet
#>
Function Get-WordPressSite {
[CmdletBinding()]
param([Parameter(ValueFromPipelineByPropertyName=$true,
                   Position=0)]$domainName,
                   $accessToken=$Global:accessToken)
    
    $defaultDisplaySet = 'ID','name','Description','URL','post_count','subscribers_count'

    #Create the default property display set
    $defaultDisplayPropertySet = New-Object System.Management.Automation.PSPropertySet(‘DefaultDisplayPropertySet’,[string[]]$defaultDisplaySet)
    $PSStandardMembers = [System.Management.Automation.PSMemberInfo[]]@($defaultDisplayPropertySet)


    if ($domainName){
    $sites = Invoke-RestMethod https://public-api.wordpress.com/rest/v1.1/sites/$domainName -Method Get -Headers @{"Authorization" = "Bearer $accessToken"} | select ID,name,Description,URL,post_count,subscribers_count,@{Name='DomainName';Exp={$domainName}} -ExcludeProperty options
    }
    else{
                    # https://public-api.wordpress.com/rest/v1.1/me/sites
    $sites = Invoke-RestMethod "https://public-api.wordpress.com/rest/v1.1/me/sites" -Headers @{"Authorization" = "Bearer $accessToken"}  #| 
            #select ID,name,Description,URL,post_count,subscribers_count,@{Name='DomainName';Exp={$domainName}} -ExcludeProperty options
    }

    ForEach ($site in $sites.sites){
        $site.PSObject.TypeNames.Insert(0,'WordPressSite')
        $site | Add-Member MemberSet PSStandardMembers $PSStandardMembers

        #Show object that shows only what I specified by default
        $site
        }
}


