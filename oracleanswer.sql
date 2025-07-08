SELECT ename AS 사원명, job AS 직업, TO_CHAR(hiredate, 'YYYY-MM-DD') AS 입사일, sal AS 봉급 FROM emp WHERE (TO_CHAR(hiredate, 'YYYY')=1981 AND job=upper('salesman')) ORDER BY sal ASC;
-- 1번 정답

select ename AS 사원명, empno AS 사원번호, TO_CHAR(hiredate, 'YYYY-MM-DD') AS 입사일 from emp WHERE TO_CHAR(hiredate, 'MM')=12;
-- 2번 정답

SELECT ename, deptno, sal FROM emp WHERE (comm IS null OR comm=0) AND sal = 1500;
-- 3번 정답

SELECT ename, deptno, sal FROM emp WHERE deptno =20 AND sal> (SELECT avg(sal) FROM emp);
-- 4번 정답
1번 : 1981년에 입사한 saleman의 정보 출력(월급 내림차순)
2번 : 입사월이 12월인 사람들 뽑아서 사원명, 사원번호, 입사일
3번 : 커미션이 null과 0중에 월급이 가장 적은 사람
4번 : 평균보다 높은 봉급을 받는 이름, 부서번호, 월급 출력하기