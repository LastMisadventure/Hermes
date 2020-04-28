Get-Module Hermes | Remove-Module -Force

Import-Module Hermes -Force

InModuleScope Hermes {

    Describe 'Hermes\Private\Providers\PRTGBasicHttpPushSensor' {

        Mock Invoke-WebRequest { }

        $testProvider = 'PRTGBasicHttpPushSensorProvider'

        It "Creates a $($testProvider) Provider and writes to it" {


            $testMessage = 'test'

            $configuration = @{

                Test = @{

                    ProviderType = 'PRTGBasicHttpPushSensorProvider'

                    HostName     = 'prtg.domain.com'

                    Port         = 5050

                    UseSSL       = $false

                    Token        = 'TestHttpBasicSensor'

                }

            }

            $params = @{

                Configuration = $configuration

                ErrorAction   = 'Stop'

            }

            $provider = Hermes\New-MessageProvider @params

            $provider.Test.GetType().FullName | Should -BeExactly $testProvider

            { Hermes\Write-Message -ErrorAction Stop -Provider $provider.Test -Message $testMessage -Value 1 } | Should -Not -Throw

        }

    }

}