param(
    [Parameter(mandatory=$true)] $dbName,
    $backupPath = "."
)

if (!(Test-Path $backupPath -PathType Container)) {
    throw "Backup path $backupPath is not found"
}

$fullBackupPath = [IO.Path]::GetFullPath($backupPath)
"Backup database $dbName to $fullBackupPath ..."
sqlcmd -i "$PsScriptRoot\BackupDatabase.sql" -v dbName=$dbName backupPath=`"$fullBackupPath`"
