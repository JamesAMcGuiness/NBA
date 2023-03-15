<cfquery datasource="NBA" name="Delit">
DELETE FRom PBPAvgPctsHA 
</cfquery>

<cfquery name="GetSpds" datasource="nba" >
SELECT Distinct Team
FROM PBPResults
</cfquery>
 
 
 
<cfloop query="Getspds">
		<cfset team = '#GetSpds.Team#'>

<cfloop index="haind" from="1" To="2">		
	<cfif haind is 1>
		<cfset myha = 'H'>
	<cfelse>
		<cfset myha = 'A'>
	</cfif>			
		
<cfloop index="z" from="1" to="2">

	<cfif z is 1>
		<cfset OffDef = 'O'>
	<cfelse>
		<cfset OffDef = 'D'>
	</cfif>

<cfloop index="x" from="1" to="4">
	
<cfquery datasource="NBA" name="GetShortMissReb">
Select Period,COUNT(*) as Stat from PbPResults
where ShotLength < 10
and PlayType = '2PTMISS'
and Team = '#Team#'
and OffDef='#OffDef#'
and id + 2 IN (Select Id FROM PBPResults Where Team = '#Team#' and OffDef='#OffDef#' AND PlayType='OFFREB')
and Period = #x#
and ha = '#myha#'
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
and ha = '#myha#'
Group By Period
</cfquery>

<cfquery datasource="NBA" name="GetLongMissReb">
Select Period,COUNT(*) as Stat from PbPResults
where PlayType = '3PTMISS'
and Team = '#Team#'
and OffDef='#OffDef#'
and id + 2 IN (Select Id FROM PBPResults Where Team = '#Team#' and OffDef='#OffDef#' AND PlayType='OFFREB')
and Period = #x#
and ha = '#myha#'
Group By Period
</cfquery>

		
<cfquery datasource="NBA" name="GetOffStats">
Select count(*) as Stat,period 
from PBPResults where PlayType in ('2PTMADE','2PTMISS','3PTMADE','3PTMISS','TURNOVER','FTMADE','FTMISS') 
AND Team='#Team#' 
AND OFFDEF='#OffDef#'
and Period = #x#
and ha = '#myha#'
group by team,period
</cfquery>		


<cfquery datasource="NBA" name="GetTotShotAtt">
Select count(*) as Stat,period 
from PBPResults where PlayType in ('2PTMADE','2PTMISS','3PTMADE','3PTMISS') 
AND Team='#Team#' 
AND OFFDEF='#OffDef#'
and Period = #x#
and ha = '#myha#'
group by team,period
</cfquery>		

<cfquery datasource="NBA" name="GetFTAPoss">
Select count(*) as Stat,period 
from PBPResults where ShotType in ('FTA') 
AND Team='#Team#' 
AND OFFDEF='#OffDef#'
and Period = #x#
and ha = '#myha#'
group by team,period
</cfquery>		


<cfquery datasource="NBA" name="GetOffRebPoss">
Select count(*) as Stat,period 
from PBPResults where PlayType in ('OFFREB') 
AND Team='#Team#' 
AND OFFDEF='#OffDef#'
and Period = #x#
and ha = '#myha#'
group by team,period
</cfquery>		

<cfquery datasource="NBA" name="GetTOPoss">
Select count(*) as Stat,period 
from PBPResults where PlayType in ('TURNOVER') 
AND Team='#Team#' 
AND OFFDEF='#OffDef#'
and Period = #x#
and ha = '#myha#'
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
and ha = '#myha#'
group by team,period
</cfquery>		

<cfquery datasource="NBA" name="Get2ptshortmake">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('2PTMADE') 
AND Team='#Team#' 
AND OFFDEF='#OffDef#'
AND ShotLength < 10
and Period = #x#
and ha = '#myha#'
group by team,period
</cfquery>		


<cfquery datasource="NBA" name="Get2ptshortmiss">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('2PTMISS') 
AND Team='#Team#' 
AND OFFDEF='#OffDef#'
AND ShotLength < 10
and Period = #x#
and ha = '#myha#'
group by team,period
</cfquery>		

<cfquery datasource="NBA" name="Get2ptMidmake">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('2PTMADE') 
AND Team='#Team#' 
AND OFFDEF='#OffDef#'
AND (ShotLength >= 10 and ShotLength < 22)
and Period = #x#
and ha = '#myha#'
group by team,period
</cfquery>		

<cfquery datasource="NBA" name="Get2ptMidmiss">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('2PTMISS') 
AND Team='#Team#' 
AND OFFDEF='#OffDef#'
AND (ShotLength >= 10 and ShotLength < 22)
and Period = #x#
and ha = '#myha#'
group by team,period
</cfquery>		
	

<cfquery datasource="NBA" name="Get2ptmiss">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('2PTMISS') 
AND Team='#Team#' 
AND OFFDEF='#OffDef#'
and Period = #x#
and ha = '#myha#'
group by team,period
</cfquery>		
	


<cfquery datasource="NBA" name="Get3ptmake">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('3PTMADE') 
AND Team='#Team#' 
AND OFFDEF='#OffDef#'
and Period = #x#
and ha = '#myha#'
group by team,period
</cfquery>		
	

<cfquery datasource="NBA" name="Get3ptmiss">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('3PTMISS') 
AND Team='#Team#' 
AND OFFDEF='#OffDef#'
and Period = #x#
and ha = '#myha#'
group by team,period
</cfquery>		



