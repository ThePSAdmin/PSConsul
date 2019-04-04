function _convertToBase64 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $String
    )

    end {
        [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($string))
    }
}