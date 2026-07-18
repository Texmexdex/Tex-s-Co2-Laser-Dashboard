param([int]$Port = 8000)
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$file = Join-Path $root 'fluidnc-dashboard.html'
$listener = [Net.Sockets.TcpListener]::new([Net.IPAddress]::Loopback, $Port)
$listener.Start()
Write-Host "FluidNC dashboard server: http://localhost:$Port/fluidnc-dashboard.html"
Write-Host 'Press Ctrl+C to stop.'
try {
    while ($true) {
        $client = $listener.AcceptTcpClient()
        try {
            $stream = $client.GetStream()
            $reader = [IO.StreamReader]::new($stream, [Text.Encoding]::ASCII, $false, 1024, $true)
            $request = $reader.ReadLine()
            while (($line = $reader.ReadLine()) -ne $null -and $line -ne '') { }
            $path = if ($request) { ($request -split ' ')[1] } else { '/' }
            if (($path -eq '/' -or $path -eq '/fluidnc-dashboard.html') -and (Test-Path $file)) {
                $body = [IO.File]::ReadAllBytes($file)
                $header = "HTTP/1.1 200 OK`r`nContent-Type: text/html; charset=utf-8`r`nContent-Length: $($body.Length)`r`nCache-Control: no-store`r`nConnection: close`r`n`r`n"
                $head = [Text.Encoding]::ASCII.GetBytes($header)
                $stream.Write($head, 0, $head.Length)
                $stream.Write($body, 0, $body.Length)
            } else {
                $body = [Text.Encoding]::UTF8.GetBytes('Not found')
                $header = [Text.Encoding]::ASCII.GetBytes("HTTP/1.1 404 Not Found`r`nContent-Length: $($body.Length)`r`nConnection: close`r`n`r`n")
                $stream.Write($header, 0, $header.Length)
                $stream.Write($body, 0, $body.Length)
            }
            $stream.Flush()
        } finally { $client.Close() }
    }
} finally { $listener.Stop() }