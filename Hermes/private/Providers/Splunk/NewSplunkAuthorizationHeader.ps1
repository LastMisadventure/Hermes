function NewSplunkAuthorizationHeader {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    param (

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ValueFromPipeline, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [guid]
        $Token

    )

    try {

        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Generating Splunk authentication header."

        $headers = New-Object -ErrorAction Stop -TypeName "System.Collections.Generic.Dictionary[[string], [string]]"

        $headers.Add("Authorization", "Splunk $($Token.Guid.ToUpper())")

        Write-Output $headers

        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Generated Splunk authentication header."

    }

    catch {

        Write-Error -ErrorAction Stop -Exception $_.Exception

    }

}