--Exploratory analysis and descriptive statistics--
/* The results of this analysis have helped me better understand some of the key properties of the data, 
	as well as some important relationships between key variables of interest. These results matched the results I gathered
	from the other statistical programs I originally used. 
	
	Skills used in this project: Rounding, AVG, Min/Max, Median, Unions*/

--Means of the variables of interest (rounded to two decimal places)--

SELECT ROUND(AVG(p1_income_cafe_w5), 2) AS avg_parent_income,
	   ROUND(AVG(p1_education_w5), 2) AS avg_parent_education,
	   ROUND(AVG(p1_maritalstat_w5), 2) AS avg_parent_marital_status,
	   ROUND(AVG(p1_c_age_w5), 2) AS avg_child_age,
	   ROUND(AVG(p1_c_sex_w5), 2) AS avg_child_sex,
	   ROUND(AVG(pmu_sum), 2) AS avg_child_pmu,
	   ROUND(AVG(rsa_baseline), 2) AS avg_rsa_baseline,
	   ROUND(AVG(temp_na), 2) AS avg_negative_affect,
	   ROUND(AVG(temp_ec), 2) AS avg_effortful_control,
	   ROUND(AVG(temp_s), 2) AS avg_surgency
FROM ThesisProject..ThesisData;

--Standard deviations of the variables of interest (rounded to two decimal places)--
SELECT ROUND(STDEV(p1_income_cafe_w5), 2) AS sd_parent_income,
	   ROUND(STDEV(p1_education_w5), 2) AS sd_parent_education,
	   ROUND(STDEV(p1_maritalstat_w5), 2) AS sd_parent_marital_status,
	   ROUND(STDEV(p1_c_age_w5), 2) AS sd_child_age,
	   ROUND(STDEV(p1_c_sex_w5), 2) AS sd_child_sex,
	   ROUND(STDEV(pmu_sum), 2) AS sd_child_pmu,
	   ROUND(STDEV(rsa_baseline), 2) AS sd_rsa_baseline,
	   ROUND(STDEV(temp_na), 2) AS sd_negative_affect,
	   ROUND(STDEV(temp_ec), 2) AS sd_effortful_control,
	   ROUND(STDEV(temp_s), 2) AS sd_surgency
FROM ThesisProject..ThesisData;

--Min/Max of the variables of interest (rounded to two decimal places)--
SELECT ROUND(MIN(p1_income_cafe_w5), 2) AS min_parent_income,
	   ROUND(MIN(p1_education_w5), 2) AS min_parent_education,
	   ROUND(MIN(p1_maritalstat_w5), 2) AS min_parent_marital_status,
	   ROUND(MIN(p1_c_age_w5), 2) AS min_child_age,
	   ROUND(MIN(p1_c_sex_w5), 2) AS min_child_sex,
	   ROUND(MIN(pmu_sum), 2) AS min_child_pmu,
	   ROUND(MIN(rsa_baseline), 2) AS min_rsa_baseline,
	   ROUND(MIN(temp_na), 2) AS min_negative_affect,
	   ROUND(MIN(temp_ec), 2) AS min_effortful_control,
	   ROUND(MIN(temp_s), 2) AS min_surgency
FROM ThesisProject..ThesisData;

SELECT ROUND(MAX(p1_income_cafe_w5), 2) AS max_parent_income,
	   ROUND(MAX(p1_education_w5), 2) AS max_parent_education,
	   ROUND(MAX(p1_maritalstat_w5), 2) AS max_parent_marital_status,
	   ROUND(MAX(p1_c_age_w5), 2) AS max_child_age,
	   ROUND(MAX(p1_c_sex_w5), 2) AS max_child_sex,
	   ROUND(MAX(pmu_sum), 2) AS max_child_pmu,
	   ROUND(MAX(rsa_baseline), 2) AS max_rsa_baseline,
	   ROUND(MAX(temp_na), 2) AS max_negative_affect,
	   ROUND(MAX(temp_ec), 2) AS max_effortful_control,
	   ROUND(MAX(temp_s), 2) AS max_surgency
FROM ThesisProject..ThesisData;

--Median of the variables of interest (rounded to two decimal places)--
SELECT 
    'p1_income_cafe_w5' AS variable_name,
    ROUND((SELECT TOP 1 PERCENTILE_DISC(0.50) 
	WITHIN GROUP (ORDER BY p1_income_cafe_w5) 
	OVER() FROM ThesisProject..ThesisData), 2) AS median_value
UNION 
SELECT 
    'p1_education_w5' AS variable_name,
    ROUND((SELECT TOP 1 PERCENTILE_DISC(0.50) 
	WITHIN GROUP (ORDER BY p1_education_w5) 
	OVER() FROM ThesisProject..ThesisData), 2)
UNION 
SELECT 
    'p1_maritalstat_w5' AS variable_name,
    ROUND((SELECT TOP 1 PERCENTILE_DISC(0.50) 
	WITHIN GROUP (ORDER BY p1_maritalstat_w5) 
	OVER() FROM ThesisProject..ThesisData), 2)
UNION 
SELECT 
    'p1_c_age_w5' AS variable_name,
    ROUND((SELECT TOP 1 PERCENTILE_DISC(0.50) 
	WITHIN GROUP (ORDER BY p1_c_age_w5) 
	OVER() FROM ThesisProject..ThesisData), 2)
UNION 
SELECT 
    'p1_c_sex_w5' AS variable_name,
    ROUND((SELECT TOP 1 PERCENTILE_DISC(0.50) 
	WITHIN GROUP (ORDER BY p1_c_sex_w5) 
	OVER() FROM ThesisProject..ThesisData), 2)
