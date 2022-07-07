SELECT *
FROM CovidDeaths_csv cdc 
WHERE continent is NOT NULL;

SELECT *
FROM CovidVaccinations_csv cvc ;

--selecting data that i will be using

SELECT location, date, total_cases, new_cases ,total_deaths ,population 
from CovidDeaths_csv cdc 
order by 1,2 ;

--checking out total cases vs total death
--percentage of dying from covid based on country

SELECT location, date, total_cases ,total_deaths , 
(total_deaths*100)/total_cases as deathPercentage 
from CovidDeaths_csv cdc
WHERE location LIKE 'n%ria';

--looking at total cases vs population

SELECT location, date, population , total_cases , 
(total_cases*100)/population as populationinfectedPercentage
from CovidDeaths_csv cdc
WHERE location LIKE 'n%ria';

--looking at countries with highest infection rate compared to population

SELECT location, population , MAX(total_cases),
max((total_cases*100)/population) as populationPercentinfected
from CovidDeaths_csv cdc
group by location  
ORDER BY populationPercentinfected DESC ;
--WHERE location LIKE 'n%ria';

--looking at countries with highest death rate compared to population

SELECT location, population , MAX(CAST (total_deaths as int)),
max((total_deaths *100)/population) as populationPercentdeath
from CovidDeaths_csv cdc
group by location  
ORDER BY populationPercentdeath DESC ;
--WHERE location LIKE 'n%ria';

--OR

SELECT location, population , sum(new_deaths),
max((new_deaths *100)/population) as populationPercentdeath
from CovidDeaths_csv cdc
group by location  
ORDER BY populationPercentdeath DESC ;
--WHERE location LIKE 'n%ria';


--Countries with highest death count per population

SELECT location, MAX(CAST (total_deaths as int)) as totaldeathcount
from CovidDeaths_csv cdc
group by location 
ORDER BY totaldeathcount DESC ;
--WHERE location LIKE 'n%ria';

--continent with highesr death count

SELECT continent , MAX(CAST (total_deaths as int)) as totaldeathcount
from CovidDeaths_csv cdc
group by continent  
ORDER BY totaldeathcount DESC ;
--WHERE location LIKE 'n%ria';

-- global number

SELECT date, SUM(new_cases) as totalcases, SUM(new_deaths) as totaldeaths , 
((SUM(new_deaths))*100)/SUM(new_cases) as death_percentage
from CovidDeaths_csv cdc
group by date 
order by 2;

SELECT SUM(new_cases) as totalcases, SUM(new_deaths) as totaldeaths , 
((SUM(new_deaths))*100)/SUM(new_cases) as death_percentage
from CovidDeaths_csv cdc;

-- joining my two tables
-- looking at total population vs total vaccination

select cdc.continent  ,cdc.location  , cdc.date , 
cdc.population, 
cvc.new_vaccinations ,
SUM(cvc.new_vaccinations) over (PARTITION by cdc.location order by cdc.location,cdc.date)
as rollingpeoplevaccinated
from CovidDeaths_csv cdc 
join
CovidVaccinations_csv cvc 
on cdc.location = cvc.location 
and cdc.date = cvc.date 
where cdc.continent NOTNULL ;

-- use CTE

with popvsVac (continent, location, date, population,new_vaccinations, rollingpeoplevaccinated)
as (
select cdc.continent  ,cdc.location  , cdc.date , 
cdc.population, 
cvc.new_vaccinations ,
SUM(cvc.new_vaccinations) over (PARTITION by cdc.location order by cdc.location,cdc.date)
as rollingpeoplevaccinated
from CovidDeaths_csv cdc 
join
CovidVaccinations_csv cvc 
on cdc.location = cvc.location 
and cdc.date = cvc.date
)
SELECT *, (rollingpeoplevaccinated*100)/population as percentagerolling
FROM popvsVac;

-- TEMP TABLE
drop table if exists #percentpopulationvaccinated
create table #percentpopulationvaccinated
(
continent varchar(255),
location varchar(255),
date datetime,
population integer,
new_vaccinations integer,
rollingpeoplevaccinated integer
)

insert into #percentpopulationvaccinated
select cdc.continent  ,cdc.location  , cdc.date , 
cdc.population, 
cvc.new_vaccinations ,
SUM(cvc.new_vaccinations) over (PARTITION by cdc.location order by cdc.location,cdc.date)
as rollingpeoplevaccinated
from CovidDeaths_csv cdc 
join
CovidVaccinations_csv cvc 
on cdc.location = cvc.location 
and cdc.date = cvc.date;

SELECT *, (rollingpeoplevaccinated*100)/population as percentagerolling
FROM #percentpopulationvaccinated;


CREATE view percentpopulationvaccinated as
select cdc.continent  ,cdc.location  , cdc.date , 
cdc.population, 
cvc.new_vaccinations ,
SUM(cvc.new_vaccinations) over (PARTITION by cdc.location order by cdc.location,cdc.date)
as rollingpeoplevaccinated
from CovidDeaths_csv cdc 
join
CovidVaccinations_csv cvc 
on cdc.location = cvc.location 
and cdc.date = cvc.date;

SELECT *
FROM percentpopulationvaccinated;
