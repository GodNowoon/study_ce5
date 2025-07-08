/* 주의 사항
 * 단일 line 주석 작성시 -- 와 내용 사이에 blank 필수
 * 
 * step01 - 기본검색
 * select절, from절 - select절엔 검색 컬럼이 들어가고 from절엔 table명
 * step02 - 정렬이 포함된 정렬검색문장
 * select절 from절 orderby절
 * order by절엔 어떤 컬럼을 내림차순/오름차순 정렬할지 설정함.
 * step03 - 조건검색
 *  select절 
 *  from절
 *  where절
 * 
 * step04 - 조건&정렬 검색
 *  select절
 *  from절
 *  where절
 *  order by절
 * 
 *  ***mysql만의 특징 = 데이터값의 대소문자구분을 기본으로하진않음
 * 					  근데 데이터엔 대소문자 구분은 필수로 해야됨
 * 	mysql db선택시
 * 		해결책1:table 생성후 alter로 대소문자 구분하게 설정
 * 		해결책2:select시 binary() 사용해서 처리 
 *
 */


select * from emp;
select * from dept;
desc emp;
desc dept;

-- 1. 해당 계정이 사용 가능한 모든 table 검색
SELECT * FROM tab;
-- 2. emp table의 모든 내용(모든 사원(row), 속성(컬럼)) 검색
select * from emp;
-- 3. emp의 구조 검색
asc emp;

-- 4. emp의 사번(empno)만 검색, 정렬만 미적용됨
-- 오름차순정렬 ASC 내림차순 DESC
select empno from emp;

select empno from emp order by empno DESC;

-- 5. emp의 사번(empno), 이름(ename)만 검색 = 하나 이상 검색할땐 쉼표표기로 구분
select empno, ename from emp;


-- 6. emp의 사번(empno), 이름(ename)만 검색(별칭 적용)
-- "as 별칭" 문법 적용
select empno as "사 번", ename as "사원명" from emp;

-- 7. 부서 번호(deptno) 검색
select deptno from dept;
-- 8. 중복 제거된 부서 번호 검색 / distinct
select distinct deptno from emp;

-- 9. 8 + 오름차순 정렬(order by)해서 검색
-- 오름 차순 : asc  / 내림차순 : desc
select distinct deptno from emp order by deptno asc;

-- 10. ? 사번(empno)과 이름(ename) 검색 단 사번은 내림차순(order by desc) 정렬
select empno, ename from emp order by empno DESC;
-- 11. ? dept table의 deptno 값만 검색 단 오름차순(asc)으로 검색. 정렬시 반드시 orderby로 처리해라.
select deptno from dept order by deptno asc;

-- 12. ? 입사일(hiredate) 검색, 
-- 입사일이 오래된 직원부터 검색되게 해 주세요
-- 고려사항 : date 타입도 정렬(order by) 가능 여부 확인
-- 데이터 탐색용 단순검색
SELECT ename, TO_CHAR(hiredate, 'YYYY-MM-DD') AS hiredate
FROM emp
ORDER BY hiredate ASC;

select ename, hiredate from emp order by hiredate asc;

-- 13. ?모든 사원의 이름과 월 급여(sal)와 연봉 검색
select ename as 사원명, sal as 월급, sal*12 as 연봉 from emp;
select ename, comm from emp order by comm asc;
-- 14. ?모든 사원의 이름과 월급여(sal)와 연봉(sal*12) 검색
-- 단 comm 도 고려(+comm) = 연봉(sal*12) + comm
select ename, sal, comm+(sal*12) as 연봉 from emp;
-- 널연산불가 대안책:대체값을 0으로 치환해야됨
select ename, NVL(comm,0) from emp;

select ename as 사원명, sal as 월급, NVL(comm,0)+(sal*12) as 연봉 from emp;


-- *** 조건식 ***
-- 15. comm이 null인 사원들의 이름과 comm만 검색
-- where 절 : 조건식 의미
select ename, comm from emp where(comm is null);


-- 16. comm이 null이 아닌 사원들의 이름과 comm만 검색
-- where 절 : 조건식 의미
-- 아니다 라는 부정 연산자 : not 
select ename, comm from emp where comm is not null;
-- ?모든 직원명, comm으로 내림 차순 정렬
select ename, comm from emp order by comm desc;
-- null값 보유컬럼 오름차순 정렬인 경우 null 부터 검색 


-- 17. ? 사원명이 SMITH인 사원의 이름과 사번만 검색
-- = : db에선 동등비교 연산자
-- 참고 : 자바에선  == 동등비교 연산자 / = 대입연산자
select ename, empno from emp where ename='SMITH';

-- 18. 부서번호가 10번 부서의 직원들 이름, 사번, 부서번호 검색
-- 단, 사번은 내림차순 검색
select ename, empno, deptno from emp where deptno =10 order by empno desc;
-- 실행순서 : from where select orderby

-- 19. ? 기본 syntax를 기반으로 
-- emp  table 사용하면서 문제 만들기
select empno, ename , job      ,mgr ,hiredate  ,sal    ,deptno from emp order by deptno, empno asc;

