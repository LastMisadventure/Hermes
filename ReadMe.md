# Hermes

Provides a standard cmdlet for writing messages to a number of different things...such as the Windows Event Log, Splunk, and PRTG.

## Supported Providers

- SMTP (email)
- Windows Event Log
- Splunk
- [PRTG HTTP Basic Push Sensor](https://www.paessler.com/manuals/prtg/http_push_data_sensor)

## Getting Started

1. Create a configuration `[hashtable]` with the provider's details. Alternatively, you can use specify these settings in a [file](https://github.com/LastMisadventure/Hermes/blob/master/Hermes/Examples/ProviderConfig.psd1).

```PowerShell

$eventLogProvider = @{

   WindowsEventProvider = @{

       ProviderType = 'WindowsEventLogMessageProvider'

       LogName    = 'TestLog'

       SourceName = 'TestApp'

   }

}
```

2. Create a `[MessageProvider]` object:

```PowerShell
$providerConfig = New-MessageProvider -Configuration $eventLogProvider
```

3. Write a message to the provider.

```PowerShell
# Simple write to the Windows Event Log

Write-Message -Provider $providerConfig['WindowsEventProvider'] -Severity Information -EventId 1337 -Message 'Diamonds in the face of nighttime.'

# Write to a Splunk Index

$somePsObject = @{

    Data1 = 8390

    Data2 = $true

    Data3 = $false

}

Write-Message -Provider $providerConfig['Splunk'] -Message $somePsObject

```

## Provider Examples

Below is a example of every currently supported provider. The key name ("ExampleWindowsEventLog" below) can be anything, but the value of the `ProviderType` key much match as shown below:

```PowerShell
@{

    WindowsEventLog     = @{

        ProviderType = 'WindowsEventLogMessageProvider'

        LogName      = 'TestLog'

        SourceName   = 'TestSource'

    }

    PRTGBasicPushSensor = @{

        ProviderType = 'PRTGBasicHttpPushSensorProvider'

        HostName     = 'prtg.domain.com'

        Port         = 5050

        UseSSL       = $false

        Token        = 'TestHttpBasicSensor'

    }

    Splunk              = @{

        ProviderType     = 'SplunkProvider'

        Uri              = 'https://splunk.domain.com:8088/services/collector'

        Token            = '352d3c47-5082-4cc2-8a38-ef33de655e9a'

        IndexName        = 'test'

        SourceType       = 'Test'

        ObjectDepthLimit = 2

    }

    Email               = @{

        ProviderType = 'SMTPProvider'

        SmtpServer   = 'smtp.domain.com'

        To           = 'user1@domain.com', 'user2@domain.com'

        From         = 'Logger <jobs@domain.com>'

        Port         = 25

        Priority     = 'High'

        BodyAsHTML   = $false

    }

}
```
