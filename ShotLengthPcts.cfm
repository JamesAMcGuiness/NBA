
<Cfquery datasource="NBA" Name="GetIt">
SELECT 
	TEAM,
	OFFDEF,
	
	SUM(
	Switch(
		ShotLength > -1 and ShotLength <= 5,1
		)
	) / COUNT(*) AS VeryShortPct,
	
	SUM(
	Switch(
		ShotLength > 5 and ShotLength <= 10,1
		)
	) / COUNT(*) AS ShortPct,
	
	
	SUM(
	Switch(
		ShotLength > 10 and ShotLength <= 15,1
		)
	) / COUNT(*) AS MidPct,
	
	SUM(
	Switch(
		ShotLength > 15 and ShotLength <= 22,1
		)
	) / COUNT(*) AS MidLongPct,
	
	
	SUM(
	Switch(
		ShotLength >= 23,1
		)
	) / COUNT(*) AS LongPct,

	
	
	SUM(
	Switch(
		ShotLength > -1 and ShotLength <= 5,1
		)
	)	AS VeryShort,
	
	SUM(
	Switch(
		ShotLength > 5 and ShotLength <= 10,1
		)
	)	AS xShort,
	
	SUM(
	Switch(
		ShotLength > 10 and ShotLength <= 15,1
		)
	)	AS xMid,
	
	
	SUM(
	Switch(
		ShotLength > 15 and ShotLength <= 22,1
		)
	)	AS MidLong,
	
	SUM(
	Switch(
		ShotLength >= 23,1
		)
	)	AS xLong,
	
	
	COUNT(*) AS TOTALCASES
	
	
	
FROM PBPResults	
where shottype='SHOT'
GROUP BY TEAM, OFFDEF
ORDER BY TEAM, OFFDEF
</cfquery>

<cfdump var="#variables#">

<cfabort>



<!---
<Cfquery datasource="NBA" Name="GetIt">
SELECT 
	TEAM,
	OFFDEF,
	
	SUM(
	Switch(
		ShotLength < 5,1
		)
	)	AS VeryShort,
	
	SUM(
	Switch(
		ShotLength < 10,1
		)
	) 	AS Short,

	SUM(
	Switch(
		ShotLength < 15,1
		)
	) 	AS xMid,

	SUM(
	Switch(
		ShotLength < 22,1
		)
	) 	AS MidLong,

	SUM(
	Switch(
		ShotLength > 22,1
		)
	) 	AS xLong,

	COUNT(*) AS TOTALCASES,
	
	SUM(
	Switch(
		ShotLength <= 5,1
		)
	) / COUNT(*) AS VeryShortPct,
	
	
	SUM(
	Switch(
		ShotLength <= 10,1
		)
	) 	/ COUNT(*) AS ShortPct,

	SUM(
	Switch(
		ShotLength <= 15,1
		)
	) 	/ COUNT(*) AS MidPct,
	
	
	SUM(
	Switch(
		ShotLength <= 22,1
		)
	) 	/ COUNT(*) AS MidLongPct,
	
	SUM(
	Switch(
		ShotLength > 22,1
		)
	) 	/ COUNT(*) AS LongPct
		
FROM PBPResults	
where shottype='SHOT'
GROUP BY TEAM, OFFDEF
ORDER BY TEAM, OFFDEF
</cfquery>
--->

<!---
<Cfquery datasource="NBA" Name="GetIt">
SELECT 
	TEAM,
	SHOTLENGTH,
	SUM(CASE WHEN PLAYTYPE='2PTMADE' THEN 1
			 WHEN PLAYTYPE='3PTMADE' THEN 1
		ELSE 0 
		END) AS PLAYSUCCESS,
	COUNT(SHOTLENGTH) AS TOTALCASES,
	SUM(CASE WHEN PLAYTYPE='2PTMADE' THEN 1
			 WHEN PLAYTYPE='3PTMADE' THEN 1
		ELSE 0 
		) END / COUNT(SHOTLENGTH) AS SUCCESSRATE
FROM PBPResults	
GROUP BY TEAM, OFFDEF, SHOTLENGTH
ORDER BY TEAM, OFFDEF, SHOTLENGTH
</cfquery>
--->


<table width="60%" border="1">
<tr>
<td>Team</td>
<td>OffDef</td>
<td>Very Short</td>
<td>Short</td>
<td>Mid</td>
<td>Mid Long</td>
<td>Long</td>
<td>Very Short%</td>
<td>Short%</td>
<td>Mid%</td>
<td>Mid Long%</td>
<td>Long%</td>
<td>Count</td>
</tr>

<cfoutput query="GetIt">
<tr>
<td>#Team#</td>
<td>#OffDef#</td>
<td>#VeryShort#</td>
<td>#Short#</td>
<td>#xMid#</td>
<td>#MidLong#</td>
<td>#xLong#</td>
<td>#VeryShortPct#</td>
<td>#ShortPct#</td>
<td>#MidPct#</td>
<td>#MidLongPct#</td>
<td>#LongPct#</td>
</tr>
</cfoutput>
</table>