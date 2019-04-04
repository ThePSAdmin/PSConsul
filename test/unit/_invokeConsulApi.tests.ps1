& "$PSScriptRoot\helpers\Init-sut.ps1"
InModuleScope PSConsul {
    Describe "_invokeConsulApi Tests" {
        mock Invoke-RestMethod {} -Verifiable 

        It "Performs a standard get to the url" {
            _invokeConsulApi -UriPath "test"
            Assert-MockCalled Invoke-RestMethod -ParameterFilter {
                $uri -eq [uri]::New('http://localhost:8500/test')
            }
        }

        It "Performs a standard get to the url with parameters" {
            _invokeConsulApi -UriPath "test" -UriParams @{foo="bar"}
            Assert-MockCalled Invoke-RestMethod -ParameterFilter {
                $uri -eq [uri]::New('http://localhost:8500/test?foo=bar')
            }
        }

        It "Posts to a url" {
            _invokeConsulApi -UriPath "test" -Method POST -Body "test"
            Assert-MockCalled Invoke-RestMethod -ParameterFilter {
                $uri -eq [uri]::New('http://localhost:8500/test') -and
                $body -eq "test" -and
                $method -eq 'POST'
            }
        }

    } 
    
}


