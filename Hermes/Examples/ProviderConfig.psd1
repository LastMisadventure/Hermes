# This is an example of storing multiple provider configurations in the same file See https://github.com/LastMisadventure/ps-OMTLog/blob/master/README.md.

@{

    # Providers can be named anything.

    ExampleWindowsEventLog     = @{

        ProviderType = 'WindowsEventLogMessageProvider'

        # Appears under 'Applications and Service Logs' in the Windows Event Log.
        LogName      = 'TestLog'

        SourceName   = 'TestSource'

    }

    ExamplePRTGBasicPushSensor = @{

        ProviderType = 'PRTGBasicHttpPushSensorProvider'

        HostName     = 'prtg.domain.com'

        Port         = 5050

        UseSSL       = $false

        Token        = 'TestHttpBasicSensor'

    }

    ExampleSplunk              = @{

        ProviderType     = 'SplunkProvider'

        Uri              = 'https://splunk.domain.com:8088/services/collector'

        Token            = '352d3c47-5082-4cc2-8a38-ef33de655e9a'

        IndexName        = 'test'

        SourceType       = 'Test'

        ObjectDepthLimit = 2

    }

    ExampleEmail               = @{

        ProviderType = 'SMTPProvider'

        SmtpServer   = 'smtp.domain.com'

        To           = 'user1@domain.com', 'user2@domain.com'

        From         = 'Logger <jobs@domain.com>'

        Port         = 25

        Priority     = 'High'

        BodyAsHTML   = $false

    }

    ExampleMsTeamsWebhook      = @{

        ProviderType     = 'MsTeamsWebhookProvider'

        Webhook          = 'https://outlook.office.com/webhook/e5eb43fe-a17d-4cf0-8b73-2e3ac40131ca/'

        ObjectDepthLimit = 2

    }

}