/*
SQL Data Extraction & Cleaning: COVID-19 Global Vaccinations 
Skills used: Joins, CTE's, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types
*/

-- Gloabl Daily New Vaccinations Graph
--- Shows the total number of new vaciations administered each day around the world. 
SELECT dea.location, dea.date,  vac.new_vaccinations
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.location='World'
ORDER BY 2


-- Global New Cases, Deaths, Vaccinations Table
--- Shows the global total cases, deaths, and vaccinations worldwide each year of the pandemic. 
SELECT dea.date, dea.location, dea.total_cases, dea.total_deaths, vac.total_vaccinations 
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
Where dea.date IN ('2020-12-31','2021-12-31','2022-01-04') AND dea.location='World' 
ORDER BY 1


-- Global Vaccine Distubtion by Income Level
--- Shows the current total vaccines administered and total number of people fully vacccinated broken down by nations income level.
SELECT dea.location, dea.date,  vac.people_fully_vaccinated, vac.total_vaccinations
From PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.location in ('high income', 'upper middle income','lower middle income','Low income') AND dea.date='2022-01-04'
ORDER BY 1,2


-- Percent of Population Vaccinated by Country Map and Table
--- Shows the each countries percentage of the population fully vaccinated and the total number of people fully vaccinated each day. 
WITH vaccinatedpopulation (Continent, Location, Date, Population, rolling_people_fully_vaccinated)
AS
(
SELECT dea.continent, dea.location, dea.date, dea.population, MAX(CONVERT(bigint,vac.people_fully_vaccinated)) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date) AS rolling_people_fully_vaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL 
)
SELECT *, (rolling_people_fully_vaccinated/Population)*100 AS percent_of_population_fully_vaccinated
FROM vaccinatedpopulation







