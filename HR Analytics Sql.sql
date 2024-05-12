SELECT * FROM emp_attrition.emp_data;
select count(*) from emp_data;

-- -----------------------------------------------------------------------------------------------------------------------------
-- 1. Write an SQL query to find the details of employee under attrition having 5+ year of experience between age group 27-35 --
-- Count = 9044 empployee are coming under this category

select * from emp_data
where Age between 27 and 35
and TotalWorkingYears > 5;

-- 2. Fetch the details of the employee having maximum and minimum salary working in different departments who recieved less then 15% salary hikes --

select Department, max(monthlyincome) as Max_Salary, min(monthlyincome) as Min_Salary from emp_data
where PercentSalaryHike<15
group by Department;

-- 3. Calculate the avg monthly income of all employees who worked more then 5 year and who has medical background --

select avg(monthly_income) as avg_salary
from emp_data 
where year_at_company > 5 and education_field = "Medical";

-- 4.Identify the total number of male and female employees under attrition whose marital status is married and haven't recieved promotion in last 4 years. --

select gender, count(*) as total_count from emp_data
where marital_status = "Married" and yearsince_last_promotion >=4 and attrition = "Yes"
group by gender;

-- 5. Employees with max performance rating but no promotion in last 6 years and above.
-- Count = Total of 6371 employees are coming under this category

select count(*) from emp_data 
where performance_rating = (select max(performance_rating) as max_performance_rating from emp_data) and
yearsince_last_promotion >= 6;

-- 6. Number of employees in each departments who are being travelling frequently --

select department, business_travel, count(*) as employee_count from emp_data
where business_travel = "Travel_Frequently"
group by department
order by employee_count desc;

select emp_id, year_at_company, performance_rating, yearsince_last_promotion, max(percent_salary_hike) as max_salaryhike, min(percent_salary_hike) as min_salaryhike from emp_data
group by emp_id, year_at_company, performance_rating, yearsince_last_promotion 
order by max_salaryhike desc, min_salaryhike asc;


-- 7. Employees working overtime but given minimum and maximum salary hike and are more than 5 years with the company
-- Count = 319 Employess come under minimum category
--         326 coming under maximum category
select * from emp_data
where over_time = "Yes" and year_at_company > 5 and 
percent_salary_hike = (select min(percent_salary_hike) from emp_data);

 select count(*) from emp_data
where over_time = "Yes" and year_at_company > 5 and 
percent_salary_hike = (select max(percent_salary_hike) from emp_data);

-- 8. Which 3 department have the high job_satisfaction score and which 3 has the lowest .

select department, round(avg(job_satisfaction),2) as satisfaciton_rating from emp_data
group by department
order by round(avg(job_satisfaction),2) desc;

-- 9. What is the difference between salary and job satisfaction rating.

select job_satisfaction, avg(monthly_income) as avg_salary from emp_data
group by job_satisfaction
order by avg(monthly_income) desc;