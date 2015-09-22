#Get public and private function definition files.
    $PublicFunction  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -Exclude *tests* -ErrorAction SilentlyContinue )
    $PrivateFunction = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -Exclude *tests* -ErrorAction SilentlyContinue )
    
#Dot source the files
    Foreach($import in @($PublicFunction + $PrivateFunction))
    {
        "importing $import"
        Try
        {
            . $import.fullname
        }
        Catch
        {
            Write-Error -Message "Failed to import function $($import.fullname): $_"
        }
    }

# Here I might...
    # Read in or create an initial config file and variable
    # Export Public functions ($Public.BaseName) for WIP modules
    # Set variables visible to the module and its functions only

    #Initialize our variables.  I know, I know...

    $configDir = "$Env:AppData\WindowsPowerShell\Modules\PSWordPress\0.1\Config.ps1xml"
    
    if (Test-Path $configDir){
        Write-Verbose "Cached Credential found, importing"

        Try
        {
            #Import the config
            $password = Import-Clixml -Path $configDir -ErrorAction STOP | ConvertTo-SecureString
        
         }
        catch {
        Write-Warning "Corrupt Password file found, rerun with -Force to fix this"
        }
   
           
    if ($password){Get-DecryptedValue -inputObj $password -name accessToken}
    }
    else{
    Write-Output "Run Connect-WordPressAccount to begin"
    }


Export-ModuleMember -Function $PublicFunction.Basename