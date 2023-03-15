<cfquery datasource="NBA" name="GetIt">
SELECT TEAM, vShortscen + Shortscen as InsideScen
FROM PBPCtsAndPcts
WHERE OffDef='O'
Order by 2 desc
</cfquery>

INSIDE Attempts Rating:<p>
<cfoutput query="GetIt">
#Team#..#InsideScen#<br>
</cfoutput>

<p>

<cfquery datasource="NBA" name="GetIt">
SELECT TEAM, Midscen + MidLongscen as PerScen
FROM PBPCtsAndPcts
WHERE OffDef='O'
Order by 2 desc
</cfquery>

Perimeter Attempts Rating:<p>
<cfoutput query="GetIt">
#Team#..#PerScen#<br>
</cfoutput>


<p>

<cfquery datasource="NBA" name="GetIt">
SELECT TEAM, Longscen  
FROM PBPCtsAndPcts
WHERE OffDef='O'
Order by 2 desc
</cfquery>

Outside 3pt Attempts Rating:<p>
<cfoutput query="GetIt">
#Team#..#LongScen#<br>
</cfoutput>

















<cfquery datasource="NBA" name="GetIt">
SELECT TEAM, vShortscen + Shortscen as InsideScen
FROM PBPCtsAndPcts
WHERE OffDef='D'
Order by 2 
</cfquery>

INSIDE Defense Attempts Rating:<p>
<cfoutput query="GetIt">
#Team#..#InsideScen#<br>
</cfoutput>

<p>

<cfquery datasource="NBA" name="GetIt">
SELECT TEAM, Midscen + MidLongscen as PerScen
FROM PBPCtsAndPcts
WHERE OffDef='D'
Order by 2 
</cfquery>

Perimeter Defense Attempts Rating:<p>
<cfoutput query="GetIt">
#Team#..#PerScen#<br>
</cfoutput>


<p>

<cfquery datasource="NBA" name="GetIt">
SELECT TEAM, Longscen  
FROM PBPCtsAndPcts
WHERE OffDef='D'
Order by 2 
</cfquery>

Outside Defense 3pt Attempts Rating:<p>
<cfoutput query="GetIt">
#Team#..#LongScen#<br>
</cfoutput>









<p><p>
Efficiencies...<p>
<p>
<cfquery datasource="NBA" name="GetIt">
SELECT TEAM, (vshortsucRate) + (ShortsucRate) as InsideScen
FROM PBPCtsAndPcts
WHERE OffDef='O'
Order by 2 desc
</cfquery>

INSIDE Offensive Efficiency Rating:<p>
<cfoutput query="GetIt">
#Team#..#InsideScen#<br>
</cfoutput>

<p>

<p>
<cfquery datasource="NBA" name="GetIt">
SELECT TEAM, (vshortsucRate) + (ShortsucRate) as InsideScen
FROM PBPCtsAndPcts
WHERE OffDef='D'
Order by 2 
</cfquery>

INSIDE Defensive Efficiency Rating:<p>
<cfoutput query="GetIt">
#Team#..#InsideScen#<br>
</cfoutput>

<p>




<p>
<cfquery datasource="NBA" name="GetIt">
SELECT TEAM, (midsucRate) + (midlongsucRate) as InsideScen
FROM PBPCtsAndPcts
WHERE OffDef='O'
Order by 2 desc
</cfquery>

Perimeter Offensive Efficiency Rating:<p>
<cfoutput query="GetIt">
#Team#..#InsideScen#<br>
</cfoutput>

<p>

<p>
<cfquery datasource="NBA" name="GetIt">
SELECT TEAM, (midsucRate) + (midlongsucRate) as InsideScen
FROM PBPCtsAndPcts
WHERE OffDef='D'
Order by 2 
</cfquery>

Perimeter Defensive Efficiency Rating:<p>
<cfoutput query="GetIt">
#Team#..#InsideScen#<br>
</cfoutput>

<p>





<p>
<cfquery datasource="NBA" name="GetIt">
SELECT TEAM, (LongsucRate)  as InsideScen
FROM PBPCtsAndPcts
WHERE OffDef='O'
Order by 2 desc
</cfquery>

Long Offensive Efficiency Rating:<p>
<cfoutput query="GetIt">
#Team#..#InsideScen#<br>
</cfoutput>

