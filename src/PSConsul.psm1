get-childitem $PSScriptRoot\Private\*.ps1 | Foreach-Object {
    . $_.FullName 
}
get-childitem $PSScriptRoot\Public\*.ps1 | Foreach-Object {
    . $_.FullName 
    Export-ModuleMember -Function $($_.BaseName)
}



