/*
Question : What are the most optimal skills to learn as a Data Scientist?
- identifying the skills with high demand and high average pay.
- Concentrates on remote positions with specified salaries.
- Why? targets skills that offer job security (high demand) and financial benefits (high salaries),
offering strategic insights for career development in data analysis.
*/

WITH optimal_skills AS (
    SELECT 
        skills_dim.skill_id,
        skills,
        COUNT(skills) AS demand_count,
        ROUND(AVG(salary_year_avg),0) as avg_salary

    FROM
        job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short LIKE '%Data_Scientist%' AND 
        salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id
    HAVING COUNT(skills) > 5
)
SELECT *,
    CASE 
        WHEN demand_count > 1000 AND avg_salary > 140000 THEN 'Tier 1'
        WHEN demand_count > 500 AND avg_salary > 140000 THEN 'Tier 2'
        ELSE 'Tier 3'
    END AS ratings
FROM 
    optimal_skills
ORDER BY 
    demand_count DESC , avg_salary DESC
LIMIT 20




