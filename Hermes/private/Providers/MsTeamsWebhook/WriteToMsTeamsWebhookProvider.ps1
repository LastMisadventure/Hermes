function WriteToMsTeamsWebhookProvider {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    param (

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Request

    )

    try {

        $bodyAsJson = ConvertTo-Json -ErrorAction Stop -Compress -Depth $Request.Provider.ObjectDepthLimit -InputObject $Request.Message

        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Building uri..."

        $splat = @{

            Uri         = $Request.Provider.Webhook

            Method      = 'Post'

            ContentType = 'application/vnd.microsoft.teams.card.o365connector'

            Body        = $bodyAsJson

        }

        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Built uri."

        Invoke-WebRequest @splat

    } catch {

        $PSCmdlet.ThrowTerminatingError($PSitem)

    }

}