UNION 
SELECT 
    'pmu_sum' AS variable_name,
    ROUND((SELECT TOP 1 PERCENTILE_DISC(0.50) 
	WITHIN GROUP (ORDER BY pmu_sum) 
	OVER() FROM ThesisProject..ThesisData), 2)
UNION 
SELECT 
    'rsa_baseline' AS variable_name,
    ROUND((SELECT TOP 1 PERCENTILE_DISC(0.50) 
	WITHIN GROUP (ORDER BY rsa_baseline) 
	OVER() FROM ThesisProject..ThesisData), 2)
UNION 
SELECT 
    'temp_na' AS variable_name,
    ROUND((SELECT TOP 1 PERCENTILE_DISC(0.50) 
	WITHIN GROUP (ORDER BY temp_na) 
	OVER() FROM ThesisProject..ThesisData), 2)
UNION 
SELECT 
    'temp_ec' AS variable_name,
    ROUND((SELECT TOP 1 PERCENTILE_DISC(0.50) 
	WITHIN GROUP (ORDER BY temp_ec) 
	OVER() FROM ThesisProject..ThesisData), 2)
UNION 
SELECT 
    'temp_s' AS variable_name,
    ROUND((SELECT TOP 1 PERCENTILE_DISC(0.50) 
	WITHIN GROUP (ORDER BY temp_s) 
	OVER() FROM ThesisProject..ThesisData), 2);


--Finding correlations between main variables of interest (ChatGPT helped with this code since there is no built in function for correlation in SQL Server)--
--Correlation between children's problematic media use and their physiological regulation (baseline RSA value)--
-- Calculate mean of pmu_sum--
DECLARE @mean_pmu FLOAT;
SELECT @mean_pmu = AVG(pmu_sum) FROM ThesisProject..ThesisData;

-- Calculate mean of rsa_baseline--
DECLARE @mean_rsa FLOAT;
SELECT @mean_rsa = AVG(rsa_baseline) FROM ThesisProject..ThesisData;

-- Calculate covariance--
DECLARE @covariance FLOAT;
SELECT @covariance = SUM((pmu_sum - @mean_pmu) * (rsa_baseline - @mean_rsa)) / COUNT(*) FROM ThesisProject..ThesisData;

-- Calculate standard deviation of pmu_sum-0-
DECLARE @std_dev_pmu FLOAT;
SELECT @std_dev_pmu = SQRT(SUM(POWER(pmu_sum - @mean_pmu, 2)) / (COUNT(*) - 1)) FROM ThesisProject..ThesisData;

-- Calculate standard deviation of rsa_baseline--
DECLARE @std_dev_rsa FLOAT;
SELECT @std_dev_rsa = SQRT(SUM(POWER(rsa_baseline - @mean_rsa, 2)) / (COUNT(*) - 1)) FROM ThesisProject..ThesisData;

-- Calculate correlation coefficient--
SELECT 
    @covariance / (@std_dev_pmu * @std_dev_rsa) AS correlation;


--Correlation between children's problematic media use and their negative affect--
-- Calculate mean of pmu_sum--
DECLARE @mean_pmu FLOAT;
SELECT @mean_pmu = AVG(pmu_sum) FROM ThesisProject..ThesisData;

-- Calculate mean of temp_na--
DECLARE @mean_temp_na FLOAT;
SELECT @mean_temp_na = AVG(temp_na) FROM ThesisProject..ThesisData;

-- Calculate covariance--
DECLARE @covariance FLOAT;
SELECT @covariance = SUM((pmu_sum - @mean_pmu) * (temp_na - @mean_temp_na)) / COUNT(*) FROM ThesisProject..ThesisData;

-- Calculate standard deviation of pmu_sum--
DECLARE @std_dev_pmu FLOAT;
SELECT @std_dev_pmu = SQRT(SUM(POWER(pmu_sum - @mean_pmu, 2)) / (COUNT(*) - 1)) FROM ThesisProject..ThesisData;

-- Calculate standard deviation of temp_na--
DECLARE @std_dev_temp_na FLOAT;
SELECT @std_dev_temp_na = SQRT(SUM(POWER(temp_na - @mean_temp_na, 2)) / (COUNT(*) - 1)) FROM ThesisProject..ThesisData;

-- Calculate correlation coefficient--
SELECT 
    @covariance / (@std_dev_pmu * @std_dev_temp_na) AS correlation;


--Correlation between children's problematic media use and their effortful control--
-- Calculate mean of pmu_sum--
DECLARE @mean_pmu FLOAT;
SELECT @mean_pmu = AVG(pmu_sum) FROM ThesisProject..ThesisData;

-- Calculate mean of temp_ec--
DECLARE @mean_temp_ec FLOAT;
SELECT @mean_temp_ec = AVG(temp_ec) FROM ThesisProject..ThesisData;

-- Calculate covariance--
DECLARE @covariance FLOAT;
SELECT @covariance = SUM((pmu_sum - @mean_pmu) * (temp_ec - @mean_temp_ec)) / COUNT(*) FROM ThesisProject..ThesisData;

-- Calculate standard deviation of pmu_sum--
DECLARE @std_dev_pmu FLOAT;
SELECT @std_dev_pmu = SQRT(SUM(POWER(pmu_sum - @mean_pmu, 2)) / (COUNT(*) - 1)) FROM ThesisProject..ThesisData;

-- Calculate standard deviation of temp_ec--
DECLARE @std_dev_temp_ec FLOAT;
SELECT @std_dev_temp_ec = SQRT(SUM(POWER(temp_ec - @mean_temp_ec, 2)) / (COUNT(*) - 1)) FROM ThesisProject..ThesisData;

-- Calculate correlation coefficient--
SELECT 
    @covariance / (@std_dev_pmu * @std_dev_temp_ec) AS correlation;
