Describe "Get-WordPressAccount" {
    It "Should display account info if it finds a token" {
        get-wordpressaccount | Should Not BeNullOrEmpty
    }
    
    It "Should error if an incorrect token is passed" {
        {get-wordpressaccount -accessToken ham } | Should Throw
    }
}
