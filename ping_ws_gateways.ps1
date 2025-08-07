$urls = @(
    "ws://vega.locut.us:50509/",
    "ws://technic.locut.us:50509/"
)

foreach ($url in $urls) {
    Write-Host "Attempting WebSocket connection to ${url}..."
    $ws = New-Object System.Net.WebSockets.ClientWebSocket
    try {
        $uri = New-Object System.Uri($url)
        $ws.ConnectAsync($uri, [System.Threading.CancellationToken]::None).Wait()

        if ($ws.State -eq [System.Net.WebSockets.WebSocketState]::Open) {
            Write-Host "Successfully connected to ${url}."
            
            # Try sending a simple message (e.g., a ping or a basic request if known)
            # For now, just a generic message as we don't know the specific Freenet WS API format
            $message = "Hello Freenet Gateway!"
            $encoded = [System.Text.Encoding]::UTF8.GetBytes($message)
            $buffer = New-Object System.Array -ArgumentList ($encoded.Length), ([System.Byte])
            [System.Buffer]::BlockCopy($encoded, 0, $buffer, 0, $encoded.Length)
            
            $ws.SendAsync($buffer, [System.Net.WebSockets.WebSocketMessageType]::Text, $true, [System.Threading.CancellationToken]::None).Wait()
            Write-Host "Sent message to ${url}."

            # Try receiving a response
            $receiveBuffer = New-Object System.Byte[] 1024
            $result = $ws.ReceiveAsync($receiveBuffer, [System.Threading.CancellationToken]::None).Result
            $receivedMessage = [System.Text.Encoding]::UTF8.GetString($receiveBuffer, 0, $result.Count)
            Write-Host "Received response from ${url}: ${receivedMessage}"

            $ws.CloseAsync([System.Net.WebSockets.WebSocketCloseStatus]::NormalClosure, "Closing", [System.Threading.CancellationToken]::None).Wait()
        } else {
            Write-Host "Failed to connect to ${url}. WebSocket state: $($ws.State)"
        }
    }
    catch {
        Write-Host "Error connecting to ${url}: $($_.Exception.Message)"
    }
    finally {
        if ($ws.State -ne [System.Net.WebSockets.WebSocketState]::Closed) {
            $ws.Dispose()
        }
    }
    Write-Host "" # Add a blank line for readability
}