--The following project aims to analyze data about 100'000'000 employees, with a special focus on the salary.
--Q1 Which is the highest paid job?
--Q2 Which are the TOP 20 jobs in terms of highest salary?
--Q3 Which is the least paid job?
--Q4 Which are the TOP 3 industries in terms of highest salary?
--Q5 Do workers with more years of experience get paid more?


--Q1 Which is the highest paid job?
Select d.jobType,
       d.industry,
       Max(s.salary) As Salary
  From Analysis.dataset As d
  Left Join Analysis.salaries As s
    ON d.jobId = s.jobId
 Where s.salary = (Select Max(salary) From Analysis.salaries)
 Group By d.jobType,
          d.industry;

--Q2 Which are the TOP 20 jobs in terms of highest salary?
SELECT 
    d.jobType,
    d.industry,
    s.salary AS Salary,
    RANK() OVER (PARTITION BY d.industry ORDER BY s.salary DESC) AS SalaryRank
FROM 
    Analysis.dataset AS d
LEFT JOIN 
    Analysis.salaries AS s ON d.jobId = s.jobId
ORDER BY 
    Salary DESC
LIMIT 20;


--Q3 Which is the least paid job?
SELECT 
    d.jobType,
    d.industry,
    s.salary AS Salary,
    RANK() OVER (PARTITION BY d.industry ORDER BY s.salary ASC) AS SalaryRank
FROM 
    Analysis.dataset AS d
LEFT JOIN 
    Analysis.salaries AS s ON d.jobId = s.jobId
ORDER BY 
    Salary ASC
LIMIT 20;

--Q4 Which are the TOP 3 industries in terms of highest salary?
Select
    d.industry,
    AVG(s.salary) AS Avg_Salary
From 
    Analysis.dataset AS d
Left Join 
    Analysis.salaries AS s ON d.jobId = s.jobId
Group By   
    d.industry  
Order By
    Avg_Salary DESC;



--Q5 Do workers with more years of experience get paid more?
SELECT 
    d.jobType,
    Cast(AVG(CASE WHEN d.yearsExperience BETWEEN 0 AND 5 THEN s.salary ELSE NULL END) As INT ) AS AvgSalary_0_5Exp,
    Cast(AVG(CASE WHEN d.yearsExperience BETWEEN 5 AND 10 THEN s.salary ELSE NULL END) AS INT) AS AvgSalary_5_10Exp,
    Cast(AVG(CASE WHEN d.yearsExperience BETWEEN 10 AND 15 THEN s.salary ELSE NULL END) As INT) AS AvgSalary_10_15Exp,
    Cast(AVG(CASE WHEN d.yearsExperience BETWEEN 15 AND 20 THEN s.salary ELSE NULL END)As INT) AS AvgSalary_15_20Exp,
    Cast(AVG(CASE WHEN d.yearsExperience > 20 THEN s.salary ELSE NULL END) As INT) AS AvgSalary_20PlusExp
FROM 
    Analysis.dataset AS d
LEFT JOIN 
    Analysis.salaries AS s ON d.jobId = s.jobId
GROUP BY 
    d.jobType;







































