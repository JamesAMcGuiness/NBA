
<!--- See How Favorites Did versus expected results --->
<cfquery datasource="NBA" name="GetIt">
Select 
	s.gametime,
	s.fav,
	s.und,
	d.Team,
	s.spd,
	d.ps - d.dps    AS MOV,
	fp.FavHealthL7  AS HEALTH,
	(d.ps - d.dps) - s.spd AS PERFORMANCE,
	
	iif(d.ps - d.dps > s.spd,1,0) AS DIDOUTPERFORM,
	SWITCH(
	fp.FavHealthL7 <= 0 AND fp.FavHealthL7 >= -3,-1,
	fp.FavHealthL7 <= -4 AND fp.FavHealthL7 >= -6,-2,
	fp.FavHealthL7 <= -7 AND fp.FavHealthL7 >= -9,-3,
	fp.FavHealthL7 <= -10,-4,
	True,0) AS HEALTHLEVEL
	
from FinalPicks fp, NBADATA d, nbaschedule s
WHERE fp.Gametime = s.Gametime
AND d.gametime = s.Gametime
AND d.Team =  s.fav
AND fp.fav = s.fav
and s.Gametime > '20171015'
Order by d.Team, s.gametime
</cfquery>
<cfloop query="GetIt">
<cfquery datasource="NBA" Name="Addit">
INSERT INTO HealthAnalysis(Team,typeteam,MOV,Health,Performance,DidOutPerform,HealthLevel)
VALUES('#Team#','FAV',#mov#,#health#,#performance#,#DidOutperform#,#HealthLevel#)
</cfquery>
</cfloop>















<!--- See How Underdogs Did versus expected results --->
<cfquery datasource="NBA" name="GetIt">
Select 
	s.gametime,
	s.fav,
	s.und,
	d.Team,
	s.spd,
	d.ps - d.dps    AS MOV,
	fp.UndHealthL7  AS HEALTH,
	iif( d.ps < d.dps, s.spd - ABS(d.ps - d.dps),s.spd + ABS(d.ps - d.dps)) AS PERFORMANCE,
	
	iif(ABS(d.ps - d.dps) < s.spd OR d.ps > d.dps,1,0) AS DIDOUTPERFORM,
	
	SWITCH(
	fp.UndHealthL7 <= 0 AND fp.UndHealthL7 >= -3,-1,
	fp.UndHealthL7 <= -4 AND fp.UndHealthL7 >= -6,-2,
	fp.UndHealthL7 <= -7 AND fp.UndHealthL7 >= -9,-3,
	fp.UndHealthL7 <= -10,-4,
	True,0) AS HEALTHLEVEL
	
from FinalPicks fp, NBADATA d, nbaschedule s
WHERE fp.Gametime = s.Gametime
AND d.gametime = s.Gametime
AND d.Team =  s.und
AND fp.und = s.und
and s.Gametime > '20171015'
Order by d.Team, s.gametime
</cfquery>
<cfloop query="GetIt">
<cfquery datasource="NBA" Name="Addit">
INSERT INTO HealthAnalysis(Team,typeteam,MOV,Health,Performance,DidOutPerform,HealthLevel)
VALUES('#Team#','UND',#mov#,#health#,#performance#,#DidOutperform#,#HealthLevel#)
</cfquery>
</cfloop>
<cfdump var="#variables#">