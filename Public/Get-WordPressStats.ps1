<#
.Synopsis
   Use this cmdlet to retrieve up-to-the-minute statistics from your Wordpress site
.DESCRIPTION
   If you're using WordPress.com hosting, or have JetPack for WordPress enabled on your self-hosted site, you can use this cmdlet to get the visitors to your blog
.EXAMPLE
   PS C:\git\WordPress> Get-WordPressStats -domainName FoxDeploy.com


views_today          : 507
views_yesterday      : 953
views_best_day       : 2015-08-03
views_best_day_total : 4618
views                : 220094
visitors_today       : 276
visitors_yesterday   : 594
visitors             : 136381
.EXAMPLE
Get-WordPressSite -domainName FoxDeploy.com | Get-WordPressStats


views_today          : 519
views_yesterday      : 953
views_best_day       : 2015-08-03
views_best_day_total : 4618
views                : 220094
visitors_today       : 284
visitors_yesterday   : 594
visitors             : 136387

You can also pipe the output of Get-WordPressSite into this cmdlet, rather than provide the domain name or ID by hand.
.LINK
Code for this module can always be found here on GitHub
https://github.com/1RedOne/WordPress
#>
Function Get-WordPressStats {
[Cmdletbinding()]
param(
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [Alias("domainName")] $ID,
                   $accessToken=$Global:accessToken)


Invoke-RestMethod https://public-api.wordpress.com/rest/v1.1/sites/$ID/stats -Method Get -Headers @{"Authorization" = "Bearer $accessToken"}  | Select-object -ExpandProperty Stats |Select-Object Views*,Visit*

}
