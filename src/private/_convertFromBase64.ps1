function _convertFromBase64 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]
        $string
    )

    end {
        [system.text.encoding]::UTF8.GetString( [System.Convert]::FromBase64String($string))
    }
}