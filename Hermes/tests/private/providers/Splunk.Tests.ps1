Get-Module Hermes | Remove-Module -Force

Import-Module Hermes -Force

InModuleScope Hermes {

    Describe 'Hermes\Private\Providers\PRTGBasicHttpPushSensor' {

        Mock Invoke-RestMethod {

            [PSCustomObject] @{

                Text = 'Success'
            }

        }

        $testProvider = 'SplunkProvider'

        It "Creates a $($testProvider) Provider and writes to it" {

            $testMessage = 'test'

            $configuration = @{

                Test = @{

                    ProviderType     = 'SplunkProvider'

                    Uri              = 'https://splunk.domain.com:8088/services/collector'

                    Token            = '352d3c47-5082-4cc2-8a38-ef33de655e9a'

                    IndexName        = 'test'

                    SourceType       = 'Test'

                    ObjectDepthLimit = 2

                }

            }

            $params = @{

                Configuration = $configuration

                ErrorAction   = 'Stop'

            }

            $provider = Hermes\New-MessageProvider @params

            $provider.Test.GetType().FullName | Should -BeExactly $testProvider

            { Hermes\Write-Message -ErrorAction Stop -Provider $provider.Test -Message $testMessage } | Should -Not -Throw

        }

    }

}