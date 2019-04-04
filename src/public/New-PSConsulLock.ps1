function New-PSConsulLock {
    [OutputType([bool])]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true )]
        [Alias('ID')]
        [string]
        $SessionId,

        [Parameter(Mandatory = $true)]
        [string]
        $Key
    )

    begin {
    }

    process {


        $invokeConsulApiParams = @{
            UriPath   = "v1/kv/$Key/.lock"
            UriParams = @{acquire = $SessionId }
            Method    = 'PUT'
        }

        $res = _invokeConsulApi @invokeConsulApiParams
        [bool]$res
    }

    end {
    }
}