<cfquery datasource="NBA" name="GetFTmake">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('FTMADE') 
AND Team='#Team#' 
AND OFFDEF='#OffDef#'
and Period = #x#
and ha = '#myha#'
group by team,period
</cfquery>		
	

<cfquery datasource="NBA" name="GetFTmiss">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('FTMISS') 
AND Team='#Team#' 
AND OFFDEF='#OffDef#'
and Period = #x#
and ha = '#myha#'
group by team,period
</cfquery>		


<cfquery datasource="NBA" name="GetTurnovers">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('TURNOVER') 
AND Team='#Team#' 
AND OFFDEF='#OffDef#'
and Period = #x#
and ha = '#myha#'
group by team,period
</cfquery>		


<Cfquery datasource="NBA" Name="GetCts">
SELECT 
	TEAM,
	OFFDEF,
	HA,
	PERIOD,
	
	SUM(	
		SWITCH (PLAYTYPE='2PTMADE' AND (SHOTLENGTH >-1 AND ShotLength <= 5),1
		)
	  
	) AS VeryShortSucCt,
	
	SUM(	
		SWITCH((SHOTLENGTH >= -1 AND SHOTLENGTH <= 5 AND (PLAYTYPE='2PTMADE' OR PLAYTYPE='2PTMISS')),1
			  )
	) AS VeryShortCt,
		
	
	SUM(	
		SWITCH(PLAYTYPE='2PTMADE' AND (SHOTLENGTH > 5 AND SHOTLENGTH <= 10 AND PLAYTYPE='2PTMADE'),1
			  )
	) AS ShortSucCt,
	
	SUM(	
		SWITCH((SHOTLENGTH > 5 AND SHOTLENGTH <= 10 AND (PLAYTYPE='2PTMADE' OR PLAYTYPE='2PTMISS')),1
			  )
	) AS ShortCt,
		
	
	SUM(	
		SWITCH(PLAYTYPE='2PTMADE' AND (SHOTLENGTH > 10 AND SHOTLENGTH <= 15),1
			  )
	) AS MidSucCt,
	
	
	SUM(	
		SWITCH((SHOTLENGTH > 10 AND SHOTLENGTH <= 15 AND (PLAYTYPE='2PTMADE' OR PLAYTYPE='2PTMISS')),1
			  )
	) AS MidCt,
		
	
	SUM(	
		SWITCH(PLAYTYPE='2PTMADE' AND (SHOTLENGTH > 15 AND SHOTLENGTH <= 22),1
			  )
	) AS MidLongSucCt,
	
	
		
	SUM(	
		SWITCH((SHOTLENGTH > 15 AND SHOTLENGTH <= 22 AND (PLAYTYPE='2PTMADE' OR PLAYTYPE='2PTMISS')),1
			  )
	) AS MidLongCt,
	
	SUM(	
		SWITCH(PLAYTYPE='3PTMADE' or PLAYTYPE='3PTMISS',1
			  )
	) AS LongCt,
	
	SUM(	
		SWITCH(PLAYTYPE='3PTMADE' ,1
			  )
	) AS LongSucCt

		
FROM PBPResults	
WHERE SHOTTYPE='SHOT'
GROUP BY TEAM, OFFDEF, HA, PERIOD
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

<cfif TotPossToSave gt 0>


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


<!--- Get the finer possession pcts --->
<cfquery dbtype="query" name="GetFiner">
Select 
	VeryShortCt,
	ShortCt,
	MidCt,
	MidLongCt,
	LongCt,

	
	
	VeryShortCt / #TotPossToSave#    as VShortPossPCt,
	ShortCt / #TotPossToSave#        as ShortPossPCt,
	MidCt / #TotPossToSave#         as MidPossPCt,
	MidLongCt / #TotPossToSave#     as MidLongPossCt,
	LongCt / #TotPossToSave#         as LongPossPCt,
	
	VeryShortSucCt / #TotPossToSave# as VShortSucPCt,
	ShortSucCt / #TotPossToSave#     as ShortSucPCt,
	MidSucCt / #TotPossToSave#       as MidSucPCt,
	MidLongSucCt / #TotPossToSave#   as MidLongSucPCt,
	LongSucCt / #TotPossToSave#      as LongSucPCt
	
from GetCts
where team = '#team#'
and ha     = '#myha#'
and period = #x#
and OffDef ='#OffDef#'
</cfquery>

<cfquery datasource="NBA" name="Addit">
INSERT INTO PBPAvgPctsHA
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
TotalPossesions,
VeryShortCt,
ShortCt,
MidCt,
MidLongCt,
LongCt,
VShortPossPCt,
ShortPossPCt,
MidPossPCt,
MidLongPossPCt,
LongPossPCt,
VShortSucPCt,
ShortSucPCt,
MidSucPCt,
MidLongSucPCt,
LongSucPCt

)
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
#TotPossToSave#,
#GetFiner.VeryShortCt#,
#GetFiner.ShortCt#,
#GetFiner.MidCt#,
#GetFiner.MidLongCt#,
#GetFiner.LongCt#,
#GetFiner.VShortPossPCt#,
#GetFiner.ShortPossPCt#,
#GetFiner.MidPossPCt#,
#GetFiner.MidLongPossCt#,
#GetFiner.LongPossPCt#,
#GetFiner.VShortSucPCt#,
#GetFiner.ShortSucPCt#,
#GetFiner.MidSucPCt#,
#GetFiner.MidLongSucPCt#,
#GetFiner.LongSucPCt#
)
</cfquery>

</cfoutput>
</cfif>
</cfloop>
</cfloop>
</cfloop>
</cfloop>
	
