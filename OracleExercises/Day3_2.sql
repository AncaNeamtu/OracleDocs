--Cerinta 1
DECLARE
  v_exp number(2); --experienta
  v_hike number(5,2); 
  BEGIN
    select floor(months_between(trunc(sysdate),trunc(hire_date))/12)  --returneaza valoare intreaga
    into v_exp
    from employees
    where employee_id=115;
    v_hike:=1.05;
    
    if v_exp > 10 then v_hike:=1.20;
    elsif v_exp> 5 then v_hike :=1.10;
    else v_hike :=1.05;
    end if;
  
    update  employees 
      set salary = salary * v_hike where employee_id= 115;
       
  END;
--Cerinta 2
--Cerinta 3