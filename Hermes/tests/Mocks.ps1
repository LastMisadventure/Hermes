Mock Invoke-WebRequest {

    [PSCustomObject] [ordered] @{

        StatusCode        = 200

        StatusDescription = 1

        RawContent        = 1

    }

}

Mock Invoke-RestMethod {

    [PSCustomObject] [ordered] @{

        text = 'success'

    }

}

Mock Send-MailMessage {


}