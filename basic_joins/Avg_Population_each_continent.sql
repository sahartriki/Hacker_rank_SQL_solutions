SELECT coun.continent ,   FLOOR(AVG(c.population)) as avg_population
from country coun
join city c ON c.countrycode=coun.code
group by  coun.continent ; 
