-- Shows table in order of 3rd and 4th column
Select * From portfolioproject..CovidDeath
Order by 3,4

-- Shows table in order of 3rd and 4th column
Select * From portfolioproject..CovidVaccine;
Order by 3,4

-- Shows selected items in table
Select Location, Date, total_cases,  new_cases, total_deaths, population From portfolioproject..CovidDeath
Order by 1,2

-- Looking at total cases vs total deaths
Select Location, Date, total_cases,  total_deaths, (total_deaths/total_cases*100) as DeathPercentage From portfolioproject..CovidDeath 
Order by 1,2

-- Looking at total cases vs total deaths likelihood by location
Select Location, Date, total_cases,  total_deaths, (total_deaths/total_cases*100) as DeathPercentage From portfolioproject..CovidDeath 
Where location like '%states%'
Order by 1,2

-- Looking at total cases vs total deaths likelihood by location
Select Location, Date, total_cases, population, (total_cases/population*100) as PopulationPercentageInfection From portfolioproject..CovidDeath 
Where location like '%states%'
Order by 1,2

-- Looking at location wise with highest infection rate compared to population
Select Location, population, max(total_cases) as HighestInfectionCount, max((total_cases/population))*100 as PercentPopulationInfection From portfolioproject..CovidDeath 
Group by Location, population
Order by PercentPopulationInfection desc

-- Showing countries with highest death count per population
Select Location, max(cast(total_deaths as int)) as TotalDeathCount From portfolioproject..CovidDeath 
Where continent is not null
Group by Location
Order by TotalDeathCount desc

-- Lets break things down by continent
Select continent, max(cast(total_deaths as int)) as TotalDeathCount From portfolioproject..CovidDeath 
Where continent is not null
Group by continent
Order by TotalDeathCount desc

-- Global numbers
Select date, sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, 
sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage 
From portfolioproject..CovidDeath 
Where continent is not null
Group by date
Order by 1, 2

-- Joining both tables on basis of location and date
Select *
From portfolioproject..CovidDeath dea
Join portfolioproject..CovidVaccine vac
On dea.location = vac.location
And dea.date = vac.date

-- Looking at total population vs vaccinations
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
From portfolioproject..CovidDeath dea
Join portfolioproject..CovidVaccine vac
On dea.location = vac.location
And dea.date = vac.date
where dea.continent is not null
Order By 1, 2, 3

-- Looking at total population vs vaccination datewise with some calculation
With PopVsVac (Continent, location, date, population, new_vaccination, RollingPeopleVaccinated)
as(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as int)) Over (partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
From portfolioproject..CovidDeath dea
Join portfolioproject..CovidVaccine vac
On dea.location = vac.location
And dea.date = vac.date
where dea.continent is not null
)
Select *, (RollingPeopleVaccinated/population)*100 as PercentageOfRollingPeopleVaccinated
From PopVsVac

-- Create table of Percentage of People who vaccinated 
drop table if exists #PercentPeopleVaccinated2
Create table #PercentPeopleVaccinated2(
Continent nvarchar(255),
Location nvarchar(255),
date datetime,
Population numeric, 
New_vaccination numeric,
RollingPeopleVaccinated numeric)
-- Inserting data into table
Insert Into #PercentPeopleVaccinated2
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as int)) Over (partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
From portfolioproject..CovidDeath dea
Join portfolioproject..CovidVaccine vac
On dea.location = vac.location
And dea.date = vac.date
where dea.continent is not null
Select *, (RollingPeopleVaccinated/population)*100 as PercentageOfRollingPeopleVaccinated
From #PercentPeopleVaccinated2

-- Creating view with following data
Create View PercentPeopleVaccinated2 as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as int)) Over (partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
From portfolioproject..CovidDeath dea
Join portfolioproject..CovidVaccine vac
On dea.location = vac.location
And dea.date = vac.date
where dea.continent is not null
select * from PercentPeopleVaccinated2



