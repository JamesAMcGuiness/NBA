

<cfset Gametime = "20171117">

<cfquery datasource="NBA" name="Delit">
DELETE FRom PBPStatsForPred  
</cfquery>

<cfquery name="GetSpds" datasource="nba" >
SELECT *
FROM nbaschedule
where trim(GAMETIME) = '#GAMETIME#'
and fav = 'CLE'
</cfquery>

 
<cfloop query="Getspds">

	<cfset myfav      = "#Getspds.fav#">
	<cfset myund      = "#GetSpds.und#">
	<cfset ha         = "#GetSpds.ha#">
	<cfset spd        = "#GetSpds.spd#">
 	<cfset GameTime   = "#Getspds.GameTime#">

	<cfif ha is 'H'>
		<cfset HomeTeam = myfav>
		<cfset myha = 'H'>
		<cfset oppha = 'A'>
		<cfset AwayTeam = myund>
	<cfelse>
		<cfset HomeTeam = myund>
		<cfset AwayTeam = myfav>
		<cfset myha = 'A'>
		<cfset oppha = 'H'>

	</cfif>	

<cfloop index="z" from="1" to="2">

<cfif z is 1>
	<cfset OffDef = 'O'>
<cfelse>
	<cfset OffDef = 'D'>
</cfif>

<cfloop index="x" from="1" to="4">
	
<cfloop index="y" from="1" to="2">
	
	<cfif y is 1>		
		<cfset team = '#HomeTeam#'>
		<cfset TotPlays1 = 0>
		<cfset myHA = 'H'>
		<cfoutput>
			yyyyyyyyyyyyyyyyy is #y# ha is #myHA#<br>
		</cfoutput>

		
	<cfelse>
		<cfset team = '#AwayTeam#'>
		<cfset myHA = 'A'>
		<cfoutput>
		xxxxxyyyyyyyyyyyyyyyyy is #y# ha is #myHA#<br>
		</cfoutput>

		
	</cfif>

	

	
<cfquery datasource="NBA" name="GetShortMissReb">
Select Period,COUNT(*) as Stat from PbPResults
where ShotLength < 10
and PlayType = '2PTMISS'
and Team = '#Team#'
and OffDef='#OffDef#'
and id + 2 IN (Select Id FROM PBPResults Where Team = '#Team#' and OffDef='#OffDef#' AND PlayType='OFFREB')
and Period = #x#
Group By Period
</cfquery>


<cfquery datasource="NBA" name="GetMidMissReb">
Select Period,COUNT(*) as Stat from PbPResults
where (ShotLength >= 10 AND ShotLength < 22)
and PlayType = '2PTMISS'
and Team = '#Team#'
and OffDef='#OffDef#'
and id + 2 IN (Select Id FROM PBPResults Where Team = '#Team#' and OffDef='#OffDef#' AND PlayType='OFFREB')
and Period = #x#
Group By Period
</cfquery>

<cfquery datasource="NBA" name="GetLongMissReb">
Select Period,COUNT(*) as Stat from PbPResults
where PlayType = '3PTMISS'
and Team = '#Team#'
and OffDef='#OffDef#'
and id + 2 IN (Select Id FROM PBPResults Where Team = '#Team#' and OffDef='#OffDef#' AND PlayType='OFFREB')
and Period = #x#
Group By Period
</cfquery>

		
<cfquery datasource="NBA" name="GetOffStats">
Select count(*) as Stat,period 
from PBPResults where PlayType in ('2PTMADE','2PTMISS','3PTMADE','3PTMISS','TURNOVER','FTMADE','FTMISS') 
AND Team='#Team#' 
AND OFFDEF='#OffDef#'
and Period = #x#
group by team,period
</cfquery>		


<cfquery datasource="NBA" name="GetTotShotAtt">
Select count(*) as Stat,period 
from PBPResults where PlayType in ('2PTMADE','2PTMISS','3PTMADE','3PTMISS') 
AND Team='#Team#' 
AND OFFDEF='#OffDef#'
and Period = #x#
group by team,period
</cfquery>		

<cfquery datasource="NBA" name="GetFTAPoss">
Select count(*) as Stat,period 
from PBPResults where ShotType in ('FTA') 
AND Team='#Team#' 
AND OFFDEF='#OffDef#'
and Period = #x#
group by team,period
</cfquery>		


