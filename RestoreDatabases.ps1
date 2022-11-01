param(
    $backupPath = ".",
    $dataPath = "$env:ProgramFiles\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\"
)

if (!(Test-Path $backupPath -PathType Container)) {
    throw "Backup path $backupPath is not found"
}

if (!(Test-Path $dataPath -PathType Container)) {
    throw "Data path $dataPath is not found"
}

Get-ChildItem $backupPath -Filter "*.bak" `
| ForEach-Object {
    RestoreDatabase.ps1 $_.FullName "" $dataPath
}
