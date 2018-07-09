

-- rebuild all the indexes:
BEGIN
  for i in (SELECT index_name,table_name FROM user_indexes WHERE INDEX_TYPE in ('NORMAL','BITMAP')) loop
    DBMS_OUTPUT.PUT_LINE('-- REBUILD Index: ' || i.index_name || ' in table: ' || i.table_name);
    DBMS_OUTPUT.PUT_LINE('Alter Index ' || i.index_name || ' REBUILD ONLINE');
    Execute Immediate 'Alter Index ' || i.index_name || ' REBUILD ONLINE';
  end loop;
END;

--print drop index for user indexes, that create after $P, and in type normal or bitmap

begin
for i in (select object_name from dba_objects o, user_indexes i where o.object_name = i.index_name and i.index_type 
    in ('NORMAL' , 'BITMAP') and I.UNIQUENESS='NONUNIQUE'  and o.object_type = 'INDEX' and created > to_date('2018-01-01','YYYY-MM-DD')) loop
    dbms_output.put_line( 'DROP INDEX ' || i.object_name || ' ;');
    end loop;
end;
