@{

    WindowsEventLogMessageProvider = @{

        Params = @(

            @{

                Name                            = 'Message'

                Mandatory                       = $true

                Position                        = 1

                ValueFromPipelineByPropertyName = $true

                ParamTypeName                   = 'string'

            },

            @{

                Name                            = 'Severity'

                Mandatory                       = $true

                Position                        = 2

                ValueFromPipelineByPropertyName = $true

                ParamTypeName                   = 'System.Diagnostics.EventLogEntryType'

            },

            @{

                Name                            = 'EventId'

                Mandatory                       = $true

                Position                        = 2

                ValueFromPipelineByPropertyName = $true

                ParamTypeName                   = 'int'

            }

        )

    }

}