<cfquery datasource="NBA" name="GetOffRebPoss">
Select count(*) as Stat,period 
from PBPResults where PlayType in ('OFFREB') 
AND Team='#Team#' 
AND OFFDEF='#OffDef#'
and Period = #x#
group by team,period
</cfquery>		

<cfquery datasource="NBA" name="GetTOPoss">
Select count(*) as Stat,period 
from PBPResults where PlayType in ('TURNOVER') 
AND Team='#Team#' 
AND OFFDEF='#OffDef#'
and Period = #x#
group by team,period
</cfquery>		


<cfset sr = 0>
<cfset mr = 0>
<cfset Lr = 0>

<cfif GetShortMissReb.Stat gt ''>
	<cfset sr = GetShortMissReb.Stat>
</cfif>

<cfif GetMidMissReb.Stat gt ''>
	<cfset mr = GetMidMissReb.Stat>
</cfif>

<cfif GetLongMissReb.Stat gt ''>
	<cfset lr = GetLongMissReb.Stat>
</cfif>


<cfset TotPossToSave = GetOffStats.Stat>
	
		
<cfquery datasource="NBA" name="Get2ptmake">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('2PTMADE') 
AND Team='#Team#' 
AND OFFDEF='#OffDef#'
and Period = #x#
group by team,period
</cfquery>		

<cfquery datasource="NBA" name="Get2ptshortmake">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('2PTMADE') 
AND Team='#Team#' 
AND OFFDEF='#OffDef#'
AND ShotLength < 10
and Period = #x#
group by team,period
</cfquery>		


<cfquery datasource="NBA" name="Get2ptshortmiss">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('2PTMISS') 
AND Team='#Team#' 
AND OFFDEF='#OffDef#'
AND ShotLength < 10
and Period = #x#
group by team,period
</cfquery>		

<cfquery datasource="NBA" name="Get2ptMidmake">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('2PTMADE') 
AND Team='#Team#' 
AND OFFDEF='#OffDef#'
AND (ShotLength >= 10 and ShotLength <= 22)
and Period = #x#
group by team,period
</cfquery>		

<cfquery datasource="NBA" name="Get2ptMidmiss">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('2PTMISS') 
AND Team='#Team#' 
AND OFFDEF='#OffDef#'
AND (ShotLength >= 10 and ShotLength <= 22)
and Period = #x#
group by team,period
</cfquery>		
	

<cfquery datasource="NBA" name="Get2ptmiss">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('2PTMISS') 
AND Team='#Team#' 
AND OFFDEF='#OffDef#'
and Period = #x#
group by team,period
</cfquery>		
	


<cfquery datasource="NBA" name="Get3ptmake">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('3PTMADE') 
AND Team='#Team#' 
AND OFFDEF='#OffDef#'
and Period = #x#
group by team,period
</cfquery>		
	

<cfquery datasource="NBA" name="Get3ptmiss">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('3PTMISS') 
AND Team='#Team#' 
AND OFFDEF='#OffDef#'
and Period = #x#
group by team,period
</cfquery>		



<cfquery datasource="NBA" name="GetFTmake">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('FTMADE') 
AND Team='#Team#' 
AND OFFDEF='#OffDef#'
and Period = #x#
group by team,period
</cfquery>		
	

<cfquery datasource="NBA" name="GetFTmiss">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('FTMISS') 
AND Team='#Team#' 
AND OFFDEF='#OffDef#'
and Period = #x#
group by team,period
</cfquery>		


<cfquery datasource="NBA" name="GetTurnovers">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('TURNOVER') 
AND Team='#Team#' 
AND OFFDEF='#OffDef#'
and Period = #x#
group by team,period
</cfquery>		

	
<p>
**********************************************************************************************************************	
<p>
<cfset tm2ptmakePct1 = 0>


<cfif Get2ptmake["Period"][1] gt ''>
	<cfset tm2ptmakePct1 = Get2ptmake["Stat"][1]>
</cfif>


<cfset tm2ptmissPct1 = 0>

<cfif Get2ptmiss["Period"][1] gt ''>
	<cfset tm2ptmissPct1 = Get2ptmiss["Stat"][1]>
</cfif>


<cfset tm3ptmakePct1 = 0>
	

<cfif Get3ptmake["Period"][1] gt ''>
	<cfset tm3ptmakePct1 = Get3ptmake["Stat"][1]>
</cfif>


<cfset tm3ptmissPct1 = 0>
		

