DECLARE @TableName sysname = 'DocumentGroupSign';
DECLARE @HeadersTable TABLE(ColumnId int,ColumnName nvarchar(300));


	INSERT INTO @HeadersTable
	select column_id, replace(col.name, ' ', '_') ColumnName
	from sys.columns col join sys.types typ on col.system_type_id = typ.system_type_id AND col.user_type_id = typ.user_type_id
	where object_id = object_id(@TableName)

DECLARE @Result varchar(max) = ''
DECLARE @TheSelect nvarchar(max) = 'SELECT '+'
	'+ 'REPLACE(' + '''db.'+ @TableName +'.insert( '' + '+'
	';
SELECT @TheSelect  = @TheSelect +
	'CONCAT(''' + ColumnName + ': "'', '+ColumnName+', ''",'') +
	'
	from @HeadersTable

SET @TheSelect =@TheSelect +  '
	' + ''');'', '',);'', '');'')' + '
AS [Result] FROM [' + @TableName + ']';
set @Result = @Result  + @TheSelect
print @Result
--EXEC (@Result)