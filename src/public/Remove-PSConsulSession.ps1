function Remove-PSConsulSession {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Alias('ID')]
        [string]
        $SessionID
    )

    begin {
    }

    process {

        $invokeConsulApiParams = @{
            UriPath = "v1/session/destroy/$SessionID"
        }

        _invokeConsulApi @invokeConsulApiParams
    }

    end {
    }
}