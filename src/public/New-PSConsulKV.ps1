function New-PSConsulKV {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]
        $Name,

        [Parameter(Mandatory=$false)]
        [string]
        $Value
    )

    end {
        _invokeConsulApi -UriPath "v1/kv/$Name" -Method PUT -Body $value
    }
}