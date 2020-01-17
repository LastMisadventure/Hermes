<#
.SYNOPSIS
Short description

.DESCRIPTION
Long description

.PARAMETER Path
The full path to a file.

.EXAMPLE
An example

.NOTES
General notes
#>

function New-MessageProvider {

    [CmdletBinding(SupportsShouldProcess, PositionalBinding, ConfirmImpact = 'low')]

    param (

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [System.IO.FileInfo]
        $Path

    )

    if ($PsCmdlet.ShouldProcess("Create new message provider")) {

        $configData = Import-PowerShellDataFile -Path $Path -ErrorAction Stop

        $providersHT = @{ }

        $configData.Keys | ForEach-Object {

            $_currentConfigKey = $_

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: [$($_currentConfigKey)]: Creating a new provider instance of type '$($configData.Item($_currentConfigKey).ProviderType)'..."

            $_provider = New-Object -ErrorAction Stop -TypeName $configData.Item($_currentConfigKey).ProviderType -Property $configData.Item($_currentConfigKey)

            $providersHT.Add($_, $_provider)

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Created new provider."

        }

        Write-Output $providersHT

    }

}
