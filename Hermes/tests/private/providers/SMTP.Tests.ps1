Get-Module Hermes | Remove-Module -Force

Import-Module Hermes -Force

InModuleScope Hermes {

    Describe 'Hermes\Private\Providers\SMTP' {

        $testProvider = 'SMTPProvider'

        Mock Send-MailMessage { }

        It "Creates a $($testProvider) Provider and writes to it" {

            $testMessage = 'Test'

            $configuration = @{

                Test = @{

                    ProviderType = $testProvider

                    SmtpServer   = 'smtp.domain.com'

                    To           = 'user1@domain.com', 'user2@domain.com'

                    From         = 'Logger <jobs@domain.com>'

                    Port         = 25

                    Priority     = 'High'

                    BodyAsHTML   = $false

                }

            }

            $params = @{

                Configuration = $configuration

                ErrorAction   = 'Stop'

            }

            $provider = Hermes\New-MessageProvider @params

            $provider.Test.GetType().FullName | Should -BeExactly $testProvider

            { Hermes\Write-Message -ErrorAction Stop -Provider $provider.Test -Message $testMessage -Subject $testMessage } | Should -Not -Throw

        }

    }

}