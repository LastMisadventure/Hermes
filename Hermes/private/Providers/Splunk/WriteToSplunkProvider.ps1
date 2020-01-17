function WriteToSplunkProvider {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    param (

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Request

    )

    try {

        $authHeader = NewSplunkAuthorizationHeader -Token $Request.Provider.Token.Guid

        $envelope = [PSCustomObject] [ordered] @{

            host       = $env:computername

            event      = $Request.Message

            index      = $Request.Provider.IndexName

            sourcetype = $Request.Provider.SourceType

        }

        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Created new envelope object."

        $bodyAsJson = ConvertTo-Json -Compress -Depth $Request.Provider.ObjectDepthLimit -InputObject $envelope

        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Inserted payload."

        $params = @{

            Uri         = $Request.Provider.Uri

            Method      = 'Post'

            Headers     = $authHeader

            Body        = $bodyAsJson

            ErrorAction = 'Stop'

        }

        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Transmitting message..."

        $result = Invoke-RestMethod @params

        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Transmitted message."

        if ($result.text -ne 'Success') {

            Write-Error -ErrorAction Stop -Message "[$($MyInvocation.MyCommand.Name)]: Unexpected response from server."

        }

    } catch {

        $PSCmdlet.ThrowTerminatingError($PSitem)

    }

    Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Server has acknowledged the message."

}
