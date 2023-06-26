--Download the csv file from https://drive.google.com/file/d/1SjwzAA6wSdeOBdmtOXD4zgfF5Sb0Lh4u/view?usp=drive_link and import the file. 

---Questions
-- 9.1 Give the package name and how many times they're downloaded. Order by the 2nd column descently.
Select package, count(package) as downloads from Logs
group by package
ORDER BY downloads DESC;

-- 9.2 Give the package ranking (based on how many times it was downloaded) during 9AM to 11AM
Select package, count(package) as downloads_9to11
from Logs
where time BETWEEN '09:00:00' and '11:00:00'
group by package
ORDER BY downloads_9to11 DESC;

-- 9.3 How many recordings are from China ("CN") or Japan("JP") or Singapore ("SG")?
SELECT count(package)
from Logs 
where country = 'CN' 
or country = 'JP' 
or country = 'SG';

-- 9.4 Print the countries whose downloaded are more than the downloads from China ("CN")
SELECT count(package)
from Logs 
where country = 'CN' ;

-- 9.5 Print the average length of the package name of all the UNIQUE packages
SELECT AVG(LENGTH(DISTINCT package))
FROM Logs;

-- 9.6 Get the package whose download count ranks 2nd (print package name and its download count).
SELECT package, downloads 
FROM (Select package, count(package) as downloads,
	RANK () OVER (order by count(package) desc) AS dl_rank
	from Logs
	group by package) as sq_rank
WHERE dl_rank = 2;

-- 9.7 Print the name of the package whose download count is bigger than 1000.
SELECT package, downloads
FROM (Select package, count(package) as downloads,
	RANK () OVER (order by count(package) desc) AS dl_rank
	from Logs
	group by package) as sq_rank
WHERE downloads >1000;

-- 9.8 The field "r_os" is the user's operating system. Show the most popular system (ignore version number), count, and the proportion (in percentage).
SELECT os_abbr, downloads, ROUND(1.0*downloads/all_downloads*100, 2) as os_percent_share
FROM(
	WITH cte_os_rank as ( 				---reference subquery as CTE
		SELECT os_abbr, downloads
		FROM (
			Select substr(r_os, 1, 4) as os_abbr, count(package) as downloads, ---use substring to properly ignore version, as some versions are included in the r_os string
			RANK () OVER (order by count(r_os) desc ) AS os_rank
			from Logs
			group by os_abbr) as os_rank
			)
	SELECT os_abbr, downloads,(SELECT COUNT(*) FROM Logs) as all_downloads --- add a separate count of total downloads to each grouped record to allow calculation above
	FROM cte_os_rank
	) LIMIT 1;
