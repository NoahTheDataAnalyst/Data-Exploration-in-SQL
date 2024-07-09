-- Exploratory data analysis

Select * 
from layoffs_cleaned;

select MAX(total_laid_off), MAX(percentage_laid_off)
from layoffs_cleaned;

Select * 
from layoffs_cleaned
where percentage_laid_off = 1
order by funds_raised_millions desc;

Select company, sum(total_laid_off)
from layoffs_cleaned
group by company
order by 2 desc;

Select industry, sum(total_laid_off)
from layoffs_cleaned
group by industry
order by 2 desc;

Select country, sum(total_laid_off)
from layoffs_cleaned
group by country
order by 2 desc;

Select `date`, sum(total_laid_off)
from layoffs_cleaned
group by  `date`
order by 2 desc;

select min(`date`), max(`date`)
from layoffs_cleaned;

Select company, sum(percentage_laid_off)
from layoffs_cleaned
group by company
order by 2 desc;

select substring(`date`,1,7) AS `month`, sum(total_laid_off)
from  layoffs_cleaned
where substring(`date`,1,7) is not null
group by `month`
order by 1 asc;

With rolling_total as 
(
select substring(`date`,1,7) AS `month`, sum(total_laid_off) as total_off
from  layoffs_cleaned
where substring(`date`,1,7) is not null
group by `month`
order by 1 asc
)
select `month`, total_off
, sum(total_off) over(order by `month`) as rolling_total
from rolling_total;

Select company, sum(total_laid_off)
from layoffs_cleaned
group by company
order by 2 desc;

Select company,YEAR(`date`), sum(total_laid_off)
from layoffs_cleaned
group by company, YEAR(`date`)
ORDER by 3 desc;

with company_day (company, days, total_laid_off) as (
select company, `date`, sum(total_laid_off)
from layoffs_cleaned
group by company, `date`
), company_day_rank as (
select *, dense_rank() over (partition by days order by total_laid_off desc) as ranking
from company_day
where days is not null
order by ranking asc
)
select * 
from company_day_rank
where ranking <= 5;