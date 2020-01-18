<#
.SYNOPSIS
Writes a message to a given [MessageProvider].

.DESCRIPTION
Writes a message to a given [MessageProvider].

.PARAMETER Provider
Parameter description

.EXAMPLE
# create a provider:

$eventLogProvider = @{

   WindowsEventProvider = @{

       ProviderType = 'WindowsEventLogMessageProvider'

       LogName    = 'TestLog'

       SourceName = 'TestApp'

   }

   $providerConfig = New-MessageProvider -Configuration $eventLogProvider

   # write a message
Write-Message -Provider $providerConfig['WindowsEventProvider'] -Severity Information -EventId 1337 -Message 'Diamonds in the face of nighttime.'

.NOTES
#>

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