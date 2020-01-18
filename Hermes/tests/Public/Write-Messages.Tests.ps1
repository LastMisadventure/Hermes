Get-Module Hermes | Remove-Module -Force

Import-Module Hermes -Force

InModuleScope Hermes {

    Describe "public\Write-Message" {

        Get-Item -ErrorAction Stop -Path ..\Mocks.ps1 | ForEach-Object { . $_.Fullname }

        $providers = Hermes\New-MessageProvider -Path ..\Providers.psd1 -ErrorAction Stop

        It "WindowsEventLog - Writes a message to the provider" {

            $testProvider = $providers['ExampleWindowsEventLog']

            $message = 'TestMessageZ95'

            $params = @{

                Message     = $message

                Provider    = $testProvider

                Severity    = 'Information'

                EventId     = 1

                ErrorAction = 'Stop'

            }

            Hermes\Write-Message @params

            (Get-EventLog -LogName $testProvider.LogName -Source $testProvider.SourceName -Newest 1).Message | Should -BeExactly $message

        }

        It "PRTGBasicHttpPush - Writes a message to the provider (message only)" {

            $testProvider = $providers['ExamplePRTGBasicPushSensor']

            $successUri = "http://prtg.domain.com:5050/TestHttpBasicSensor?text=Error"

            $params = @{

                Message     = 'Error'

                Provider    = $testProvider

                ErrorAction = 'Stop'

            }

            Hermes\Write-Message @params

            Assert-MockCalled -Times 1 -CommandName Invoke-WebRequest -ParameterFilter { $Uri -eq $successUri }

        }

        It "PRTGBasicHttpPush - Writes a message to the provider (message & value)" {

            $testProvider = $providers['ExamplePRTGBasicPushSensor']

            $successUri = "http://prtg.domain.com:5050/TestHttpBasicSensor?Value=0&text=OK"

            $params = @{

                Message     = 'OK'

                Value       = 0

                Provider    = $testProvider

                ErrorAction = 'Stop'

            }

            Hermes\Write-Message @params

            Assert-MockCalled -Times 1 -CommandName Invoke-WebRequest -ParameterFilter { $Uri -eq $successUri }

        }

        It "Splunk - Writes a message to the provider" {

            $testProvider = $providers['ExampleSplunk']

            $messageRaw = [PSCustomObject] [ordered] @{

                Name   = 'TestObject'

                Value1 = 1

                Value2 = 2

                Value3 = 3

            }

            $params = @{

                Message     = $messageRaw

                Provider    = $testProvider

                ErrorAction = 'Stop'

            }

            Hermes\Write-Message @params

        }

        It "SMTP - Writes a message to the provider" {

            $testProvider = $providers['ExampleEmail']

            $message = 'Test Email Body'

            $subject = 'Email Subject'

            $params = @{

                Message     = $message

                Subject     = $subject

                Provider    = $testProvider

                ErrorAction = 'Stop'

            }

            Hermes\Write-Message @params

        }

    }

}
