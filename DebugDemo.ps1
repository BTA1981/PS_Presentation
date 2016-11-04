$csv = import-csv "c:\temp\PS\DetaEngineers.csv"
$ExportCSV = "C:\temp\PS\DetaEngineersNew.csv"
$domain = 'client.nl'
$newdomain = 'ricoh.nl'
$UserArray = @() # Create an empty array


ForEach ($User in $csv) { 
    
    Write-Output "Changing UPN [$($User.UserPrincipalName)].."
    
    $TempVariable = $User.UserPrincipalName # Create a temporary variable
    $TempVariable = $($TempVariable.Replace($domain,$newdomain)) # Use Replace method to manipulate string
    
    $UserArray += New-Object -TypeName PSObject -Property @{ # Fill Array with custom objects
        'Name' = $($User.Name)
        'SAMaccountName' = $($User.Samaccountname)
        'UPN' = $TempVariable
        'SID' = $($User.SID)
    } # End PS Object
} # End ForEach

# Export contents of UserArray to CSV file
$UserArray | Sort-Object Name | Select-Object Name,UPN | Export-Csv $ExportCSV -Force -NoTypeInformation
