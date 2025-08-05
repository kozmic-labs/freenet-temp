# --- Part 1: Generate hosts.json ---

# Get tasklist equivalent data
$tasklistData = Get-Process -Name freenet | Select-Object @{N='Name';E={$_.ProcessName}}, Id, @{N='SessionName';E={($_.SessionName)}}, @{N='Session#';E={$_.SessionId}}, @{N='MemUsage';E={"$([int]($_.WS / 1KB)) K"}};

# Get wmic /format:list equivalent data
$wmicListRaw = (wmic process where "name='freenet.exe'" get CommandLine,ProcessId,ParentProcessId,Name /format:list) | Out-String;
$wmicListParsed = @();
$wmicListRaw -split "`r`n`r`n" | ForEach-Object {
    $block = $_.Trim();
    if ($block -match "CommandLine=") {
        $obj = [PSCustomObject]@{};
        $block -split "`r`n" | ForEach-Object {
            $line = $_.Trim();
            if ($line -match "^([^=]+)=(.+)$") {
                $key = $Matches[1];
                $value = $Matches[2];
                $obj | Add-Member -NotePropertyName $key -NotePropertyValue $value;
            }
        }
        $wmicListParsed += $obj;
    }
}

# Get wmic /value equivalent data (just CommandLines)
$wmicValueRaw = (wmic process where "name='freenet.exe'" get CommandLine /value) | Out-String;
$wmicValueParsed = @();
$wmicValueRaw -split "`r`n`r`n" | ForEach-Object {
    $line = $_.Trim();
    if ($line -like "CommandLine=*") {
        $commandLine = $line.Substring("CommandLine=".Length).Trim('"');
        $wmicValueParsed += $commandLine;
    }
}

# Create the main JSON object
$jsonOutput = @{
    "tasklist | findstr freenet.exe" = $tasklistData;
    "wmic process where `"name='freenet.exe'`" get CommandLine,ProcessId,ParentProcessId,Name /format:list" = $wmicListParsed;
    "wmic process where `"name='freenet.exe'`" get CommandLine /value" = $wmicValueParsed;
} | ConvertTo-Json -Depth 100 -Compress;

# Write to hosts.json
$jsonOutput | Set-Content -Path "hosts.json";

# --- Part 2: Display table (existing logic) ---

$wmicOutput = (wmic process where "name='freenet.exe'" get CommandLine /value) | Out-String;

$processes = @();
$wmicOutput -split "`r`n`r`n" | ForEach-Object {
    $line = $_.Trim();
    if ($line -like "CommandLine=*") {
        $commandLine = $line.Substring("CommandLine=".Length).Trim('"');
        
        $name = "freenet.exe";
        $port = $null;
        if ($commandLine -match '--ws-api-port (\d+)') {
            $port = $Matches[1];
        }
        $type = if ($commandLine -like '*--is-gateway*') { "Gateway" } else { "Peer" };

        $processes += [PSCustomObject]@{ 
            Name = $name;
            Port = $port;
            Type = $type;
        }
    }
}

$processes | Format-Table -AutoSize