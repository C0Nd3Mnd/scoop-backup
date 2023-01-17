$TempPath = Join-Path $([System.IO.Path]::GetTempPath()) $([System.Guid]::NewGuid())
New-Item -ItemType Directory -Path $TempPath

$ScoopPersistPath = Join-Path $Home "scoop\persist"

[System.IO.File]::WriteAllLines($(Join-Path $TempPath "config.json"), $(scoop export -c))

Copy-Item -Path $ScoopPersistPath $TempPath -Recurse
Copy-Item $(Join-Path $PSScriptRoot "restore.ps1") $TempPath

Compress-Archive -Path $(Join-Path $TempPath "*") -DestinationPath ".\scoop_backup_$(Get-Date -Format "yyyy-MM-dd_hh-mm-ss").zip"

Remove-Item -Path $TempPath -Recurse -Force
