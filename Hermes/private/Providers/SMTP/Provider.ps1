class SMTPProvider : MessageProvider {

    [uri] $SmtpServer

    [string[]] $To

    [string] $From

    [int] $Port

    [string] $Priority

    [bool] $BodyAsHTML

}