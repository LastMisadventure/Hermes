<#
.SYNOPSIS
Formats a [DateTime] to Splunk's style.

.DESCRIPTION
Formats a [DateTime] to Splunk's style.

.PARAMETER DateTime
A [DateTime] object or string that can be parsed into one.

.EXAMPLE
Format-OMTSplunkDateTime (Get-Date)

Formats the current date.

.NOTES
This was delevoped under the guidance of a 'Splunk Administrator' (of which I am not). I was given an example,
and created the following format string: '{0:MM/dd/yyyy hh:mm:sstt zzz}'.
#>
function FormatSplunkDateTime {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    param (

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ValueFromPipeline, Position = 0)]
        [ValidateNotNullOrEmpty()]
        $DateTime

    )

    $formatString = '{0:MM/dd/yyyy hh:mm:sstt zzz}'

    Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Formating '$($DateTime.ToString())' for Splunk..."

    $result = $formatString -f (Get-Date -Date $DateTime)

    Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Formated. Resultant output is: '$($result)'."

    Write-Output $result

}
