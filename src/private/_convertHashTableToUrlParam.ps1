function _convertHashTableToURLParam {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [hashtable]
        $hashtable
    )


    end {
        $hashtable.GetEnumerator().Foreach{ "{0}={1}" -f $_.key, $_.value } -join "&"
    }
}