-- ?부서 번호(deptno)는 오름 차순(asc) 
-- 단 해당부서(deptno)에 속한 직원번호(empno)도 오름차순(asc) 정렬


-- 결과가 맞는 문장인지의 여부 확인을 위한 추가 문장 개발해 보기 
select empno, ename , job ,mgr ,hiredate ,sal ,deptno from emp order by deptno asc order by empno desc;


-- 입사일이 1981/1/1 이후인 직원들의 이름, 입사일 출력 by 용훈
select ename, hiredate from emp where hiredate>=1981/1/1;
-- 직업이 SALESMAN인 사람들의 평균 급여 출력 by 용훈
select avg(sal) from emp where job=SALESMAN;

-- 20. 급여(sal)가 900(>=)이상인 사원들 이름, 사번, 급여 검색 
select ename, empno, sal from emp where sal>=900;
-- 20-1. 이름오름차순
select ename, empno, sal from emp where sal>=900 order by ename asc;

-- 20-2. sal 오름차순 이름은 내림차순
select ename, empno, sal from emp where sal>=900 order by sal asc, ename desc;
/*order by sal asc, ename asc
 * sal asc 후 ename asc
 * 
 */

-- 21. deptno 10, job 은 manager(대문자로) 이름, 사번, deptno, job 검색
-- 검색성공
select ename, empno, deptno, job from emp where job='MANAGER';

select ename, empno, deptno, job from emp where job=upper('manager');

-- 무조건 데이터를 대문자로 변경후에 검색
-- upper : 대문자 의미하는 용어 lower : 소문자
select job from emp where job=upper('manager');



-- 대문자 : upper / 소문자 : lower   / uppercase (대문자의미)

-- smith 소문자를 대문자로 변경해서 비교
select ename from emp where ename=upper('smith');

-- 22.? deptno가 10 아닌 직원들 사번, 부서번호만 검색
-- 부정연산자 not / != / <> 다 같은 의미
select empno, deptno from emp where deptno!=10;
select empno, deptno from emp where deptno<>10;
select empno, deptno from emp where not deptno=10;
-- 23. sal이 2000이하(sal <= 2000) 이거나(or) 3000이상(sal >= 3000)인 사원명, 급여 검색
select empno, sal from emp where sal <=2000 or sal>=3000 order by sal asc;
-- 24.  comm이 300 or 500 or 1400인
select empno, comm from emp where comm in(300 , 500, 1400);

-- in 연산식 사용해서 좀더 개선된 코드
-- 25. ?  comm이 300 or 500 or 1400이 아닌 사원명 검색
-- null값 미포함!!!


-- 26. 81/09/28 날 입사한 사원 이름.사번 검색
select ename, empno, hiredate from emp where hiredate='1981-09-28';
-- date 타입 비교 학습
-- date 타입은 '' 표현식 가능 
-- yy/mm/dd 포멧은 차후에 변경 예정(함수)

SELECT ename, empno FROM emp where TO_CHAR(hiredate, 'YYYY-MM-DD')='1981-09-28';

-- 27. 날짜 타입의 범위를 기준으로 검색
-- 범위비교시 연산자 : between~and 1980-12-17~1981-09-28
select ename, TO_CHAR(hiredate, 'YYYY-MM-DD') AS 입사일 from emp where TO_CHAR(hiredate, 'YYYY-MM-DD') between '1980-12-17' and '1981-09-28';

-- 28. 검색시 포함된 모든 데이터 검색하는 기술 실행속도는낮음 / 빠른 검색기능은 검색엔진이 내장된 sw들 사용을 권장함
-- 순수 sql문장으로 검색. % : 철자개수 무관하게 검색
-- like 연산자 사용
-- % : 철자 개수 무관하게 검색 / _ : 철자 개수 하나를 의미


-- _M은 두글자임
-- 29. 두번째 음절의 단어가 M(_M)인 모든 사원명 검색 
select ename from emp where ename like '_M%';

-- 30. 단어가 M을 포함한 모든 사원명 검색 
select ename from emp where ename like '%M%';


 




SELECT ename AS 사원명, job AS 직업, TO_CHAR(hiredate, 'YYYY-MM-DD') AS 입사일, sal AS 봉급 FROM emp WHERE (TO_CHAR(hiredate, 'YYYY')=1981 AND job=upper('salesman')) ORDER BY sal ASC;
-- 1번 : 1981년에 입사한 saleman의 정보 출력(월급 내림차순)

select ename AS 사원명, empno AS 사원번호, TO_CHAR(hiredate, 'YYYY-MM-DD') AS 입사일 from emp WHERE TO_CHAR(hiredate, 'MM')=12;
-- 2번 : 입사월이 12월인 사람들 뽑아서 사원명, 사원번호, 입사일

SELECT ename, deptno, sal FROM emp WHERE (comm IS null OR comm=0) AND sal = 1500;
-- 3번 : 커미션이 null과 0중에 월급이 가장 적은 사람

SELECT ename, deptno, sal FROM emp WHERE deptno =20 AND sal> (SELECT avg(sal) FROM emp);
-- 4번 : 평균보다 높은 봉급을 받는 이름, 부서번호, 월급 출력하기
