function GenerateDynamicParametersForWriteMessage {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    param (

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [MessageProvider]
        $Provider

    )

    try {

        $dyanmicParams = $Providers_Parameters[$Provider.ProviderType].Params | ForEach-Object { Write-Output (New-DynamicParameter @_) }

        New-DynamicParameterDictionary -DynamicParameter $dyanmicParams

    } catch {

        $PSCmdlet.ThrowTerminatingError($PSItem)

    }

}