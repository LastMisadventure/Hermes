function ConcatenateMessageDocumentation {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    param (

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Message,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [uri]
        $HelpUri,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [int]
        $NewLineSpacingCount

    )

    try {

        [string] $_newLineSpacing = ''

        0..$NewLineSpacingCount | ForEach-Object {

            $_newLineSpacing += '`n'

        }

        Write-Output ($Message + $_newLineSpacing + $HelpUri.OriginalString)

    } catch {

        $PSCmdlet.ThrowTerminatingError($PSItem)

    }

}
