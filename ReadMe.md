# Hermes

Provides a standard cmdlet for writing messages to a number of different things...such as the Windows Event Log, Splunk, and PRTG.

## Supported Providers

- SMTP (email)
- Windows Event Log
- Splunk
- [PRTG HTTP Basic Push Sensor](https://www.paessler.com/manuals/prtg/http_push_data_sensor)

## Getting Started

(This only covers Windows Event Log as that's the only thing that works in this version!)

1. Create a configuration `[hashtable]` with the provider's details. Alternatively, you can use specify these settings in a file.

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
Write-Message -Provider $providerConfig['WindowsEventProvider'] -Severity Information -EventId 1337 -Message 'Diamonds in the face of nighttime.'
```
