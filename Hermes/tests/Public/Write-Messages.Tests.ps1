Get-Module Hermes | Remove-Module -Force

Import-Module Hermes -Force

InModuleScope Hermes {

    Describe "public\Write-Message" {

        Get-Item -ErrorAction Stop -Path ..\Mocks.ps1 | ForEach-Object { . $_.Fullname }

        $providers = Hermes\New-MessageProvider -Path ..\Providers.psd1 -ErrorAction Stop

        It "WindowsEventLog - Writes a test message to the provider" {

            $testProvider = $providers['ExampleWindowsEventLog']

            $message = 'TestMessageZ95'

            $param = @{

                Message     = $message

                Provider    = $testProvider

                Severity    = 'Information'

                EventId     = 1

                ErrorAction = 'Stop'

            }

            Hermes\Write-Message @param

            (Get-EventLog -LogName $testProvider.LogName -Source $testProvider.SourceName -Newest 1).Message | Should -BeExactly $message

        }

    }

}
