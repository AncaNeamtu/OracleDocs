set serveroutput on
--Functii
--Sa se def o fct care verifica daca parametrul trimis este un cnp valid
create or replace function functie_cnp (p_cnp in number )
return boolean
is 
  v_result boolean;
--  exceptie exception;
BEGIN
if length(p_cnp)!=13
  then v_result:=false;
  elsif substr(p_cnp,1,1) not in (1,2) then v_result:=false;
  elsif substr(p_cnp,4,2) > 12 then v_result:=false;
  else v_result:=true;
end if;
  return v_result;
--  exception exceptie then 
--     dbms_output.put_line('Cnp nu este un numar valid');
END;

begin 
if functie_cnp(2390714178451) 
  then
  dbms_output.put_line('Cnp valid');
  else
  dbms_output.put_line('Cnp invalid');
end if;
end;

--Proceduri
--Procedura care foloseste un cursor in care aducem numele dep si salariul mediu din dep si suma salariilor,  cursorul sa fie parametrizat.
create or replace procedure procedura_cursor(p_id number)
is
cursor p_cursor(c_id number) is select department_name, avg(salary), sum(salary) as mediu from employees e, departments d 
                                        where e.department_id=d.department_id  and d.department_id=c_id
                                        group by department_name;
curs_rec p_cursor%rowtype; --var de tip cursor
begin 
  if p_cursor%isopen=false 
  then open p_cursor(p_id); --verific daca e deschis si il deschid cu parametrul din procedura
  end if;
  loop
    fetch p_cursor into curs_rec; --parcurgem cursorul
    exit when p_cursor%notfound;    -- iese din loop
    dbms_output.put_line('Nume departament'||' '|| curs_rec.department_name||' '||'Salariu mediu'|| curs_rec.mediu);
  end loop;
end;


execute procedura_cursor(30);
--sau
begin
procedura_cursor(30);
end;

--Pachete