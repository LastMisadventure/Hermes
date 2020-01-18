function WriteToSMTPProvider {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    param (

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Request

    )

    try {

        $params = @{

            SmtpServer = $Request.Provider.SmtpServer

            To         = $Request.Provider.To

            From       = $Request.Provider.From

            Port       = $Request.Provider.Port

            Priority   = $Request.Provider.Priority

            Body       = $Request.Message

            Subject    = $Request.Subject

            BodyAsHTML = $Request.Provider.BodyAsHTML

        }

        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Sending email message..."

        Send-MailMessage @params

        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Sent email message."

    } catch {

        $PSCmdlet.ThrowTerminatingError($PSItem)

    }

}