select to_number('ABC') FROM DUAL;
SELECT e.employee_id, d.department_id,e.last_name from employees e, departments d where e.department_id=d.department_id AND LAST_NAME='Neamtu';
--SAU
SELECT e.employee_id, d.department_id,e.last_name from employees e JOIN  departments d ON (e.department_id=d.department_id) where last_name='Neamtu';
set serveroutput on
begin
 for year_index in reverse 1..12 loop 
 dbms_output.put_line(year_index);
 end loop;
end;

create index 