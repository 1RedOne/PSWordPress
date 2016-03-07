<#
.Synopsis
   Returns a list of all Posts, useful to send to other cmdlets
.DESCRIPTION
   Long description
.EXAMPLE
   Get-WordPressSite -domainName FoxDeploy.com | Get-WordPressPost | select -First 5 | ft -wrap
Found 135 posts

  ID Author    date                      title                      status  short_URL              Activity(Comments)
  -- ------    ----                      -----                      ------  ---------              ------------------
2489 FoxDeploy 2015-09-08T04:00:00-05:00 Part IV &#8211; PowerShell publish http://wp.me/p3Q7Nu-E9                  6
2483 FoxDeploy 2015-08-25T10:56:44-05:00 &#8216;GUI your life with  publish http://wp.me/p3Q7Nu-E3                  0
2454 FoxDeploy 2015-08-03T11:11:10-05:00 New in Windows 10: Changin publish http://wp.me/p3Q7Nu-DA                  2
2216 FoxDeploy 2015-07-31T15:22:22-05:00 Recovering your Dedeuped F publish http://wp.me/p3Q7Nu-zK                 30

Get basic information about the posts on your site, including comment activity
.EXAMPLE
   Another example of how to use this cmdlet
#>
Function Get-WordPressPost {
[CmdletBinding()]
param(
[Parameter(Mandatory=$true,
           ValueFromPipelineByPropertyName=$true,
           Position=0)]
           $domainName,
           [int]$NumberToReturn=20,
           $accessToken=$Global:accessToken)


$results = Invoke-RestMethod https://public-api.wordpress.com/rest/v1.1/sites/$domainName/posts/?number=$NumberToReturn -Method Get -Headers @{"Authorization" = "Bearer $accessToken"} 
Write-output "Found $($results.found) posts"
$results.posts | select ID,@{n='Author';Exp={$_.author.Name}},date,@{n='title';Exp={$_.title[0..25] -join ''}},status,short_URL,@{n='Activity(Comments)';Exp={$_.Discussion.Comment_Count}}

}
