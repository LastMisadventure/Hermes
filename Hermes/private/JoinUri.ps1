function JoinUri {

    [CmdletBinding(ConfirmImpact = 'low', PositionalBinding)]

    [OutputType([uri])]

    param (

        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Uri,

        [Parameter(Mandatory, Position = 1)]
        [ValidateNotNullOrEmpty()]
        [string]
        $ChildUri

    )

    Write-Output ([uri] ($Uri.ToString() + "/" + $ChildUri.ToString()))

}