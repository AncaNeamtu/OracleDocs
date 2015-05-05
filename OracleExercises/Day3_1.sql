set serveroutput on

--Exemplul 1
<<outerBlock>>
DECLARE
  v_outer varchar2(50):= 'dog';
BEGIN 
  DECLARE
  v_inner varchar2(50) := 'cat';
  v_outer varchar2(50) := 'mouse';
    BEGIN
        DBMS_OUTPUT.put_line ('Value 1:' || v_inner);
        DBMS_OUTPUT.put_line ('Value 2:' || v_outer);
        DBMS_OUTPUT.put_line ('Value 3:' || outerBlock.v_outer);
    EXCEPTION
      WHEN OTHERS 
      THEN 
        NULL;
     END;
DBMS_OUTPUT.put_line ('Value 4:' || v_outer);
EXCEPTION
WHEN OTHERS THEN
NULL;
END;

--Exemplul 2
DECLARE 
  employee_rec employees%ROWTYPE;  -- PREIA TIPUL DE DATA AL UNUI TUPLU DIN TABEL;
  BEGIN
  SELECT *
  INTO employee_rec
  FROM employees
  WHERE employee_id=&a;-- &a - apare un tabel unde trebuie sa introducem valoare

  DBMS_OUTPUT.put_line('Id: ' || employee_rec.employee_id);--refera col employees_id
  DBMS_OUTPUT.put_line('First name: ' || employee_rec.first_name);--refera col first_name
END;

--Exemplul 3- Sa se mareasca salariul angajatilor care au in prezent salariul mai mic decat valoare variabile v_prag
--Procent=0.1
--Prag de la tastatura

DECLARE 
  v_procent NUMBER :=0.1;
  v_prag EMPLOYEES.SALARY%TYPE;
  BEGIN
    UPDATE EMPLOYEES SET salary=salary+salary*v_procent
    WHERE salary < &a;
  END;
  
SELECT * FROM EMPLOYEES WHERE SALARY<100000 AND EMPLOYEE_ID=198;

--Exemplul 4- User defined records
DECLARE 
  TYPE  rec_location is record
  (
  adresa  locations.city%type,
  cod_postal locations.postal_code%type
  );
  v_locations rec_location;
  
  BEGIN
  SELECT city,postal_code
  into v_locations.adresa, v_locations.cod_postal
  from locations
  where location_id=&p_id;
  DBMS_OUTPUT.PUT_LINE('Adresa: '|| v_locations.adresa || chr(10)||'Cod postal: '|| v_locations.cod_postal);
  exception
  when no_data_found
  then dbms_output.put_line('Nu exista locatia!');
  end;

--Exemplul 5: 
DECLARE 
  jobid  employees.job_id%type;
  empid  employees.employee_id%type;
  sal_raise NUMBER(3,2); -- PRECIZIA
  BEGIN
  /*  SELECT job_id INTO jobid
    FROM employees
    WHERE employee_id=empid;*/
    
    IF jobid='PU_CLERK' THEN sal_raise:=.09;
    ELSIF jobid= 'SH_CLERK' THEN sal_raise:=.08;
    ELSIF jobid= 'ST_CLERK' THEN  sal_raise:=.07;
    ELSE sal_raise :=0;
    end if;
    dbms_output.put_line(sal_raise);
    exception                             --in cazul in care nu avem id pt angajat
    when no_data_found then 
    null;
  END;
    
--Exemplul 6 Case statement/expression
DECLARE 
  grade char(1);
  BEGIN
    GRADE:='B';
    CASE grade
    WHEN 'A' THEN 
    DBMS_OUTPUT.PUT_LINE('Excelent');
    WHEN 'B' THEN DBMS_OUTPUT.PUT_LINE('Very good!');
    WHEN 'C' THEN DBMS_OUTPUT.PUT_LINE('Good!');
    WHEN 'D' THEN DBMS_OUTPUT.PUT_LINE('Fair!');
    ELSE DBMS_OUTPUT.PUT_LINE('No such grade!');
    END CASE;
    END;

--Exemplul 7 instructiuni iterative
--LOOP
DECLARE 
 i number :=0;
 begin 
 loop 
  i:=i+1;
  DBMS_OUTPUT.PUT_LINE (TO_CHAR(I));
  EXIT WHEN i=4;
  end loop;
  end;

--in reverse(in ordine inversa)
begin 
for i in reverse 1..3 loop
DBMS_OUTPUT.PUT_LINE (TO_CHAR(i));-- poate fi doar i pentru ca il converteste sg
end loop;
end;


--while loop
declare
i number :=3;
  begin
  while i<=3 loop 
  DBMS_OUTPUT.PUT_LINE (i);
  i:=i+1;
  end loop;
  end;
  
  
--Exercitiul 8 CURSORI
DECLARE 
  CURSOR DEPARTMENTS_CURS -- declarare cursor
  is 
    select dp.department_id, dp.department_name, dp.location_id
    from departments dp;
    departments_rec departments_curs%rowtype;-- ce coloane se aduc din departments_rec
    begin
      if departments_curs%isopen=false then -- daca cursorul nu a fost deschis
      open departments_curs;
      end if;
       
      loop
          fetch departments_curs into departments_rec;-- te duce cu pointerul pe linia pe care esti si incarca in rec datele din cursor pe linia resp
          exit when departments_curs%notfound;
          dbms_output.put_line(
          departments_rec.department_id || ' ' || departments_rec.department_name);
          end loop;
          close departments_curs;
          end;
--Exercitiul 9 ERROR MANAGEMENT
DECLARE 
v_name varchar(5);
begin 
  begin 
    v_name:='Justice';
    dbms_output.put_line(v_name);
    exception
      when value_error
      then  dbms_output.put_line('Error in inner block');
  end;
   exception
   WHEN value_error
   then  dbms_output.put_line('Error in outer block');
  end;
  
--Exercitiul 9 Exceptii
DECLARE
  invalid_loc exception;
  begin
    update locations loc
      set loc.postal_code ='678012'
      where loc.city like '&A';
      if sql%notfound
        then raise invalid_loc;
      end if;
      exception 
        when invalid_loc
        then
          raise_application_error(-20100,'Nu exista localitate cu aceasta denumire');
    end;
  

