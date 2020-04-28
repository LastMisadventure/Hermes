#TODO: Figure out a way to bypass this for PS7.

# Get-Module Hermes | Remove-Module -Force

# Import-Module Hermes -Force

# InModuleScope Hermes {

#     Describe 'Hermes\Private\Providers\WindowsEventLogMessageProvider' {

#         Mock Write-EventLog { }

#         $testProvider = 'WindowsEventLogMessageProvider'

#         It "Creates a $($testProvider) Provider and writes to it" {

#             $testMessage = 'test'

#             $configuration = @{

#                 Test = @{

#                     ProviderType = 'WindowsEventLogMessageProvider'

#                     LogName      = 'TestLog'

#                     SourceName   = 'TestSource'

#                 }

#             }

#             $params = @{

#                 Configuration = $configuration

#                 ErrorAction   = 'Stop'

#             }

#             $provider = Hermes\New-MessageProvider @params

#             $provider.Test.GetType().FullName | Should -BeExactly $testProvider

#             { Hermes\Write-Message -ErrorAction Stop -Provider $provider.Test -Message $testMessage -Severity 'ERROR' -EventId 4 } | Should -Not -Throw

#         }

#     }

# }