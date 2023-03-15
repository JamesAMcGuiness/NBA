<cfquery  datasource="nba" name="GetInfo">
	Select p.team,fp.fav,fp.und,fp.FavHealth,fp.UndHealth,p.ps,p.dps,p.ofgpct,p.dfgpct,fp.ha,fp.whocovered
	from Power p, Finalpicks fp 
	where (p.team = fp.fav)
	and p.gametime = fp.gametime
	and fp.favhealth <= -7
	and fp.ha = 'A'
	order by p.ps desc
</cfquery>

<cfoutput query="GetInfo">
#GetInfo.Team#....#GetInfo.Whocovered#...#getInfo.Fav#.#getInfo.ha#...#GetInfo.FavHealth#...#numberformat(GetInfo.ps,'999.9')#...#numberformat(GetInfo.dps,'999.9')#...#numberformat(GetInfo.ofgpct,'999.9')#....#numberformat(GetInfo.dfgpct,'999.9')#<br>
</cfoutput>