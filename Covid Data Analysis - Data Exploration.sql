
--//% Covid Data Exploration Analysis //%


--Viewing both the tables

Select *
From CovidDataAnalysis..CovidDeaths
Where continent is not null 
order by location, date



Select *
From CovidDataAnalysis..CovidVaccinations
Where continent is not null 
order by location, date



-- Select Data Required

Select Location, date, total_cases, new_cases, total_deaths, population
From CovidDataAnalysis..CovidDeaths
Where continent is not null 
order by 1,2


--Covid impact Globally(Total Numbers)

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From CovidDataAnalysis..CovidDeaths
where continent is not null 
order by 1,2



--Contintents with the highest death count per population

Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From CovidDataAnalysis..CovidDeaths
Where continent is not null 
Group by continent
order by TotalDeathCount desc



-- Countries with Highest Death Count per Population

Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From CovidDataAnalysis..CovidDeaths
Where continent is not null 
Group by Location
order by TotalDeathCount desc


--Top 5 Countries with Highest Death Count per Population

Select TOP 5 
    Location, 
    MAX(CAST(Total_deaths AS INT)) AS TotalDeathCount
From CovidDataAnalysis..CovidDeaths
Where Continent IS NOT NULL
Group by Location
order by TotalDeathCount DESC;


-- Countries with Highest Infection Rate compared to Population

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From CovidDataAnalysis..CovidDeaths
Group by Location, Population
order by PercentPopulationInfected desc



-- Total Cases vs Population
-- Shows what percentage of population infected with Covid

Select Location, date, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
From CovidDataAnalysis..CovidDeaths
order by 1,2


-- Shows what percentage of population infected with Covid(India)

Select Location, date, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
From CovidDataAnalysis..CovidDeaths
Where location = 'India'
order by 1,2


-- Total Cases vs Total Deaths

Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From CovidDataAnalysis..CovidDeaths 
order by 1,2


-- Shows likelihood of dying if you contract covid in country (India)

Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From CovidDataAnalysis..CovidDeaths
Where location = 'India'
and continent is not null 
order by 1,2





--//% Queries used for Tableau Project //%




-- 1. Death Percentage

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From CovidDataAnalysis..CovidDeaths
where continent is not null 
--Group By date
order by 1,2



-- 2. 

Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From CovidDataAnalysis..CovidDeaths
Where continent is null 
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc


-- 3.

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From CovidDataAnalysis..CovidDeaths
Group by Location, Population
order by PercentPopulationInfected desc


-- 4.


Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From CovidDataAnalysis..CovidDeaths
Group by Location, Population, date
order by PercentPopulationInfected desc












