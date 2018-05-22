DECLARE 
max_id number; 
col_exists number;
seq number;
seq_exists number;
BEGIN 
for t in (select table_name from user_tables) loop
  select count(1) into col_exists from user_tab_columns where table_name =t.table_name and column_name ='ID';
  if(col_exists >0)
  then
    execute immediate 'select max(ID) from ' || t.table_name into max_id;
    dbms_output.DBMS_OUTPUT.PUT_LINE('max-id' || max_id);
    select count(1) into seq_exists from USER_SEQUENCES where sequence_name like (t.table_name || '_SEQ%');
    if(seq_exists >0)
    then
    execute immediate 'select ' || t.table_name || '_seq.nextval from dual ' into seq;
    end if;
    if(seq > max_id and max_id is not null )
    then
     DBMS_OUTPUT.PUT_LINE('sequence of table => ' || t.table_name || ' is fine');
    else 
     DBMS_OUTPUT.PUT_LINE('max id of of table => ' || t.table_name || ' is =>' || max_id || ' and sequence is => ' || seq);
    end if;
    --DBMS_OUTPUT.PUT_LINE ('table name=> '|| t.table_name || ' , max id =>' || max_id || ' , sequence => ' || t.table_name || '_seq' || ', value=> ' || seq);
    end if;
end loop;
END;

