$output = Get-Content -Path output.txt
$tfvars = @()

foreach ($line in $output) {
    if ($line -match '^([a-z_]+)\s+:\s+(.+)$') {
        $key = $matches[1]
        $value = $matches[2]

        if ($value -match '^{(.*)}$') {
            $value = $matches[1].Split(',') | ForEach-Object {
                if ($_ -match '@{(.*)}') {
                    '{ ' + $_.Trim().Replace('=', ' = ') + ' }'
                } else {
                    '"' + $_.Trim() + '"'
                }
            }
            $value = [string[]]$value
            $value = '[' + ($value -join ', ') + ']'
        } else {
            $value = '"' + $value + '"'
        }

        $tfvars += "$key = $value"
    }
}

Set-Content -Path main.tfvars -Value ($tfvars -join [Environment]::NewLine)