function WriteToWindowsEventLogMessageProvider {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    param (

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Request

    )

    $params = @{

        LogName     = $Request.Provider.LogName

        Source      = $Request.Provider.SourceName

        EventId     = $Request.EventId

        Message     = $Request.Message

        EntryType   = $Request.Severity

        ErrorAction = 'Stop'

    }

    Write-EventLog @params

}