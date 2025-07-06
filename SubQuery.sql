
#1. Select all employee and salary who are earning more than employee 7839
	#					salary grater than 7839
select * from emp where sal>(select sal from emp where empno=7839);

#2. Select employee name, salary, employee 7839 's salary for employess earning more than employee 7839
select ename,sal,(select sal from emp where empno=7839) from emp where  sal> (select sal from emp where empno=7839);

#3.Select all detail of employee who belong to same department as employee 7839
select * from emp where deptno=(select deptno from emp where empno=7839);

#4. Select all employee names, their salary and total average salary of all emplloyees who are earning more than the average salary
select ename,sal,(select avg(sal) from emp) from emp where sal > (select avg(sal) from emp);

#5. Select all employee detail who are hired before BLAKE
select * from emp where hiredate > (select hiredate from emp where ename='blake');
#6. Select all employee name and salary who are earning more than BLAKE but less than KING

#7. select all department numbers which has more number of employees than department 10
select deptno ,count(*) from emp group by deptno  having count(*)> (select count(*) from emp where deptno=10);

#8. select department names which has more number of employees working than department 10 

select d.DNAME,d.DEPTNO ,COUNT(*) AS emp_count from emp e
 join dept d on e.DEPTNO=d.DEPTNO
group by  d.DNAME,d.DEPTNO
having count(*)> (select count(*) from emp where DEPTNO=10);

--     --
SELECT d.DNAME, d.DEPTNO, COUNT(*) AS emp_count
FROM emp e
JOIN dept d ON e.DEPTNO = d.DEPTNO
GROUP BY d.DNAME, d.DEPTNO
HAVING COUNT(*) > (
    SELECT COUNT(*) FROM emp WHERE DEPTNO = 10
);


#9. Select all department names which has more number of employees working than 'ACCOUNTING' department

select dname ,count(*) from emp e join dept d on e.deptno=d.deptno
group by  dname
having count(*)> (select count(*) from emp e join dept d on e.deptno=d.deptno where  dname='ACCOUNTING');

#10. Write a SQL query to display 3rd highest salary using subquery [Without using Ranking functions]

select max(sal) from emp ;  -- 1st
select max(sal) from emp where sal>(select max(sal) from emp);   -- 2nd

select max(sal) from emp where sal>(select max(sal) from emp where sal>(select max(sal) from emp));   -- 3rd

