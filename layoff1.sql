-- data cleaning

SELECT * FROM layoffs;

-- 1. remove duplicates
-- 2. standardize the data
-- 3. null values or blank values
-- 4 . remove any columns

CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT *
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;



WITH duplicates_cte as (
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,location,  industry, total_laid_off, percentage_laid_off, `date`,stage, country, funds_raised_millions
) AS row_num
FROM layoffs_staging
)SELECT *
FROM duplicates_cte 
WHERE ROW_NUM > 1;

SELECT *
FROM layoffs_staging
WHERE company= 'casper';

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,location,  industry, total_laid_off, percentage_laid_off, `date`,stage, country, funds_raised_millions
) AS row_num
FROM layoffs_staging;

SELECT *
FROM duplicates_cte 
WHERE ROW_NUM > 1;

DELETE 
FROM layoffs_staging2
WHERE row_num > 1;		

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = ' ';

SELECT *
FROM layoffs_staging2
where company = 'airbnb';


SELECT *
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
    ON t1.company = t2.company
    AND t1.location = t2.location;
    
    
    
--



