function Write-Message {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    param (

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [MessageProvider]
        $Provider

    )

    dynamicParam {

        GenerateDynamicParametersForWriteMessage $Provider

    }

    process {

        & ('WriteTo' + $Provider.ProviderType) $PSBoundParameters

    }

}