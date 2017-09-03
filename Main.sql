declare @TableName sysname = 'Document'
declare @Result varchar(max) = 'db.'+@TableName+'.insert('

select @Result = @Result + ColumnName + ': ' + /* value here */ '' + ', '
from
(
    select 
        replace(col.name, ' ', '_') ColumnName
    from sys.columns col
        join sys.types typ on
            col.system_type_id = typ.system_type_id AND col.user_type_id = typ.user_type_id
    where object_id = object_id(@TableName)
) t

set @Result = @Result  + ');'

print @Result