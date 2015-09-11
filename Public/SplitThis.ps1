#first, a user has to authorize
$authURL = 'https://public-api.wordpress.com/oauth2/authorize'
#this gives you a code, you provide this auth code and then this results in a token, which can be used forever

#make a token call
#look for your API provider's page ending in /token
##
$clientID = '37880'
#need these from WPCreds.txt 
$blogURL  = 'http://www.foxdeploy.com'
$username = 'sred13@gmail.com'