<cfif Get3ptmiss["Period"][1] gt ''>
	<cfset tm3ptmissPct1 = Get3ptmiss["Stat"][1]>
</cfif>
		
		
<cfset tmFTmissPct1 = 0>
<cfset tmFTmakePct1 = 0>		

<cfif GetFTmake["Period"][1] gt ''>
	<cfset tmFTmakePct1 = GetFTmake["Stat"][1]>
</cfif>

<cfif GetFTmiss["Period"][1] gt ''>
	<cfset tmFTmissPct1 = GetFTmiss["Stat"][1]>
</cfif>

<cfset tmTurnover1 = 0>

<cfif GetTurnovers["Period"][1] gt ''>
	<cfset tmTurnover1 = GetTurnovers["Stat"][1]>
</cfif>


<cfset Stat1 = 0>
<cfset Stat2 = 0>
<cfset Stat3 = 0>
<cfset Stat4 = 0>

<cfif GetOffStats["Stat"][1] gt ''>
	<cfset Stat1 = GetOffStats["Stat"][1]>
</cfif>

<cfif GetShortMissReb["Stat"][1] gt ''>
	<cfset Stat2 = GetShortMissReb["Stat"][1]>
</cfif>	

<cfif GetMidMissReb["Stat"][1] gt ''>
	<cfset Stat3 = GetMidMissReb["Stat"][1]>
</cfif>

<cfif GetLongMissReb["Stat"][1] gt ''>
	<cfset Stat4 = GetLongMissReb["Stat"][1]>
</cfif>	

<cfoutput>
#team#: Qtr #x#:<p>

2ptmakePct = #tm2ptmakepct1/TotPossToSave#<br>
2ptmissPct = #tm2ptmisspct1/TotPossToSave#<br>

<cfset gs2ptmake    = tm2ptmakepct1>
<cfset gs2ptmakepct = tm2ptmakepct1/TotPossToSave>

<cfset gs2ptmiss    = tm2ptmissPct1>
<cfset gs2ptmisspct = tm2ptmisspct1/TotPossToSave>

<cfif tm3ptmakepct1/TotPossToSave gt ''>
	3ptmakePct = #tm3ptmakepct1/TotPossToSave#<br>
	<cfset gs3ptmake    = tm3ptmakepct1>
	<cfset gs3ptmakepct = tm3ptmakepct1/TotPossToSave>
	
<cfelse>
	3ptmakePct = 0<br>
	<cfset gs3ptmake    = 0>
	<cfset gs3ptmakepct = 0>
</cfif>

<cfif tm3ptmisspct1/TotPossToSave gt ''>
	3ptmissPct = #tm3ptmisspct1/TotPossToSave#<br>
	<cfset gs3ptmiss    = tm3ptmisspct1>
	<cfset gs3ptmisspct = tm3ptmisspct1/TotPossToSave>
	
<cfelse>
	3ptmissPct = 0<br>
	<cfset gs3ptmiss    = 0>
	<cfset gs3ptmisspct = 0>
	
</cfif>


<cfif tmFTmakepct1/TotPossToSave gt ''>
	FTmakePct = #tmFTmakepct1/TotPossToSave#<br>
	<cfset gsFTMake    = tmFTmakepct1>
	<cfset gsFTMakePct = tmFTmakepct1/TotPossToSave>
<cfelse>
	FTmakePct = 0<br>
	<cfset gsFTMake    = 0>
	<cfset gsFTMakePct = 0>
</cfif>

<cfif tmFTmisspct1/TotPossToSave gt ''>
	FTmissPct = #tmFTmisspct1/TotPossToSave#<br>
	<cfset gsFTMiss    = tmFTmisspct1>
	<cfset gsFTMissPct = tmFTmisspct1/TotPossToSave>
<cfelse>
	FTmissPct = 0<br>
	<cfset gsFTMiss    = 0>
	<cfset gsFTMissPct = 0>
</cfif>

<cfif tmTurnover1/TotPossToSave gt ''>
	TURNOVER Pct = #tmTurnover1/TotPossToSave#<br>
	<cfset gsTurnover = tmTurnover1>
	<cfset gsTurnoverPct = tmTurnover1/TotPossToSave>
<cfelse>
	TURNOVER Pct = 0<br>
	<cfset gsTurnover    = 0>
	<cfset gsTurnoverPct = 0>
</cfif>
	
