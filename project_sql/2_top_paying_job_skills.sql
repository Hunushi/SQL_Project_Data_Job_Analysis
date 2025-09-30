/*
Question : What skills are required for the top-paying data analyst jobs ?
- Use top 10 highest paying Data Analyst jobs from first query
- Add the specific skills required for these roles 
- Why? It provides a detailed look at wich highest paying jobs demand certain skills, helping job seekers understand wich skills to develop that align with top salaries
*/

WITH top_paying_jobs AS(
    SELECT 
        job_id,
        job_title,
        job_location,
        job_schedule_type,
        salary_year_avg,
        job_posted_date,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE 
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)
SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
    salary_year_avg DESC

/*Here’s what stands out from the skills column analysis for the top 10 data analyst roles in 2023:
🔑 Key Insights
-SQL (8 mentions) → The most in-demand skill, showing its central role in querying and managing data.
-Python (7 mentions) → Almost equally important, reflecting the demand for programming and analytics automation.
-Tableau (6 mentions) → Strong focus on data visualization and dashboarding.
-R (4 mentions) → Still relevant, especially for statistical and academic-heavy analysis.
-Snowflake, Pandas, Excel (3 mentions each) → Suggests demand for database/cloud data warehousing (Snowflake) and data wrangling tools (Pandas, Excel).
-Cloud & DevOps-related skills (Azure, Bitbucket, Go) → Indicate that analysts are increasingly expected to handle data in cloud environments and collaborate with engineering workflows.

📊 In short: SQL + Python + Visualization tools (Tableau) are the “must-haves”, while cloud, version control, and niche programming skills provide an extra competitive edge.

*/