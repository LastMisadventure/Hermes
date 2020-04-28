Get-Module Hermes | Remove-Module -Force

Import-Module Hermes -Force

InModuleScope Hermes {

    Describe 'Hermes\Private\Providers\MsTeamsWebhook' {

        Mock Invoke-WebRequest { }

        It 'Creates a Provider and writes to it' {

            $testProvider = 'MsTeamsWebhookProvider'

            $testMessage = '{text = "test"}'

            $configuration = @{

                Test = @{

                    ProviderType     = $testProvider

                    Webhook          = 'https://outlook.office.com/webhook/e5eb43fe-a17d-4cf0-8b73-2e3ac40131ca/'

                    ObjectDepthLimit = 2

                }

            }

            $params = @{

                Configuration = $configuration

                ErrorAction   = 'Stop'

            }

            $provider = Hermes\New-MessageProvider @params

            $provider.Test.GetType().FullName | Should -BeExactly $testProvider

            {Hermes\Write-Message -ErrorAction Stop -Provider $provider.Test -Message $testMessage} | Should -Not -Throw

        }

    }

}