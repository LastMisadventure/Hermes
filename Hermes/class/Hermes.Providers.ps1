class MessageProvider {

    [string] $ProviderType

}

class WindowsEventLogMessageProvider : MessageProvider {

    [string] $LogName

    [string] $SourceName

}

class PRTGBasicHttpPushSensorProvider : MessageProvider {

    [uri] $HostName

    [int] $Port

    [string] $Token

    [bool] $UseSSL

}

class SplunkProvider : MessageProvider {

    [uri] $Uri

    [guid] $Token

    [string] $IndexName

    [string] $SourceType

    [int] $ObjectDepthLimit

}
