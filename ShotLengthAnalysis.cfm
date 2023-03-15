<Cfquery datasource="NBA" Name="GetIt">
SELECT 
	TEAM,
	OFFDEF,
	SHOTLENGTH,
	SUM(
	Switch(
		PLAYTYPE='2PTMADE',1,
		PLAYTYPE='3PTMADE',1
		)
	) AS PLAYSUCCESS,
	COUNT(SHOTLENGTH) AS TOTALCASES,
	SUM(
	Switch(
		PLAYTYPE='2PTMADE',1,
		PLAYTYPE='3PTMADE',1
		)
	) / COUNT(SHOTLENGTH) AS SUCCESSRATE
	
FROM PBPResults	
where shottype='SHOT'
GROUP BY TEAM, OFFDEF, SHOTLENGTH
ORDER BY TEAM, OFFDEF, SHOTLENGTH
</cfquery>


<Cfquery datasource="NBA" Name="GetIt">
SELECT 
	TEAM,
	OFFDEF,
	SHOTLENGTH,
	SUM(
	Switch(
		PLAYTYPE='2PTMADE',1,
		PLAYTYPE='2PTMISS',1,
		PLAYTYPE='3PTMADE',1,
		PLAYTYPE='3PTMISS',1
		
		)
	) AS PLAYSUCCESS,
	COUNT(SHOTLENGTH) AS TOTALCASES,
	SUM(
	Switch(
		PLAYTYPE='2PTMADE',1,
		PLAYTYPE='2PTMISS',1,
		PLAYTYPE='3PTMADE',1,
		PLAYTYPE='3PTMISS',1
		)
	) / Select COUNT(*) from PBPResults where team=r.team and shotype='SHOT' and OffDef=r.OffDef AS SUCCESSRATE
	
FROM PBPResults	r
where shottype='SHOT'
GROUP BY TEAM, OFFDEF, SHOTLENGTH
ORDER BY TEAM, OFFDEF, SHOTLENGTH
</cfquery>

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
<td>Shot Length</td>
<td>Cases</td>
<td>Success Count</td>
<td>Success Rate</td>
</tr>

<cfoutput query="GetIt">
<tr>
<td>#Team#</td>
<td>#OffDef#</td>
<td>#ShotLength#</td>
<td>#TotalCases#</td>
<td>#PlaySuccess#</td>
<td>#SuccessRate#</td>
</tr>
</cfoutput>
</table>