SELECT ename AS 사원명, job AS 직업, TO_CHAR(hiredate, 'YYYY-MM-DD') AS 입사일, sal AS 봉급 FROM emp WHERE (TO_CHAR(hiredate, 'YYYY')=1981 AND job=upper('salesman')) ORDER BY sal ASC;
-- 1번 정답

select ename AS 사원명, empno AS 사원번호, TO_CHAR(hiredate, 'YYYY-MM-DD') AS 입사일 from emp WHERE TO_CHAR(hiredate, 'MM')=12;
-- 2번 정답

SELECT ename, deptno, sal FROM emp WHERE (comm IS null OR comm=0) AND sal = 1500;
-- 3번 정답

SELECT ename, deptno, sal FROM emp WHERE deptno =20 AND sal> (SELECT avg(sal) FROM emp);
-- 4번 정답
