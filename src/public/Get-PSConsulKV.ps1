function Get-PSConsulKV {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [string]
        $Name,

        [Parameter()]
        [switch]
        $Recurse,

        [Parameter()]
        [switch]
        $KeyNameOnly
    )

    end {

        $invokeConsulApiParams = @{
            UriPath =  "v1/kv/$Name"
        }

        $uriParams = @{}

        if ($KeyNameOnly) {
            $uriParams['keys'] = 'true'
        }

        if ($Recurse) {
            $uriParams["recurse"] = 'true'
        }
        
        $invokeConsulApiParams["UriParams"] = $uriParams
        $result = _invokeConsulApi @invokeConsulApiParams
        foreach ($r in $result) {
            if (-not [string]::IsNullOrEmpty($r.Value)) {
                $r | Add-Member -MemberType NoteProperty -Name "ValueString" -Value $(_convertFromBase64 $r.Value)
            }
            $r
        }
    }
}