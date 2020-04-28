function WriteToPRTGBasicHttpPushSensorProvider {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'medium')]

    param (

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Request

    )

    try {

        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Building uri..."

        $ssl = ''

        if ($Request.Provider.UseSSL) {

            $ssl = 's'

        }

        $parentPart = "http$($ssl)://$($Request.Provider.HostName):$($Request.Provider.Port)"

        $childPart = ("text=" + $Request.Message)

        if ($Request.ContainsKey('Value')) {

            $childPart = ('Value=' + $Request.Value.ToString() + '&text=' + $Request.Message)

        }

        $invocationUri = JoinUri -Uri $parentPart -ChildUri ($Request.Provider.Token + "?" + $childPart)

        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Built uri: '$($invocationUri.OriginalString)'."

        $params = @{

            Uri         = $invocationUri

            Method      = 'Post'

            ContentType = "application/x-www-form-urlencoded"

            ErrorAction = 'Stop'

        }

        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Posting sensor result..."

        Invoke-WebRequest @params

        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Posted sensor result."

    } catch {

        $PSCmdlet.ThrowTerminatingError($PSitem)

    }

}