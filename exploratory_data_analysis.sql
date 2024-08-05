-- Exploratory Data Analysis 

SELECT * 
FROM layoffs_staging2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT * 
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

SELECT company, SUM(total_laid_off) AS sum_laid_off
FROM layoffs_staging2
GROUP BY company
ORDER BY sum_laid_off DESC;

SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

SELECT industry, SUM(total_laid_off) AS sum_laid_off
FROM layoffs_staging2
GROUP BY industry
ORDER BY sum_laid_off DESC;

SELECT country, SUM(total_laid_off) AS sum_laid_off
FROM layoffs_staging2
GROUP BY country
ORDER BY sum_laid_off DESC;

SELECT YEAR(`date`) AS `year`, SUM(total_laid_off) AS sum_laid_off
FROM layoffs_staging2
GROUP BY `year`
ORDER BY `year`;

SELECT stage, SUM(total_laid_off) AS sum_laid_off
FROM layoffs_staging2
GROUP BY stage
ORDER BY sum_laid_off DESC;

SELECT 	company, AVG(percentage_laid_off) avg_percent
FROM layoffs_staging2
GROUP BY company
ORDER BY avg_percent DESC;

SELECT SUBSTRING(`date`, 1, 7) AS `month`, SUM(total_laid_off) AS sum_laid_off
FROM layoffs_staging2
GROUP BY `month`
HAVING `month` IS NOT NULL
ORDER BY `month`;

WITH rolling_total AS
(
SELECT SUBSTRING(`date`, 1, 7) AS `month`, SUM(total_laid_off) AS sum_laid_off
FROM layoffs_staging2
GROUP BY `month`
HAVING `month` IS NOT NULL
ORDER BY `month`
)
SELECT `month`, sum_laid_off, SUM(sum_laid_off) OVER(ORDER BY `month`) AS rolling_total_laid_off
FROM rolling_total;

SELECT company, YEAR(`date`) AS `year`, SUM(total_laid_off) AS sum_laid_off
FROM layoffs_staging2
GROUP BY company, `year`
ORDER BY company; 

WITH company_year AS
(
SELECT company, YEAR(`date`) AS `year`, SUM(total_laid_off) AS sum_laid_off
FROM layoffs_staging2
GROUP BY company, `year`
), company_year_rank AS
(
SELECT *, 
DENSE_RANK() OVER(PARTITION BY `year` ORDER BY sum_laid_off DESC) AS ranking
FROM company_year
WHERE `year` IS NOT NULL
)
SELECT *
FROM company_year_rank
WHERE ranking <= 5;









