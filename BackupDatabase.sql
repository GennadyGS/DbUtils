DECLARE @BackupPath VARCHAR(MAX), @FileName VARCHAR(MAX), @Suffix VARCHAR(MAX)
SET @BackupPath = '$(backupPath)'
SET @Suffix = Convert(varchar(500), GetUtcDate(), 112)

SET @FileName = @BackupPath + '\' + '$(dbName)_' + @Suffix + '.bak'
BACKUP DATABASE $(dbName)
TO DISK = @FileName
WITH FORMAT;