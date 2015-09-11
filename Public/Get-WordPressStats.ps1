Function Get-WordPressStats {
param($accessToken=$Global:accessToken)


Invoke-RestMethod https://public-api.wordpress.com/rest/v1.1/me/ -Method Get -Headers @{"Authorization" = "Bearer $accessToken"}

}

<#


 #ref for getting a token
$curl = curl_init( 'https://public-api.wordpress.com/oauth2/token' );
curl_setopt( $curl, CURLOPT_POST, true );
curl_setopt( $curl, CURLOPT_POSTFIELDS, array(
    'client_id' => your_client_id,
    'client_secret' => your_client_secret_key,
    'grant_type' => 'password',
    'username' => your_wpcom_username,
    'password' => your_wpcom_password,
) );
curl_setopt( $curl, CURLOPT_RETURNTRANSFER, 1);
$auth = curl_exec( $curl );
$auth = json_decode($auth);
$access_key = $auth->access_token;
 

 #ref for using a token
$access_key = 'YOUR_API_TOKEN';
$curl = curl_init( 'https://public-api.wordpress.com/rest/v1/me/' );
curl_setopt( $curl, CURLOPT_HTTPHEADER, array( 'Authorization: Bearer ' . $access_key ) );
curl_exec( $curl );


#>