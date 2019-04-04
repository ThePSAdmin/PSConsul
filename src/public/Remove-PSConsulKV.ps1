function Remove-PSConsulKV {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]
        $Name,

        [Parameter(Mandatory=$false)]
        [switch]
        $Recurse
    )

    end {
        $invokeConsulApiParams = @{
            UriPath = "v1/kv/$Name"
            Method = 'DELETE'
        }
        if ($Recurse) {
            $invokeConsulApiParams["UriParams"] = @{recurse='true'}
        }
        _invokeConsulApi @invokeConsulApiParams
    }
}