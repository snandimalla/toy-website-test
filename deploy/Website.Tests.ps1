# test script to verify that the website is accessible when HTTPS is used and not accessible when HTTP is used, called a Pester test file.

param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string] $HostName
)

Describe 'Toy Website' {
    #Tries to connect to the website over HTTPS. The test passes if the server responds with an HTTP response status code between 200 and 299, which indicates a successful connection.
    It 'Serves pages over HTTPS' {
        $request = [System.Net.WebRequest]::Create("https://$HostName/")
        $request.AllowAutoRedirect = $false
        $request.GetResponse().StatusCode |
            Should -Be 200 -Because 'The website should be accessible over HTTPS'
    }

    #Tries to connect to the website over HTTP. The test passes if the server responds with an HTTP response status code of 300 or higher.
    It 'Does not serve pages over HTTP' {
        $request = [System.Net.WebRequest]::Create("http://$HostName/")
        $request.AllowAutoRedirect = $false
        $request.GetResponse().StatusCode |
            Should -BeGreaterOrEqual 300 -Because 'HTTP is not secure'
    }
}
