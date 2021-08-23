Select *
 From PortfolioProject..CovidDeaths
 Order by 3,4


 --Select *
 --From PortfolioProject..CovidVaccinations
 --Order by 3,4
 
--Select Data we are going to be using 

Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
order by 1,2


-- Loking at Total cases vs Total Deaths 
Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage 
From PortfolioProject..CovidDeaths
Where location like '%states%'
order by 1,2




-- Loking at Total cases vs population
-- what % of the population got covid 19
Select Location, date, population, total_cases, (total_deaths/population)*100 as DeathPercentage 
From PortfolioProject..CovidDeaths
Where location like '%egypt%'
order by 1,2


-- Loking at Total cases vs population
-- what % of the population got covid 19
Select Location, date, population, total_cases, (total_deaths/population)*100 as DeathPercentage 
From PortfolioProject..CovidDeaths
--Where location like '%egypt%'
order by 1,2


-- Loking at Total cases vs population
-- what % of the population got covid 19
Select Location, date, population, total_cases, (total_deaths/population)*100 as DeathPercentage 
From PortfolioProject..CovidDeaths
--Where location like '%egypt%'
order by 1,2

-- countries with highest infection rate / population 
Select Location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_deaths/population)*100) as PercentPopulationInfected
From PortfolioProject..CovidDeaths
--Where location like '%egypt%'
Group by location, population
order by PercentPopulationInfected desc



--Countries with highest death count 
Select Location,  MAX(Cast(total_deaths as int)) AS TotalDeathCount
From PortfolioProject..CovidDeaths
--Where location like '%egypt%'
Where continent is not null
Group by location
order by TotalDeathCount desc


-- by continent 
--Countries with highest death count 
Select Location,  MAX(Cast(total_deaths as int)) AS TotalDeathCount
From PortfolioProject..CovidDeaths
--Where location like '%egypt%'
Where continent is  null
Group by location
order by TotalDeathCount desc

-- GLOAL NUMBERS
Select date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast
  (new_deaths as int))/SUM(New_cases)*100 As DeathPercentage
From PortfolioProject..CovidDeaths
Where continent is not null
Group by date
Order by 1,2 
-- 


-- GLOAL NUMBERS
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast
  (new_deaths as int))/SUM(New_cases)*100 As DeathPercentage
From PortfolioProject..CovidDeaths
Where continent is not null
--Group by date
Order by 1,2 



--- total population vs vaccination 

SELECT * 
FROM PortfolioProject..CovidVaccinations vac
JOIN PortfolioProject..CovidDeaths dea
     ON vac.location = dea.location 
	 and vac.date = dea.date


SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.location ORDER BY dea.location,
  dea.date) as RollingPeopleVaccinted

FROM PortfolioProject..CovidVaccinations vac
JOIN PortfolioProject..CovidDeaths dea
     ON vac.location = dea.location 
	 and vac.date = dea.date
WHERE dea.continent is not null
ORDER BY 2,3 



--use CTE 

with PopvsVac (continent, location, date, population, New_Vaccinations, RollingPeopleVaccinted)

as
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.location ORDER BY dea.location,
  dea.date) as RollingPeopleVaccinted

FROM PortfolioProject..CovidVaccinations vac
JOIN PortfolioProject..CovidDeaths dea
     ON vac.location = dea.location 
	 and vac.date = dea.date
WHERE dea.continent is not null
--ORDER BY 2,3 
)
SELECT * ,(RollingPeopleVaccinted/population)*100
FROM PopvsVac


-- temb table 
DROP TABLE if exists #PercentPopluationVaccinated
CREATE TABLE #PercentPopluationVaccinated
(
Continent nvarchar(225),
Location nvarchar(225),
Date datetime,
Popluation numeric,
New_vaccinations numeric,
RollingPeopleVaccinted numeric 

)
INSERT INTO #PercentPopluationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.location ORDER BY dea.location,
  dea.date) as RollingPeopleVaccinted

FROM PortfolioProject..CovidVaccinations vac
JOIN PortfolioProject..CovidDeaths dea
     ON vac.location = dea.location 
	 and vac.date = dea.date
WHERE dea.continent is not null
--ORDER BY 2,3

SELECT * ,(RollingPeopleVaccinted/Popluation)*100
FROM #PercentPopluationVaccinated


-- creating view to store data for viz 

Create View PercentPopulationVaccinated as 
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.location ORDER BY dea.location,
  dea.date) as RollingPeopleVaccinted

FROM PortfolioProject..CovidVaccinations vac
JOIN PortfolioProject..CovidDeaths dea
     ON vac.location = dea.location 
	 and vac.date = dea.date
WHERE dea.continent is not null
--ORDER BY 2,3