param(
    [Parameter(mandatory=$true)] $backupFileName,
    $dbName,
    $dataPath = "$env:ProgramFiles\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\"
)

if (!(Test-Path $backupFileName -PathType Leaf)) {
    throw "Backup file name $backupFileName is not found"
}

if (!(Test-Path $dataPath -PathType Container)) {
    throw "Data path $dataPath is not found"
}

if (!($dbName)) { $dbName = [IO.Path]::GetFileNameWithoutExtension($backupFileName) }
"Restore database $dbName from $backupFileName  ..."
sqlcmd -i "$PsScriptRoot\RestoreDatabase.sql" `
    -v dbName=$dbName backupFileName=`"$backupFileName `" dataPath=`"$dataPath`"
