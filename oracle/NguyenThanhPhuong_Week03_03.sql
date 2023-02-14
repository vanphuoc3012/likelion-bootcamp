-------------------------------------
--Exercise 1
create or replace package pkg_proc is
    procedure dept_info (p_dept_id departments.department_id%type default null);
    procedure add_job (p_job_id jobs.job_id%type, p_job_title jobs.job_title%type);
    procedure update_comm (p_emp_id employees.employee_id%type);
    procedure add_emp (p_emp_id employees.employee_id%type, 
                        p_first_name employees.first_name%type,
                        p_last_name employees.last_name%type,
                        p_email employees.email%type,
                        p_phone_number employees.phone_number%type,
                        p_hire_date employees.hire_date%type,
                        p_job_id employees.job_id%type,
                        p_salary employees.salary%type,
                        p_commission_pct employees.commission_pct%type,
                        p_manager_id employees.manager_id%type,
                        p_department_id employees.department_id%type);
    procedure delete_emp (p_emp_id employees.employee_id%type);
    procedure find_emp;
    procedure update_comm;
    procedure job_his (p_emp_id job_history.employee_id%type);
end;

------------------------------------------
create or replace package body pkg_proc is
    procedure dept_info (p_dept_id departments.department_id%type default null)
    is
        type c_dept is ref cursor;
        d_cursor c_dept;
        v_dept departments%rowtype;
        v_sql varchar2(1000) := 'select * from departments';
    begin
        if p_dept_id is null then
            open d_cursor for v_sql;
        else
        v_sql := v_sql||'  where department_id = :id';
        open d_cursor for v_sql using p_dept_id;
        end if;
        
        loop
            fetch d_cursor into v_dept;
            exit when d_cursor%notfound;
            dbms_output.put_line('Department ID '||v_dept.department_id||' has name: '||v_dept.department_name);
        end loop;
        close d_cursor; 
        
        exception
        when no_data_found then
        dbms_output.put_line('The query does not retrieve any record');
        when others then 
        dbms_output.put_line('Other error');
    end;
    
    procedure add_job (p_job_id jobs.job_id%type, p_job_title jobs.job_title%type)
    is
    v_job_id_temp jobs.job_id%type;
    e_invalid exception;
    begin
        select job_id into v_job_id_temp
        from jobs
        where job_id = p_job_id;
        
        if v_job_id_temp is not null then
            raise e_invalid;
        end if;
        
        exception
        when e_invalid then
        dbms_output.put_line('Cannot add because id already exists');
        when no_data_found then
        insert into jobs values (p_job_id, p_job_title, null, null);
        rollback;
        dbms_output.put_line('Job '||p_job_title||' has been added and automatic rollback for testing');
        when others then 
        dbms_output.put_line('Other error');
        dbms_output.put_line(sqlcode);
        dbms_output.put_line(sqlerrm);
    end;

    procedure update_comm (p_emp_id employees.employee_id%type)
    is
    e_invalid exception;
    begin
        update employees
        set employees.commission_pct = commission_pct * 1.05
        where employees.employee_id = p_emp_id;
        
        if sql%notfound then
            raise e_invalid;
        end if;
        
        rollback;
        dbms_output.put_line('Update commmission successfully and automatic rollback for testing');
        
        exception 
        when e_invalid then
        dbms_output.put_line('Invalid ID');
        dbms_output.put_line(sqlcode);
        dbms_output.put_line(sqlerrm);
        when others then 
        dbms_output.put_line('Update failed');
        dbms_output.put_line(sqlcode);
        dbms_output.put_line(sqlerrm);
    end;
    
    procedure add_emp (p_emp_id employees.employee_id%type, 
                        p_first_name employees.first_name%type,
                        p_last_name employees.last_name%type,
                        p_email employees.email%type,
                        p_phone_number employees.phone_number%type,
                        p_hire_date employees.hire_date%type,
                        p_job_id employees.job_id%type,
                        p_salary employees.salary%type,
                        p_commission_pct employees.commission_pct%type,
                        p_manager_id employees.manager_id%type,
                        p_department_id employees.department_id%type)
    is v_count number;
    e_invalid exception;
    begin
        select count(*) into v_count
        from employees
        where employee_id = p_emp_id;
        
        if v_count > 0
            then raise e_invalid;
        else
            insert into employees values (p_emp_id, p_first_name, p_last_name, p_email, p_phone_number, p_hire_date, p_job_id, p_salary, p_commission_pct, p_manager_id, p_department_id);
            rollback;
            dbms_output.put_line('Add employee successfully and automatic rollback for testing');
        end if;
        
        exception
        when e_invalid then
        dbms_output.put_line('Employee with ID '||p_emp_id||' has exit');
    end;
    
    procedure delete_emp (p_emp_id employees.employee_id%type)
    is
    v_no_rec number;
    e_invalid exception;
    begin
        execute immediate 'delete from employees where employee_id = :id' using p_emp_id;
        v_no_rec := sql%rowcount;
        
        if sql%notfound then
            raise e_invalid;
        end if;
        
        rollback;
        dbms_output.put_line(v_no_rec ||' record(s) deleted form employees successfully and automatic rollback for testing');
        
        exception
        when e_invalid then
        dbms_output.put_line('Invalid ID');
        dbms_output.put_line(sqlcode);
        dbms_output.put_line(sqlerrm);
        when others then 
        dbms_output.put_line('Delete failed');
        dbms_output.put_line(sqlcode);
        dbms_output.put_line(sqlerrm);
    end;
    
    procedure find_emp
    is
    v_details employees%rowtype;
    cursor c_emp is
        select * from employees e
        where salary > (select min_salary from jobs b1 where e.job_id = b1.job_id)
        and salary < (select max_salary from jobs b2 where e.job_id = b2.job_id);
    e_invalid exception;
    begin
        open c_emp;
        loop
            fetch c_emp into v_details;
            exit when c_emp%notfound;
            dbms_output.put_line(v_details.employee_id||' '||v_details.first_name); -- the exit should before output
        end loop;
        close c_emp;
        
        exception
        when others then 
        dbms_output.put_line('Other error');
        dbms_output.put_line(sqlcode);
        dbms_output.put_line(sqlerrm);
    end;
    
    procedure update_comm
    is v_work_year varchar2(2);
    cursor c_emp
        is select * from employees;
    begin
        for r_emp in c_emp
        loop v_work_year := to_char(sysdate, 'yyyy') - to_char(r_emp.hire_date, 'yyyy');
            if v_work_year >= 2
                then update employees
                set salary = salary + 200
                where employee_id = r_emp.employee_id;
                rollback;
                dbms_output.put_line('Employee '||r_emp.last_name||'had increased salary more 200$ and automatic rollback for testing');
            else update employees
                set salary = salary + 100
                where employee_id = r_emp.employee_id;
                rollback;
                dbms_output.put_line('Employee '||r_emp.last_name||' had increased salary more 100$ and automatic rollback for testing');
            end if;
        end loop;
    end;
    
    procedure job_his (p_emp_id job_history.employee_id%type)
    is
    v_emp job_history%rowtype;
    cursor c_emp
        is select * from job_history where employee_id = p_emp_id;
    e_invalid exception;
    begin
        open c_emp;
            loop
                fetch c_emp into v_emp;
                exit when c_emp%notfound;
                dbms_output.put_line('Employee has ID '||v_emp.employee_id||' has start date '||v_emp.start_date||' and end date '||v_emp.end_date);
            end loop; 
        close c_emp;
        
        exception
        when e_invalid then
        dbms_output.put_line('Invalid ID');
        dbms_output.put_line(sqlcode);
        dbms_output.put_line(sqlerrm);
        when others then 
        dbms_output.put_line('PL/SQL failed');
        dbms_output.put_line(sqlcode);
        dbms_output.put_line(sqlerrm);
    end;
