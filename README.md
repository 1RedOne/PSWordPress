# PSWordPress v0.1
A PowerShell Module for working with WordPress via the REST API

This module makes it easy to connect to your WordPress account if you're using JetPack for self-hosted WordPress accounts, or if you're using WordPress.com hosting.  

Currently, you can use Connect-WordPressAccount to connect to your user account, and then use additional cmdlets to get your sites, your site statistics and more.

####Exposed Cmdlets

* Connect-WordPressAccount
* Get-WordPressAccount
* Get-WordPressSite
* Get-WordPressStats

####Planned cmdlets

Name  | Planned Version | Delivered?
------------- | ------------- | --- 
Get-WordPressStats | v0.1 | YES!
New-WordPressPage | v0.2
New-WordPressPost | v0.2
New-WordPressUser | v0.?


### How to use

* Create a [project on WordPress](https://developer.wordpress.com/apps/) (this works for self-hosted or WordPress.com blogs.  For Self-hosted, you need to enablee the JetPack for WordPress Add-in.)
* Clone this Repo
* Import the module
```PowerShell
Import-Module PSWordPress
```
* Use Connect-WordPressAccount to authenticate, and retrieve an Access Token.  
```PowerShell
Connect-WordPressAccount -ClientID [your app id] -BlogUrl [the redirect URL you specified]
   -ClientSecret [the secret you received when you made your project]
>Returns $Global:AccessToken, automatically passed to all subsequnet cmdlets
```
* The accessToken is safely stored using Windows API storage, in the users own roaming app data.  Subsequent cmdlets are aware of this storage location and will retrieve the key for you.
* You can test your Credential using Test-WordPressToken
```PowerShell
Test-WordPressToken -ClientID [your ID] -AuthToken [automatically retrieved if exists]
```

###Design Decisions open for discussion
We decided to move forward emulating other persistant cmdlets, like Azure and o365.  Now the user simply uses Connect-WordPressAccount once, and their key will persist in safe storage.

###Change log
v0.1 Added Get-WordPressStats

    Get-WordPressStats is now working, which will return the stats for any 
      site ID or domain you provide (assuming you have authorization)
    Added Get-WordPressSite, to resolve the current blog, and cleaned up Get-WordPressAccount.

v0.0.5 Added Connect-WordPressAccount

    Decided that having the user do a two stage auth was cludgey, so I made
     Get-WordPressAuthCode and Get-WordPressAuthToken into private functions.
    -Also moved the oAuth window into it's own private function.
    -Added private secure storage of an oAuth Access Token, so that the user
     need not register every time.  The token will be automatically detected
     when the cmdlets are subsequently reloaded.
