--RESTRICTIONAREA SI SORTAREA DATELOR
--Cerinta 1
select last_name, salary from EMPLOYEES where salary>14000;
--Cerinta 2
select last_name, salary from EMPLOYEES where salary between 2000 and 14000 order by salary DESC;
--Cerinta 3
select last_name from EMPLOYEES where department_id=50;
--Cerinta 4      
select last_name , salary, commission_pct from  EMPLOYEES where  commission_pct is not null or commission_pct=0 order by commission_pct ASC;
--Cerinta 5
select last_name, job_id, salary from EMPLOYEES where job_id IN('SR_CLERK','SA_REP') AND SALARY NOT IN (2500,3500,7000) ORDER BY last_name DESC;

--FUNCTII SINGLE ROW
--Cerinta 1
select sysdate as DataCcurenta from dual;
--Cerinta 2
select last_name, salary,salary+15/100*salary as NEWSAL from employees; 
--Cerinta 3
select upper(first_name) ,length(first_name), 
            nvl(commission_pct,1)*nvl(commission_pct,0) as total
            from EMPLOYEES  where first_name LIKE 'J%' or first_name LIKE 'A' or first_name LIKE 'M' ;
--Cerinta 4
select last_name, MONTHS_BETWEEN(to_date('25-12-2002','DD-MM-RRRR'),hire_date) as Vechime FROM EMPLOYEES ORDER BY Vechime DESC;
--Cerinta 6
select DISTINCT job_id, case job_id when 'AD_PRES' then 'A'
                                    when 'SR_MAN' then 'B'
                                    when 'IT_PROG' then 'C'
       ELSE '0'
       END as Grade 
       from EMPLOYEES; 
       
       
--JONCTIUNI
--Cerinta 1 (Normal Join)
select last_name||' '||first_name nume, department_name, round(add_months(hire_date,1),'MONTH') as dataNoua
        from employees e, departments d
        where e.DEPARTMENT_ID = d.DEPARTMENT_ID; 
--Cerinta--se returneaza un produs cartezian
SELECT *FROM employees
        CROSS JOIN departments;     
        
--AGREGAREA DATELOR (FCT DE GRUP)
--Cerinta 1
select count(*) NrAngajati from employees;