end;


----------------------------------------------
--Test exercise 1.1
--To get all the departments
execute pkg_proc.dept_info;

--To get all the departments in specific dept
execute pkg_proc.dept_info(10);

--Test exercise 1.2
execute pkg_proc.add_job('test', 'test');

--Test exercise 1.3
execute pkg_proc.update_comm(150);

--Test exercise 1.4
execute pkg_proc.add_emp(250, 'test', 'test', 'test', '590.423.4569', TO_DATE('25-06-2005', 'dd-MM-yyyy'), 'IT_PROG', 4800, null, 103, 60);   

--Test exercise 1.5
--Delete fail cause having constraint
execute pkg_proc.delete_emp(100);

--Test exercise 1.6
declare
v_details employees%rowtype;
begin
    pkg_proc.find_emp(v_details);
end;

--Test exercise 1.7
execute pkg_proc.update_comm;

--Test exercise 1.8
execute pkg_proc.job_his(200);

-------------------------------------
--Exercise 2
create or replace package pkg_func is
    function sum_salary (p_dept_id employees.department_id%type) return number;
    function name_con (p_con_id countries.country_id%type) return countries.country_name%type;
    function annual_comp (p_salary employees.salary%type, p_comp employees.commission_pct%type default null) return employees.salary%type;
    function avg_sal (p_dept_id employees.department_id%type) return employees.salary%type;
    function time_work (p_emp_id employees.employee_id%type) return number;
