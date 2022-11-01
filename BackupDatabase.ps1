param(
    [Parameter(mandatory=$true)] $dbName,
    $backupPath = "."
)

$fullBackupPath = [IO.Path]::GetFullPath($backupPath)
"Backup database $dbName to $fullBackupPath ..."
sqlcmd -i "$PsScriptRoot\BackupDatabase.sql" -v dbName=$dbName backupPath=`"$fullBackupPath`"
