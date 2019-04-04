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
        _invokeConsulApi -UriPath "v1/session/destroy/$SessionID"
    }

    end {
    }
}