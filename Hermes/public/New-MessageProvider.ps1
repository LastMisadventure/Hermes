<#
.SYNOPSIS
Creates a new [MessageProvider].

.DESCRIPTION
Creates a new [MessageProvider]. These objects are consumed by `Write-Message`.

.PARAMETER Configuration
A [hashtable] reprensentation of a provider.

.PARAMETER Path
The full path to a file that contains one or more provider configurations.

.EXAMPLE
# create a [MessageProvider] from a hashtable:

$eventLogProvider = @{

   WindowsEventProvider = @{

       ProviderType = 'WindowsEventLogMessageProvider'

       LogName    = 'TestLog'

       SourceName = 'TestApp'

   }

   $providerConfig = New-MessageProvider -Configuration $eventLogProvider

.EXAMPLE
# create a [MessageProvider] from a file:

   $providerConfig = New-MessageProvider -Path providers.psd1

.NOTES
#>

function New-MessageProvider {

    [CmdletBinding(SupportsShouldProcess, PositionalBinding, ConfirmImpact = 'low', DefaultParameterSetName = 'ConfigDataByFile')]

    param (

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ValueFromPipeline, ParameterSetName = 'ConfigDataByHashTable')]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Configuration,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ValueFromPipeline, ParameterSetName = 'ConfigDataByFile')]
        [ValidateNotNullOrEmpty()]
        [System.IO.FileInfo]
        $Path

    )

    if ($PsCmdlet.ShouldProcess("Create new message provider")) {

        if ($PsCmdlet.ParameterSetName -eq 'ConfigDataByFile') {

            $configData = Import-PowerShellDataFile -Path $Path -ErrorAction Stop

        } else {

            $configData = $Configuration

        }

        $providersHT = @{ }

        $configData.Keys | ForEach-Object {

            $_currentConfig = $_

            $_providerType = $configData.Item($_currentConfig).ProviderType

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: [$($_currentConfig)]: Creating a new provider instance of type '$($_providerType)'..."

            $_providerProperties = $configData.Item($_currentConfig)

            $_provider = New-Object -ErrorAction Stop -TypeName $_providerType -Property $_providerProperties

            $providersHT.Add($_currentConfig, $_provider)

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Created new provider instance."

        }

        Write-Output $providersHT

    }

}
