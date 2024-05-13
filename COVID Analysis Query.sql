/*
Project exploring Covid 19 Data

The following skills were used throughout this project: Joins, CTE's, Temp Tables, Window Functions, 
Aggregate Functions, Creating Views, Converting Data Types, Saving Views

*/

SELECT *
FROM PortfolioProject..CovidDeaths
ORDER BY 3,4;

--Selecting the data that I will be using

SELECT location, 
	   date, 
	   total_cases, 
	   new_cases, 
	   total_deaths, 
	   population
FROM PortfolioProject..CovidDeaths
ORDER BY  1, 2;

-- Looking at the Total Cases vs Total Deaths 
-- Shows the likelihood of dying if you contract COVID-19 

SELECT location, 
	   date, 
	   total_cases, 
	   total_deaths, 
	   CAST(total_deaths AS decimal)/CAST(total_cases AS decimal) * 100 AS deathtocases
FROM PortfolioProject..CovidDeaths
WHERE location like '%states%'
ORDER BY  1, 2;

-- Looking at the total cases vs population 
-- Shows what percentage of the U.S. population contracted COVID-19 
SELECT location, 
	   date, 
	   total_cases, 
	   population, 
	   CAST(total_cases AS decimal)/population * 100 AS casestopopulation
FROM PortfolioProject..CovidDeaths
WHERE location like '%states%'
ORDER BY  1, 2;


-- Looking at countries with highest infection rate compared to population 
SELECT location, 
	   MAX(total_cases) AS HighestInfectionCount, 
	   population, 
	   CAST(MAX(total_cases) AS decimal)/population * 100 AS percentpopulationinfected
FROM PortfolioProject..CovidDeaths
--WHERE location like '%states%'
GROUP BY location, population
ORDER BY percentpopulationinfected DESC;

--Showing the countries with the highest death count per population
SELECT location, 
	   MAX(CAST(total_deaths AS int)) AS deathcount 
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY deathcount DESC;

--Let's break things down by continent

--Showing continents with the highest death count 
SELECT continent, 
	   MAX(CAST(total_deaths AS int)) AS deathcount 
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY deathcount DESC;


--Global numbers
SELECT date,
	   SUM(new_cases) AS new_cases,
	   SUM(CAST(new_deaths AS int)) AS new_deaths
	   FROM PortfolioProject..CovidDeaths
	   WHERE continent IS NOT NULL
	   GROUP BY date
	   ORDER BY 1, 2;


-- Looking at total population vs vaccinations
--Shows the percentage of the population that has been vaccinated

SELECT dea.continent, 
       dea.location, 
	   dea.date, 
	   dea.population,
	   vax.new_vaccinations,
	   SUM(CAST(vax.new_vaccinations AS decimal)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_vaccinations
FROM PortfolioProject..CovidDeaths AS dea
JOIN PortfolioProject..CovidVaccinations AS vax
	ON dea.location = vax.location
	AND dea.date = vax.date
WHERE dea.continent IS NOT NULL
ORDER BY 2, 3;

-- Use cte
WITH popsvsvax (continent, location, date, population, new_vaccinations, rolling_vaccinations)
AS
(SELECT dea.continent, 
       dea.location, 
	   dea.date, 
	   dea.population,
	   vax.new_vaccinations,
	   SUM(CAST(vax.new_vaccinations AS decimal)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_vaccinations
FROM PortfolioProject..CovidDeaths AS dea
JOIN PortfolioProject..CovidVaccinations AS vax
	ON dea.location = vax.location
	AND dea.date = vax.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2, 3
)
SELECT *, (rolling_vaccinations)*100
FROM popsvsvax


-- Temp table

DROP TABLE IF EXISTS #percent_population_vaccinated
CREATE TABLE #percent_population_vaccinated 
(
	continent nvarchar(255),
	location nvarchar(255),
	date datetime,
	population numeric,
	new_vaccinations numeric,
	rolling_vaccinations numeric
)
INSERT INTO #percent_population_vaccinated
SELECT dea.continent, 
       dea.location, 
	   dea.date, 
	   dea.population,
	   vax.new_vaccinations,
	   SUM(CAST(vax.new_vaccinations AS decimal)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_vaccinations
FROM PortfolioProject..CovidDeaths AS dea
JOIN PortfolioProject..CovidVaccinations AS vax
	ON dea.location = vax.location
	AND dea.date = vax.date
--WHERE dea.continent IS NOT NULL
--ORDER BY 2, 3

SELECT *,
	   (rolling_vaccinations/population)*100
FROM #percent_population_vaccinated


-- Creating a view to store data for later visualizations

CREATE VIEW percent_population_vaccinated AS
SELECT dea.continent, 
       dea.location, 
	   dea.date, 
	   dea.population,
	   vax.new_vaccinations,
	   SUM(CAST(vax.new_vaccinations AS decimal)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_vaccinations
FROM PortfolioProject..CovidDeaths AS dea
JOIN PortfolioProject..CovidVaccinations AS vax
	ON dea.location = vax.location
	AND dea.date = vax.date
WHERE dea.continent IS NOT NULL;

SELECT *
FROM percent_population_vaccinated