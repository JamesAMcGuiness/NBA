<cfquery datasource="NBA" name="GetIt">
Select 
	
	d.team,
	
	
	
	SUM(
		iif
		(
			(s.HA = 'H' AND d.TEAM = s.FAV AND d.PS - DPS > s.spd),1,0
		)	
	) AS FAVHomeBetterCt,
	
	
	SUM(
		iif
		(
			(s.HA = 'A' AND d.TEAM = s.FAV AND d.PS - DPS > s.spd),1,0
		)	
	) AS FAVAwayBetterCt,
	
	
	SUM(
		iif
		(
			(s.HA = 'H' AND d.TEAM = s.UND AND (abs(d.PS - d.DPS) < s.spd or d.ps > d.dps)),1,0
		)	
	) AS UndAwayBetterCt,
	
	
	SUM(
		iif
		(
			(s.HA = 'A' AND d.TEAM = s.UND AND (abs(d.PS - d.DPS) < s.spd or d.ps > d.dps)),1,0
		)	
	) AS UndHomeBetterCt,

	
	
	SUM(
		iif
		(
			(s.HA = 'H' AND d.TEAM = s.FAV),1,0
		)	
	) AS FAVHome,
	
	
	SUM(
		iif
		(
			(s.HA = 'A' AND d.TEAM = s.FAV),1,0
		)	
	) AS FAVAway,
	
	
	SUM(
		iif
		(
			(s.HA = 'H' AND d.TEAM = s.UND),1,0
		)	
	) AS UndAway,
	
	
	
	SUM(
		iif
		(
			(s.HA = 'A' AND d.TEAM = s.UND),1,0
		)	
	) AS UndHome
	
from NBAData d, NBASchedule s
WHERE (d.TEAM = s.FAV or d.team = s.UND)
AND s.GameTime > '20171015'
AND s.GameTime = d.Gametime
group by d.team
</cfquery>



<cfloop query="GetIt">
<cfquery datasource="NBA" name="Addit">

INSERT INTO HAAnalysis(Team,FAVHomeBetterCt,FAVAwayBetterCt,UNDHomeBetterCt,UNDAwayBetterCt,FAVAway,FAVHome,UndAway,UndHome)
VALUES ('#Team#',#FAVHomeBetterCt#,#FAVAwayBetterCt#,#UNDHomeBetterCt#,#UNDAwayBetterCt#,#FAVAway#,#FAVHome#,#UndAway#,#UndHome#)
</cfquery>

</cfloop>



<cfquery datasource="NBA" name="CalcIt1">
SELECT
	TEAM,
	FAVHomeBetterCt,
	FAVAwayBetterCt,
	UNDHomeBetterCt,
	UNDAwayBetterCt,
	FAVAway,
	FAVHome,
	UNDAway,
	UNDHome,
	iif(FavHome > 0,FAVHomeBetterCt / FavHome,0) AS FavBetterHPct,
	iif(FavAway > 0,FAVAwayBetterCt / FavAway,0) AS FavBetterAPct,
	UNDHomeBetterCt / UndHome AS UndBetterHPct,
	UndAwayBetterCt / UndAway AS UndBetterAPct,
	(FAVHomeBetterCt / FavHome) - (FAVAwayBetterCt / FavAway) AS FavHADiff,
	(UNDHomeBetterCt / UndHome) - (UNDAwayBetterCt / UndAway) AS UndHADiff,
	((FAVHomeBetterCt / FavHome) + (UNDHomeBetterCt / UndHome))   - ((UNDAwayBetterCt / UndAway) + (FAVAwayBetterCt / FavAway)) AS OverallDif
FROM HAAnalysis
</cfquery>


<cfdump var="#variables#">


<table width="50%" border="1">
<tr>
<td>TEAM</td>
<td>Overall Dif H/A</td>
<td>As Fav Better Home Pct</td>
<td>As Fav Better Away Pct</td>
<td>As Fav H/A Dif</td>
<td>As Und Better Home Pct</td>
<td>As Und Better Away Pct</td>
<td>As Und H/A Dif</td>
</tr>
<cfoutput query="CalcIt1">
<tr>
<td>#team#</td>
<td>#OverallDif#</td>
<td>#FavBetterHPct#</td>
<td>#FavBetterAPct#</td>
<td>#FavHADiff#</td>
<td>#UndBetterHPct#</td>
<td>#UndBetterAPct#</td>
<td>#UndHADiff#</td>
</tr>
</cfoutput>
</table>


<cfif 1 is 1>
<cfloop query="CalcIt1">
	<cfset theval  = 2.33 + (2.33 * CalcIt1.OverallDif)>
	<cfset theval2 = 2.33 + (2.33 - (-2.33 * CalcIt1.OverallDif))>
	
	<cfquery datasource="NBA" Name="AddHFA">
	INSERT INTO HFARating (TEAM,HFA,AFA) VALUES ('#Team#',#theval#,#theval2#)
	</cfquery>
</cfloop>
</cfif>

