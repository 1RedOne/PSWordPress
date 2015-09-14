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
Function New-WordPressPost {
[Cmdletbinding()]
param(
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,
                   Position=0)]
                   [Alias("domainName")] $ID,$postTitle,$content,$tags,$categories,
                   $accessToken=$Global:accessToken)

#Need some params

# /sites/$site/posts/new

<#

SAMPLE
curl \
 -H 'authorization: Bearer YOUR_API_TOKEN' \
 --data-urlencode 'title=Hello World' \
 --data-urlencode 'content=Hello. I am a test post. I was created by the API' \
 --data-urlencode 'tags=tests' \
 --data-urlencode 'categories=API' \


date
(iso 8601 datetime) The post's creation time. 

title
(html) The post title. 

content
(html) The post content. 

excerpt
(html) An optional post excerpt. 

slug
(string) The name (slug) for the post, used in URLs. 

author
(string) The username or ID for the user to assign the post to. 

publicize
(array|bool) True or false if the post be publicized to external services. An array of services if we only want to publicize to a select few. Defaults to true. 

publicize_message
(string) Custom message to be publicized to external services. 

status
(string) 
publish:

(default) Publish the post.

private:

Privately publish the post.

draft:

Save the post as a draft.

pending:

Mark the post as pending editorial approval.

auto-draft:

Save a placeholder for a newly created post, with no content.
 

sticky
(bool) 
false:

(default) Post is not marked as sticky.

true:

Stick the post to the front page.
 

password
(string) The plaintext password protecting the post, or, more likely, the empty string if the post is not password protected. 

parent
(int) The post ID of the new post's parent. 

type
(string) The post type. Defaults to 'post'. Post types besides post and page need to be whitelisted using the rest_api_allowed_post_types filter. 

categories
(array|string) Comma-separated list or array of categories (name or id) 

tags
(array|string) Comma-separated list or array of tags (name or id) 

format
(string) 
default:

(default) Use default post format

standard:

Standard

aside:

Aside

chat:

Chat

gallery:

Gallery

link:

Link

image:

Image

quote:

Quote

status:

Status

video:

Video

audio:

Audio
 

featured_image
(string) The post ID of an existing attachment to set as the featured image. Pass an empty string to delete the existing image. 

media
(media) An array of files to attach to the post. To upload media, the entire request should be multipart/form-data encoded. Multiple media items will be displayed in a gallery. Accepts jpg, jpeg, png, gif, pdf, doc, ppt, odt, pptx, docx, pps, ppsx, xls, xlsx, key. Audio and Video may also be available. See allowed_file_types in the options response of the site endpoint. Errors produced by media uploads, if any, will be in `media_errors` in the response. 

Example:
curl \
--form 'title=Image Post' \
--form 'media[0]=@/path/to/file.jpg' \
--form 'media_attrs[0][caption]=My Great Photo' \
-H 'Authorization: BEARER your-token' \
'https://public-api.wordpress.com/rest/v1/sites/123/posts/new' 

media_urls
(array) An array of URLs for images to attach to a post. Sideloads the media in for a post. Errors produced by media sideloading, if any, will be in `media_errors` in the response. 

media_attrs
(array) An array of attributes (`title`, `description` and `caption`) are supported to assign to the media uploaded via the `media` or `media_urls` properties. You must use a numeric index for the keys of `media_attrs` which follow the same sequence as `media` and `media_urls`. 

Example:
curl \
--form 'title=Gallery Post' \
--form 'media[]=@/path/to/file1.jpg' \
--form 'media_urls[]=http://exapmple.com/file2.jpg' \
 \
--form 'media_attrs[0][caption]=This will be the caption for file1.jpg' \
--form 'media_attrs[1][title]=This will be the title for file2.jpg' \
-H 'Authorization: BEARER your-token' \
'https://public-api.wordpress.com/rest/v1/sites/123/posts/new' 

 -Body @{title=$postTitle; content=$content; tags='tests'; categories='api'} -ContentType "application/x-www-form-urlencoded" -ErrorAction STOP
     }

#>



    try { 
    $result = Invoke-RestMethod https://public-api.wordpress.com/rest/v1.1/sites/$ID/posts/new  `
                -Method Post -Headers @{"Authorization" = "Bearer $accessToken"} `
                -Body @{title=$postTitle; content=$content; tags='tests'; categories='api'} `
                    -ContentType "application/x-www-form-urlencoded" -ErrorAction STOP }
    catch{write-warning "Shit broke"}
        
}