<p>

<p>
<cfquery datasource="NBA" name="GetIt">
SELECT TEAM, (LongsucRate)  as InsideScen
FROM PBPCtsAndPcts
WHERE OffDef='D'
Order by 2 
</cfquery>

Long Defensive Efficiency Rating:<p>
<cfoutput query="GetIt">
#Team#..#InsideScen#<br>
</cfoutput>

<p>





<cfabort>


<p>
<cfquery datasource="NBA" name="GetIt">
SELECT TEAM, 
	2*(100*Avg(GS2PTMAKEPCT)) + 3*(100*Avg(GS3PTMAKEPCT)) + 1*(100*Avg(gsFTMAKEPCT)) AS OffEff
	FROM PBPAvgPctsHA
WHERE OffDef='O'
group by Team
Order by 2 desc
</cfquery>

Offensive Eff Rating:<p>
<cfoutput query="GetIt">
#Team#..#OffEff#<br>
</cfoutput>

<p>


<p>
<cfquery datasource="NBA" name="GetIt">
SELECT TEAM, 
	2*(100*Avg(GS2PTMAKEPCT)) + 3*(100*Avg(GS3PTMAKEPCT)) + 1*(100*Avg(gsFTMAKEPCT)) AS OffEff
	FROM PBPAvgPctsHA
WHERE OffDef='D'
group by Team
Order by 2 
</cfquery>

Defensive Eff Rating:<p>
<cfoutput query="GetIt">
#Team#..#OffEff#<br>
</cfoutput>

<p>


<p>
<cfquery datasource="NBA" name="GetIt">
SELECT TEAM, 
	2*(100*Avg(GS2PTMAKEPCT)) + 3*(100*Avg(GS3PTMAKEPCT)) + 1*(100*Avg(gsFTMAKEPCT)) AS OffEff
	FROM PBPAvgPctsHA
WHERE OffDef='D'
group by Team
Order by 2 
</cfquery>

Defensive Eff Rating:<p>
<cfoutput query="GetIt">
#Team#..#OffEff#<br>
</cfoutput>

<p>


<p>
<cfquery datasource="NBA" name="GetIt">
SELECT o.TEAM, 
2*(100*Avg(o.GS2PTMAKEPCT)) + 3*(100*Avg(o.GS3PTMAKEPCT)) + 1*(100*Avg(o.gsFTMAKEPCT)) -
2*(100*Avg(d.GS2PTMAKEPCT)) + 3*(100*Avg(d.GS3PTMAKEPCT)) + 1*(100*Avg(d.gsFTMAKEPCT)) as Overall
	FROM PBPAvgPctsHA o, PBPAvgPctsHA d
WHERE d.OffDef='D'
and o.OffDef='O'
and o.Team = d.Team
group by o.Team
Order by 2 desc
</cfquery>

Overall Eff Rating:<p>
<cfoutput query="GetIt">
#Team#..#Overall#<br>
</cfoutput>

<p>











<p>
<cfquery datasource="NBA" name="GetIt">
SELECT TEAM, 
	(2*(AVG(TotalPossesions)*Avg(GS2PTMAKEPCT)) + 3*(AVG(TotalPossesions)*Avg(GS3PTMAKEPCT)) + 1*(AVG(TotalPossesions)*Avg(gsFTMAKEPCT))) AS OffEff
	FROM PBPAvgPctsHA
WHERE OffDef='O'
group by Team
Order by 2 desc
</cfquery>

Offensive Eff Rating:<p>
<cfoutput query="GetIt">
#Team#..#OffEff#<br>
</cfoutput>

<p>




<p>
<cfquery datasource="NBA" name="GetIt">
SELECT TEAM, 
	(2*(AVG(TotalPossesions)*Avg(GS2PTMAKEPCT)) + 3*(AVG(TotalPossesions)*Avg(GS3PTMAKEPCT)) + 1*(AVG(TotalPossesions)*Avg(gsFTMAKEPCT))) AS OffEff
	FROM PBPAvgPctsHA
WHERE OffDef='D'
group by Team
Order by 2 
</cfquery>

Defensive Eff Rating:<p>
<cfoutput query="GetIt">
#Team#..#OffEff#<br>
</cfoutput>

<p>