<cfif Get2ptshortmiss["Stat"][1] gt ''>
	2ptmissshort Pct = #Get2ptshortmiss["Stat"][1]/TotPossToSave#<br>
	<cfset gs2ptshortmiss    = Get2ptshortmiss["Stat"][1]>
	<cfset gs2ptshortmisspct = Get2ptshortmiss["Stat"][1]/TotPossToSave>
	
<cfelse>
	<cfset gs2ptshortmiss    = 0>
	<cfset gs2ptshortmisspct = 0>
</cfif>


<cfif Get2ptshortmake["Stat"][1] gt ''> 
	2ptmakeshort Pct = #Get2ptshortmake["Stat"][1]/TotPossToSave#<br> 
	<cfset gs2ptshortmake    = Get2ptshortmake["Stat"][1]>
	<cfset gs2ptshortmakepct = Get2ptshortmake["Stat"][1]/TotPossToSave>
	<cfelse>
	2ptmakeshort Pct = 0<br>
	<cfset gs2ptshortmake    = 0>
	<cfset gs2ptshortmakepct = 0>
</cfif>

<cfif Get2ptmidmiss["Stat"][1] gt ''>
	2ptmissMid Pct = #Get2ptmidmiss["Stat"][1]/TotPossToSave#<br> 
	<cfset gs2ptMidMiss    = Get2ptmidmiss["Stat"][1]>
	<cfset gs2ptMidMissPct = Get2ptmidmiss["Stat"][1]/TotPossToSave>
	
<cfelse>
	2ptmissMid Pct = 0<br>
	<cfset gs2ptMidMiss    = 0>
	<cfset gs2ptMidMissPct = 0>
</cfif>

<cfif Get2ptmidmake["Stat"][1] gt ''>
	2ptmakeMid Pct = #Get2ptmidmake["Stat"][1]/TotPossToSave#<br> 
	<cfset gs2ptMidMake    = Get2ptmidmake["Stat"][1]>
	<cfset gs2ptMidMakePct = Get2ptmidmake["Stat"][1]/TotPossToSave>
<cfelse>
	2ptmakeMid Pct = 0<br>
	<cfset gs2ptMidMake    = 0>
	<cfset gs2ptMidMakePct = 0>
</cfif>
	
	
<cfset Stat1 = 0>
<cfset Stat2 = 0>
<cfset Stat3 = 0>

<cfif GetShortMissReb["Stat"][1] gt ''>
	<cfset Stat1 = GetShortMissReb["Stat"][1]>
</cfif>

<cfif GetMidMissReb["Stat"][1] gt ''>
	<cfset Stat2 = GetMidMissReb["Stat"][1]>
</cfif>

<cfif GetLongMissReb["Stat"][1] gt ''>
	<cfset Stat3 = GetLongMissReb["Stat"][1]>
</cfif>

OffReb         = #Stat1 + stat2 + stat3#<br>
<cfset gsOffReb = Stat1 + stat2 + stat3>

<cfif GetShortMissReb["Stat"][1] gt ''>
	ShortRebPct    = #GetShortMissReb["Stat"][1] / TotPossToSave#<br>
	<cfset gsShortReb    = GetShortMissReb["Stat"][1]>
	<cfset gsShortRebPct = GetShortMissReb["Stat"][1]/Gs2ptshortmiss>
<cfelse>
	ShortRebPct = 0<br>
	<cfset gsShortReb    = 0>
	<cfset gsShortRebPct = 0>
</cfif>

<cfif GetMidMissReb["Stat"][1] gt ''>
	MidRebPct      = #GetMidMissReb["Stat"][1] / TotPossToSave#<br>
	<cfset gsMidReb    = GetMidMissReb["Stat"][1]>
	<cfset gsMidRebPct = GetMidMissReb["Stat"][1]/Gs2ptmidmiss>
<cfelse>
	MidRebPct      = 0<br>
	<cfset gsMidReb    = 0>
	<cfset gsMidRebPct = 0>
</cfif>


<cfif GetLongMissReb["Stat"][1] gt ''>
	LongRebPct     = #GetLongMissReb["Stat"][1] / TotPossToSave#<br>
	<cfset gsLongReb    = GetLongMissReb["Stat"][1]>
	<cfset gsLongRebPct = GetLongMissReb["Stat"][1]/Gs3ptmiss>
