declare @TableName sysname = 'Document'
declare @Result varchar(max) = 'CREATE @'+@TableName+' TABLE(' +'
'

select @Result = @Result + '	' + ColumnName + ' ' + 'nvarchar(300)' + ',
'
from
(
    select replace(col.name, ' ', '_') ColumnName
    from sys.columns col
    where object_id = object_id('Document')
) t

set @Result = @Result  + '	ExceptionHandler char(1)
'  +');
INSERT INTO @' + @TableName + '(';

select @Result = @Result + '''' + ColumnName + ' ' + ColumnType + ''','
from
(
    select replace(col.name, ' ', '_') ColumnName, typ.name ColumnType
    from sys.columns col join sys.types typ on col.system_type_id = typ.system_type_id AND col.user_type_id = typ.user_type_id
    where object_id = object_id('Document')
) t

set @Result = @Result  + ');'


print @Result
