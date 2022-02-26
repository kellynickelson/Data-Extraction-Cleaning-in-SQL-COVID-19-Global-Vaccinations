/*
SQL Data Extraction & Cleaning: COVID-19 Global Vaccinations 
Skills used: Joins, CTE's, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types
*/

-- Gloabl Daily New Vaccinations Graph
--- Shows the total number of new vaciations administered each day around the world. 
Select dea.location, dea.date,  vac.new_vaccinations
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.location='World'
order by 2


-- Global New Cases, Deaths, Vaccinations Table
--- Shows the global total cases, deaths, and vaccinations worldwide each year of the pandemic. 
Select dea.date, dea.location, dea.total_cases, dea.total_deaths, vac.total_vaccinations 
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.date in ('2020-12-31','2021-12-31','2022-01-04') AND dea.location='World' 
order by 1


-- Global Vaccine Distubtion by Income Level
--- Shows the current total vaccines administered and total number of people fully vacccinated broken down by nations income level.
Select dea.location, dea.date,  vac.people_fully_vaccinated, vac.total_vaccinations
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.location in ('high income', 'upper middle income','lower middle income','Low income') and dea.date='2022-01-04'
order by 1,2


-- Percent of Population Vaccinated by Country Map and Table
--- Shows the each countries percentage of the population fully vaccinated and the total number of people fully vaccinated each day. 
With vaccinatedpopulation (Continent, Location, Date, Population, rolling_people_fully_vaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, MAX(CONVERT(bigint,vac.people_fully_vaccinated)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as rolling_people_fully_vaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
)
Select *, (rolling_people_fully_vaccinated/Population)*100 as percent_of_population_fully_vaccinated
From vaccinatedpopulation







