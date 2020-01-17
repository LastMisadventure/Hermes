function WriteToSplunk {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    param (

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object]
        $Message,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [uri]
        $Endpoint,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string]
        $IndexName,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string]
        $SourceType,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [guid]
        $Token,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [int64]
        $ObjectDepthLimit

    )

    process {

        try {

            $authenticationHeader = NewSplunkAuthorizationHeader -ErrorAction Stop -AccessToken $Token

            $envelope = [PSCustomObject] [ordered] @{

                host       = $env:computername

                event      = $Message

                index      = $IndexName

                sourcetype = $SourceType

            }

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Created new envelope object."

            $bodyAsJson = ConvertTo-Json -Compress -Depth $ObjectDepthLimit -ErrorAction Stop -InputObject $envelope

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Inserted payload."

            $ServicePoint = [System.Net.ServicePointManager]::FindServicePoint($Endpoint)

            $params = @{

                Uri         = $Endpoint

                Method      = 'Post'

                Headers     = $authenticationHeader

                Body        = $bodyAsJson

                ErrorAction = 'Stop'

            }

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Transmitting message..."

            $result = Invoke-RestMethod @params

            $ServicePoint.CloseConnectionGroup("") | Out-Null

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Transmitted message."

            if ($result.text -ne 'Success') {

                Write-Error -ErrorAction Stop -Message "[$($MyInvocation.MyCommand.Name)]: Unexpected response from server."

            }

        }

        catch {

            $PSCmdlet.ThrowTerminatingError($PSitem)

        }

        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Server has acknowledged the message."

    }

}