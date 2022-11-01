param(
    $backupPath = ".",
    $dataPath = "$env:ProgramFiles\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\"
)

Get-ChildItem $backupPath -Filter "*.bak" `
| ForEach-Object {
    RestoreDatabase.ps1 $_.FullName "" $dataPath
}
