declare @filelist table (
    LogicalName nvarchar(128) NOT NULL,
    PhysicalName nvarchar(260) NOT NULL,
    Type char(1) NOT NULL,
    FileGroupName nvarchar(120) NULL,
    Size numeric(20, 0) NOT NULL,
    MaxSize numeric(20, 0) NOT NULL,
    FileID bigint NULL,
    CreateLSN numeric(25,0) NULL,
    DropLSN numeric(25,0) NULL,
    UniqueID uniqueidentifier NULL,
    ReadOnlyLSN numeric(25,0) NULL ,
    ReadWriteLSN numeric(25,0) NULL,
    BackupSizeInBytes bigint NULL,
    SourceBlockSize int NULL,
    FileGroupID int NULL,
    LogGroupGUID uniqueidentifier NULL,
    DifferentialBaseLSN numeric(25,0)NULL,
    DifferentialBaseGUID uniqueidentifier NULL,
    IsReadOnly bit NULL,
    IsPresent bit NULL,
    TDEThumbprint varbinary(32) NULL,
    SnapshotUrl nvarchar(max) NULL)

insert into @filelist exec sp_executesql N'restore filelistonly from disk=''$(backupFileName)''';
declare @sql nvarchar(2056)
set @sql = 'RESTORE database $(dbName) from disk=''$(backupFileName)'' with ';
select @sql = @sql + ' move ''' + LogicalName + N''' to ''$(dataPath)' + LogicalName + N'.'
    + CASE Type WHEN 'L' THEN N'ldf' ELSE N'mdf' END   + N''','
from @filelist;

set @sql = substring(@sql, 1, len(@sql)-1); -- remove last ','
exec sp_executesql @sql;
