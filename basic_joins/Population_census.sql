select SUM(c.population) as sum_population
from city c 
JOIN country  coun ON c.countrycode=coun.code
where coun.continent LIKE 'Asia' ; 
