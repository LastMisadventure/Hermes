@{

    SMTPProvider = @{

        Params = @(

            @{

                Name                            = 'Message'

                Mandatory                       = $true

                Position                        = 1

                ValueFromPipelineByPropertyName = $true

                ParamTypeName                   = 'string'

            },

            @{

                Name                            = 'Subject'

                Mandatory                       = $true

                Position                        = 1

                ValueFromPipelineByPropertyName = $true

                ParamTypeName                   = 'string'

            }

        )

    }

}