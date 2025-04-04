SELECT * FROM layoff.layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;
INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,location,  industry, total_laid_off, percentage_laid_off, `date`,stage, country, funds_raised_millions
) AS row_num
FROM layoffs_staging;



DELETE
FROM layoffs_staging2
WHERE row_num > 1;

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

-- standardizing data
SELECT company, trim(company)
FROM layoffs_staging2 ;

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'CRYPTO%';

UPDATE layoffs_staging2
SET industry = 'crypto'
WHERE industry LIKE 'CRYPTO%';

SELECT *
FROM layoffs_staging2
WHERE country LIKE 'UNITED STATES%'
ORDER BY 1;

SELECT 	`date`,
str_to_date(`date`, '%m/%d/%y')
FROM layoffs_staging2;

UPDATE layoffs_staging2 
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

-- FOR CHANGING COLUMN DATA TYPE
ALTER TABLE layoffs_staging2 
MODIFY COLUMN `date` DATE;

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;


SELECT *
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
    ON t1.company = t2.company
    AND t1.location = t2.location;
    
    
    