<cfelse>
	LongRebPct     = 0<br>
	<cfset gsLongReb    = 0>
	<cfset gsLongRebPct = 0>
</cfif>

<cfset TotPlays1 = TotPlays1 + TotPossToSave>
Totplays so far is #TotPossToSave#<br>

<cfif y is 2>
	<cfset TotPlays1 = ROUND(TotPlays1 / 2)>
	********Total Plays For Qtr #x# for Simulation is #TotPossToSave#<p>
</cfif>

<p>********************************************************************************
TEAM: #Team# for QTR #x#<br>
gs2ptmake    = #gs2ptmake# <br>
gs2ptmakepct = #gs2ptmakepct# <br>
gs2ptmiss    = #gs2ptmiss#<br>
gs2ptmisspct = #gs2ptmisspct#<br>
gs3ptmake    = #gs3ptmake#<br>
gs3ptmakepct = #gs3ptmakepct#<br>
gs3ptmiss    = #gs3ptmiss#<br>
gs3ptmisspct = #gs3ptmisspct#<br>
gsFTMake    = #gsFTMake#<br>
gsFTMakePct = #gsFTMakePct#<br>
gsFTMiss    = #gsFTMiss#<br>
gsFTMissPct = #gsFTMissPct#<br>
gsTurnover    = #gsTurnover#<br>
gsTurnoverPct = #gsTurnoverPct#<br>
gs2ptshortmiss    = #gs2ptshortmiss#<br>
gs2ptshortmisspct = #gs2ptshortmisspct#<br>
gs2ptshortmake    = #gs2ptshortmake#<br>
gs2ptshortmakepct = #gs2ptshortmakepct#<br>
gs2ptMidMiss    = #gs2ptMidMiss#<br>
gs2ptMidMissPct = #gs2ptMidMissPct#<br>
gs2ptMidMake    = #gs2ptMidMake#<br>
gs2ptMidMakePct = #gs2ptMidMakePct#<br>
gsShortReb      = #gsShortReb#<br>
gsShortRebPct   = #gsShortRebPct#<br>
gsMidReb        = #gsMidReb#<br>
gsMidRebPct     = #gsMidRebPct#<br>
gsLongReb       = #gsLongReb#<br>
gsLongRebPct    = #gsLongRebPct#<br>
TotPlays        = #TotPlays1#<br>
y is #y#<br>

<p>********************************************************************************

<cfquery datasource="NBA" name="Addit">
INSERT INTO PBPStatsForPred
(
Team,
Period,
HA,
OffDef,
gs2ptmake,
gs2ptmakepct,
gs2ptmiss,    
gs2ptmisspct,  
gs3ptmake,     
gs3ptmakepct,  
gs3ptmiss,     
gs3ptmisspct,  
gsFTMake,     
gsFTMakePct,  
gsFTMiss,     
gsFTMissPct,
gsTurnover,     
gsTurnoverPct,  
gs2ptshortmiss,     
gs2ptshortmisspct,  
gs2ptshortmake,     
gs2ptshortmakepct,  
gs2ptMidMiss,     
gs2ptMidMissPct,  
gs2ptMidMake,     
gs2ptMidMakePct,  
gsShortReb,       
gsShortRebPct,    
gsMidReb,         
gsMidRebPct,      
gsLongReb,        
gsLongRebPct,     
TotalPossesions)
VALUES         
(
'#team#',
#x#,
'#myha#',
'#OffDef#',
#gs2ptmake#,
#gs2ptmakepct#,
#gs2ptmiss#,
#gs2ptmisspct#,
#gs3ptmake#,
#gs3ptmakepct#,
#gs3ptmiss#,
#gs3ptmisspct#,
#gsFTMake#,
#gsFTMakePct#,
#gsFTMiss#,
#gsFTMissPct#,
#gsTurnover#,
#gsTurnoverPct#,
#gs2ptshortmiss#,
#gs2ptshortmisspct#,
#gs2ptshortmake#,
#gs2ptshortmakepct#,
#gs2ptMidMiss#,
#gs2ptMidMissPct#,
#gs2ptMidMake#,
#gs2ptMidMakePct#,
#gsShortReb#,
#gsShortRebPct#,
#gsMidReb#,
#gsMidRebPct#,
#gsLongReb#,
#gsLongRebPct#,
#TotPossToSave#
)
</cfquery>

</cfoutput>
</cfloop>
</cfloop>
</cfloop>

</cfloop>
	
