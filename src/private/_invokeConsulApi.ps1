function _invokeConsulApi {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]
        $UriPath,

        [Parameter(Mandatory=$false)]
        [hashtable]
        $UriParams,

        [Parameter(Mandatory=$false)]
        [string]
        $Body,

        [Parameter(Mandatory=$false)]
        [ValidateSet('PUT','POST','DELETE','GET')]
        [string]
        $Method = 'GET'
    )

    begin {
        $baseUri = [System.UriBuilder]::New("http","localhost",8500)
    }

    process {

        $baseUri.Path = "$UriPath"

        if ($PSBoundParameters["UriParams"]) {
            $baseUri.Query = _convertHashTableToURLParam $UriParams
        }

        $invokeRestMethodParams = @{
            uri = $baseUri.Uri
            Method = $Method
        }

        if ($PSBoundParameters.Body) {
            $invokeRestMethodParams["Body"] = $Body
        }

        $res = Invoke-RestMethod @invokeRestMethodParams

        $res

    }

    end {
    }
}