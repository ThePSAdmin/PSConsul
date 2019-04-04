function New-PSConsulSession {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [string]
        $Name,

        [Parameter()]
        [int]
        $TTL = 15
    )

    end {
        $body = @{
            ttl = "{0}s" -f $TTL
        }
        if ($PSBoundParameters["Name"]) {
            $body["Name"] = "Name"
        }

        $body = $body | ConvertTo-Json

        _invokeConsulApi -UriPath "v1/session/create" -Method PUT -Body $body
    }
}