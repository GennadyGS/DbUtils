param(
    [Parameter(mandatory=$true)] $dbListFileName,
    $backupPath = "."
)

Get-Content $dbListFileName `
| ForEach-Object { . $PsScriptRoot\BackupDatabase.ps1 $_ $backupPath }
