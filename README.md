# PSWordPress
A PowerShell Module for working with WordPress via the REST API

This module successfully handles the oAuth login process to connect a user to retrieve the Authentication Token necessary to work with a WordPress blog using the WordPress REST Api.

Eventually, I will be adding cmdlets to pull down Blog Stats, make a new post, and things like that.  Currently only login is handled.

# How to use

* Create a [project on WordPress](https://developer.wordpress.com/apps/) (this works for self-hosted or WordPress.com blogs.  For Self-hosted, you need to enablee the JetPack for WordPress Add-in.)
* Clone this Repo
* Import the module
```PowerShell
Import-Module PSWordPress
```
* Authenticate to WordPress using oAuth by running the cmdlet, this will return $AuthCode
```PowerShell
Get-WordPressAuthCode -ClientID [your app id] -BlogUrl [the redirect URL you specified]
>Returns $Global:AuthCode, needed for the next step 
```
* Use the AccessCode you're given to request a permanent Authentication Token
```PowerShell
Get-WordPressAuthToken -ClientID [your app id] -BlogUrl [the redirect URL you specified] `
  -ClientSecret [the secret you received when you made your project] `
  -AuthCode $AuthCode
  
>Returns $Global:AuthToken, keep this safe, this is your oAuth Token
```
* Test your Credential using Test-WordPressToken
```PowerShell
Test-WordPressToken -ClientID [your ID] -AuthToken [the token you received from the previous step]
```

#Design Decisions
Currently, I'm exposing the oAuth process to the user.  I haven't decided yet if this is a good idea, as it might be easier to abstract it all away behind a Connect-WordPress account type cmdlet, similar to the way that Office 365 handles it's authentication.
