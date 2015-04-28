--SUBSELECTURI
--Cerinta 1
select last_name, hire_date from employees where department_id  = (select department_id from employees where last_name='Zlotkey') and last_name!='Zlotkey';
--Cerinta 2
select  employee_id, last_name from employees
          where department_id in (select department_id from employees where last_name like '%u%' or last_name like '%u' or last_name like 'u%' );
--Cerinta 3
select last_name, job_title, salary from employees e, jobs j 
          where e.job_id=j.job_id and  job_title in (select job_title from jobs where job_title like 'P%')and salary not in (2500,3500,7000) order by job_title asc, last_name desc;
--Cerinta 4
select last_name, job_id, department_id, salary from employees where salary > (select max(salary) from employees where department_id=30);

--DML
--Cerinta 1
insert into employees (employee_id, last_name, first_name,hire_date,email,salary,commission_pct,job_id) 
            values  ((select max(employee_id)+1000 from employees ), 'Neamtu', 'Anca',add_months(trunc(sysdate,'MM')-4,-48),'nmt.anca@yahoo.com',10000,0.2,'IT_PROG');
COMMIT;
--Cerinta 2
update employees set department_id= (select department_id from departments where department_name ='IT Support' ) 
    where employee_id=(select max(employee_id)from employees);
--Cerinta 3
select avg(salary)*12 from employees;
update employees set salary=salary+salary*commission_pct where  employee_id=(select max(employee_id)from employees);
commit;
select avg(salary)*12 from employees;
 
--VIEW
--Cerinta 1 
create view V_SALARIATI as select e.employee_id, e.first_name, e.last_name, j.job_id, j.job_title, d.department_id, d.department_name,e.salary, e.commission_pct from employees e, departments d,  jobs j where e.department_id(+)=d.department_id  and e.job_id=j.job_id; 
--Cerinta 2
create view V_SALARIATI_FIN as select * from employees where department_id=100 with check option;

--SECVENTE
--Cerinta 1
create sequence emp_sequence  
          increment by 10 start with 10
          maxvalue 1000
          cache 100;
          
insert into employees values (emp_sequence.nextval, 'Neacsu', 'Anca',add_months(trunc(sysdate,'MM')-4,-48),'nmt.anca@yahoo.com',10000,0.2,'IT_PROG');

select emp_sequence.currval from dual;
select emp_sequence.nextval from dual;