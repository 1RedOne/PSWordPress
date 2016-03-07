#$here = Split-Path -Parent $MyInvocation.MyCommand.Path
#$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
#. "$here\$sut"

Import-Module C:\git\WordPress\PSWordPress.psm1
Describe "Connect-WordPressAccount" {
        It "Outputs Cached cred" {
            {Connect-WordPressAccount }| Should Be 'Found cached cred'
        }

        It "outputs ham" {
        	{'ham'} | Should Be 'ham'
        }
    }

