param(
    [Parameter(mandatory=$true)] $backupFileName,
    $dbName,
    $dataPath = "$env:ProgramFiles\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\"
)

if (!($dbName)) { $dbName = [IO.Path]::GetFileNameWithoutExtension($backupFileName) }
"Restore database $dbName from $backupFileName  ..."
sqlcmd -i "$PsScriptRoot\RestoreDatabase.sql" `
    -v dbName=$dbName backupFileName=`"$backupFileName `" dataPath=`"$dataPath`"
