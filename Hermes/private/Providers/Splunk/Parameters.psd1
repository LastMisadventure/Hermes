@{

    SplunkProvider = @{

        Params = @(

            @{

                Name                            = 'Message'

                Mandatory                       = $true

                Position                        = 1

                ValueFromPipelineByPropertyName = $true

                ParamTypeName                   = 'object'

            }

        )

    }

}