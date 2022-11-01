param(
    [Parameter(mandatory=$true)] $dbListFileName,
    $backupPath = "."
)

if (!(Test-Path $dbListFileName -PathType Leaf)) {
    throw "Database list file name $dbListFileName is not found"
}

if (!(Test-Path $backupPath -PathType Container)) {
    throw "Backup path $backupPath is not found"
}

Get-Content $dbListFileName `
| ForEach-Object { . $PsScriptRoot\BackupDatabase.ps1 $_ $backupPath }
