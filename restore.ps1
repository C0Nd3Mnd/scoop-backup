$BackupPath = .\
$ScoopPersistPath = Join-Path $Home "scoop\persist"

if (!Get-Command "scoop") {
  Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
  Invoke-RestMethod get.scoop.sh | Invoke-Expression
}

Remove-Item -Path $ScoopPersistPath -Recurse -Force
Copy-Item -Path $(Join-Path $BackupPath "persist") $ScoopPersistPath -Recurse
scoop import $(Join-Path $BackupPath "config.json")
