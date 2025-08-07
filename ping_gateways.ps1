$urls = @(
    "http://vega.locut.us:31337/",
    "http://technic.locut.us:31337/"
)

foreach ($url in $urls) {
    Write-Host "Pinging ${url}..."
    try {
        $response = Invoke-WebRequest -Uri $url -Method GET -UseBasicParsing -ErrorAction Stop
        Write-Host "Response Headers for ${url}:"
        $response.Headers | Format-List
    }
    catch {
        Write-Host "Error pinging ${url}: $($_.Exception.Message)"
    }
    Write-Host "" # Add a blank line for readability
}
