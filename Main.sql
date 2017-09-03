declare @TableName sysname = 'AdventureWorksDWBuildVersion'
Declare @col nvarchar(max)
declare @com nvarchar(max)
declare @column nvarchar(max)
declare @Result nvarchar(max)
declare @temp nvarchar(max)
set @Result='db.'+@TableName+'.insert({'
--be cotation ha ezafe shod
set @com='select 
        replace(col.name, '''', ''_'') ColumnName,
        column_id ColumnId
    from sys.columns col
        join sys.types typ on
            col.system_type_id = typ.system_type_id AND col.user_type_id = typ.user_type_id
    where object_id = object_id(@TableName)'

@column=execute(@com)
select top 1 @col=@column from @TableName
set @Result=@Result+@column+':'
while @@ROWCOUNT<>0
begin
delete from @TableName where @col=@column
set @com='select 
        replace(col.name, '''', ''_'') ColumnName,
        column_id ColumnId
    from sys.columns col
        join sys.types typ on
            col.system_type_id = typ.system_type_id AND col.user_type_id = typ.user_type_id
    where object_id = object_id(@TableName)'
@column=execute(@com)
select top 1 @col=@column from @TableName
set @Result=@Result+@column+':'
end
-- just a test