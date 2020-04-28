<#
.SYNOPSIS
Writes a message to a given [MessageProvider].

.DESCRIPTION
Writes a message to a given [MessageProvider].

.PARAMETER Provider
A [MessageProvider] to write to.

.EXAMPLE
# Create a provider:

$eventLogProvider = @{

   WindowsEventProvider = @{

       ProviderType = 'WindowsEventLogMessageProvider'

       LogName    = 'TestLog'

       SourceName = 'TestApp'

   }

   $provider = New-MessageProvider -Configuration $eventLogProvider

# Write a message.

Write-Message -Provider $provider['WindowsEventProvider'] -Severity Information -EventId 1337 -Message 'Diamonds in the face of nighttime.'

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

        GenerateDynamicParametersForWriteMessage -ErrorAction Stop -Provider $Provider

    }

    process {

        & ('WriteTo' + $Provider.ProviderType) $PSBoundParameters

    }

}