end;


------------------------------------------
create or replace package body pkg_func is
    function sum_salary (p_dept_id employees.department_id%type)
    return number
    is
    v_sum_sal number;
    begin
        select sum(salary) into v_sum_sal
        from employees
        where department_id = p_dept_id;
        dbms_output.put_line('The sum salary is '||v_sum_sal);
        return v_sum_sal;
       
        exception 
        when no_data_found then
        dbms_output.put_line('No data found');
        return -1;
    end;
    
    
    function name_con (p_con_id countries.country_id%type) return countries.country_name%type
    is
    v_con_name countries.country_name%type;
    begin
        select country_name into v_con_name
        from countries
        where country_id = p_con_id;
        return v_con_name;
        
        exception 
        when no_data_found then
        return -1;
    end;
    
    function annual_comp (p_salary employees.salary%type, p_comp employees.commission_pct%type default null) return employees.salary%type
    is
    v_annual_comp employees.salary%type;
    begin
        v_annual_comp := p_salary * 12 *  (1 + p_comp);
        return v_annual_comp;
        
        exception 
        when no_data_found then
        return -1;
    end;
    
    function avg_sal (p_dept_id employees.department_id%type) return employees.salary%type
    is
    v_avg_sal employees.salary%type;
    begin
        select avg(salary) into v_avg_sal
        from employees
        where department_id = p_dept_id;
        return v_avg_sal;
        
        exception 
        when no_data_found then
        return -1;
    end;
    
    function time_work (p_emp_id employees.employee_id%type) return number
    is
    v_hire_date employees.hire_date%type;
    v_hire_month number;
    begin
        select hire_date into v_hire_date
        from employees
        where employee_id = p_emp_id;
        v_hire_month := trunc(months_between(sysdate, v_hire_date));
        return v_hire_month;
        
        exception 
        when no_data_found then
        return -1;
    end;
end;


--Test exercise 2.1
select pkg_func.sum_salary(100) from dual;

--Test exercise 2.2
select pkg_func.name_con('US') from dual;

--Test exercise 2.3
select pkg_func.annual_comp(25000, 0.05) from dual;

--Test exercise 2.4
select pkg_func.avg_sal(100) from dual;

--Test exercise 2.5
select pkg_func.time_work(100) from dual;


--------------------------------------
--Exercise 3.1
create or replace trigger tr_hire_date
after insert or update
on employees
for each row
declare v_hire_date employees.hire_date%type;
begin
    if(v_hire_date > sysdate)
        then raise_application_error(-20020, 'Invalid hire date');
    end if;
end;

--Test exercise 3.1
insert into employees values (250, 'test', 'test', 'test', '515.123.4567', TO_DATE('17-06-2023', 'dd-MM-yyyy'), 'AD_PRES', 24000, null, null, 90); 

--Exercise 3.2
create or replace trigger tr_salary
before insert or update on jobs 
for each row
begin
    if(:new.min_salary > :new.max_salary)
        then raise_application_error(-20022, 'Invalid salary');
    end if;
end;

--Test exercise 3.2
insert into jobs values ('test', 'test', 2500, 250);  

--Exercise 3.3
create or replace trigger tr_date
before insert or update on job_history
for each row
begin
    if(:new.start_date > :new.end_date)
        then raise_application_error(-20021, 'Start date must be less than end date');
    end if;
end;

--Test exercise 3.3
insert into job_history values (250, TO_DATE('13-01-2016', 'dd-MM-yyyy'), TO_DATE('24-07-2006', 'dd-MM-yyyy'), 'IT_PROG', 60);

--Exercise 3.4
create or replace trigger tr_sal_comm
before update on employees
for each row
begin
    if(:new.salary <: old.salary) 
        then raise_application_error(-20022, 'The updated salary must be greater than the current salary');
    end if;
    
    if(:new.commission_pct <: old.commission_pct)
        then raise_application_error(-20022, 'The updated commission must be greater than the current commission');
    end if;
end;

--Test exercise 3.1
update employees set salary = 1 where employee_id = 250;


--Drop package body
drop package body pkg_proc;
drop package body pkg_func;

--Drop package
drop package pkg_proc;
drop package pkg_func;

--Drop trigger
drop trigger tr_date;
drop trigger tr_hire_date;
drop trigger tr_sal_comm;
drop trigger tr_salary;





