
<cfif 1 is 2>
<cfquery datasource="NBA" name="GetOffStats">
Select TEAM,
	   AVG(Qtr1Poss)*Avg(QTR1FGAPct)    As FGA1,
	   AVG(Qtr1Poss)*Avg(QTR1DefRebPct) As DREB1,
	   AVG(Qtr1Poss)*Avg(QTR1ORebPct) As OREB1,
	   AVG(Qtr1Poss)*Avg(QTR1FTAPct)    As FTA1,
   	   AVG(Qtr1Poss)*Avg(QTR1TOPct)     As TRNOV1,
	   
	   AVG(Qtr2Poss)*Avg(QTR2FGAPct)    As FGA2,
	   AVG(Qtr2Poss)*Avg(QTR2DefRebPct) As DREB2,
	   AVG(Qtr2Poss)*Avg(QTR2ORebPct) As OREB2,
	   AVG(Qtr2Poss)*Avg(QTR2FTAPct)    As FTA2,
   	   AVG(Qtr2Poss)*Avg(QTR2TOPct)     As TRNOV2,
	   
	   AVG(Qtr3Poss)*Avg(QTR3FGAPct)    As FGA3,
	   AVG(Qtr3Poss)*Avg(QTR3DefRebPct) As DREB3,
	   AVG(Qtr3Poss)*Avg(QTR3ORebPct) As OREB3,
	   AVG(Qtr3Poss)*Avg(QTR3FTAPct)    As FTA3,
   	   AVG(Qtr3Poss)*Avg(QTR3TOPct)     As TRNOV3,

	   AVG(Qtr4Poss)*Avg(QTR4FGAPct)    As FGA4,
	   AVG(Qtr4Poss)*Avg(QTR4DefRebPct) As DREB4,
	   AVG(Qtr4Poss)*Avg(QTR4ORebPct) As OREB4,
	   AVG(Qtr4Poss)*Avg(QTR4FTAPct)    As FTA4,
   	   AVG(Qtr4Poss)*Avg(QTR4TOPct)     As TRNOV4,
	   
	  	   ((AVG(Qtr1ShortShotPct) * AVG(Qtr1Poss))  *  (Avg(Qtr12PTShortMakePct))) As ShortTwoPtMade1,
	   ((AVG(Qtr1MidRgeShotPct) * AVG(Qtr1Poss))  *  (Avg(Qtr12PTMidMakePct)))  As MidTwoPtMade1,
		AVG(Qtr1Poss)  *  Avg(Qtr13PTMakePct)       As LongMade1,   
		   
		   
	   ((AVG(Qtr2ShortShotPct) * AVG(Qtr2Poss))  *  (Avg(Qtr22PTShortMakePct))) As ShortTwoPtMade2,
	   ((AVG(Qtr2MidRgeShotPct) * AVG(Qtr2Poss))  *  (Avg(Qtr22PTMidMakePct)))  As MidTwoPtMade2,
		AVG(Qtr2Poss)  *  Avg(Qtr23PTMakePct)       As LongMade2,   
		
		
	   
	   ((AVG(Qtr3ShortShotPct) * AVG(Qtr3Poss))  *  (Avg(Qtr32PTShortMakePct))) As ShortTwoPtMade3,
	   ((AVG(Qtr3MidRgeShotPct) * AVG(Qtr3Poss))  *  (Avg(Qtr32PTMidMakePct)))  As MidTwoPtMade3,
		AVG(Qtr3Poss)  *  Avg(Qtr33PTMakePct)       As LongMade3,   
		

	   
   	   ((AVG(Qtr4ShortShotPct) * AVG(Qtr4Poss))  *  (Avg(Qtr42PTShortMakePct))) As ShortTwoPtMade4,
	   ((AVG(Qtr4MidRgeShotPct) * AVG(Qtr4Poss))  *  (Avg(Qtr42PTMidMakePct)))  As MidTwoPtMade4,
		AVG(Qtr4Poss)  *  Avg(Qtr43PTMakePct)       As LongMade4   
		   
FROM PBPGameSimPcts
WHERE OFFDEF='O'	   
GROUP BY TEAM	
</cfquery>
		

<cfquery datasource="NBA" name="GetDefStats">
Select TEAM,
	   AVG(Qtr1Poss)*Avg(QTR1FGAPct)    As FGA1,
	   AVG(Qtr1Poss)*Avg(QTR1DefRebPct) As DREB1,
	   AVG(Qtr1Poss)*Avg(QTR1ORebPct) As OREB1,
	   AVG(Qtr1Poss)*Avg(QTR1FTAPct)    As FTA1,
   	   AVG(Qtr1Poss)*Avg(QTR1TOPct)     As TRNOV1,
	   
	   AVG(Qtr2Poss)*Avg(QTR2FGAPct)    As FGA2,
	   AVG(Qtr2Poss)*Avg(QTR2DefRebPct) As DREB2,
	   AVG(Qtr2Poss)*Avg(QTR2ORebPct) As OREB2,
	   AVG(Qtr2Poss)*Avg(QTR2FTAPct)    As FTA2,
   	   AVG(Qtr2Poss)*Avg(QTR2TOPct)     As TRNOV2,
	   
	   AVG(Qtr3Poss)*Avg(QTR3FGAPct)    As FGA3,
	   AVG(Qtr3Poss)*Avg(QTR3DefRebPct) As DREB3,
	   AVG(Qtr3Poss)*Avg(QTR3ORebPct) As OREB3,
	   AVG(Qtr3Poss)*Avg(QTR3FTAPct)    As FTA3,
   	   AVG(Qtr3Poss)*Avg(QTR3TOPct)     As TRNOV3,

	   AVG(Qtr4Poss)*Avg(QTR4FGAPct)    As FGA4,
	   AVG(Qtr4Poss)*Avg(QTR4DefRebPct) As DREB4,
	   AVG(Qtr4Poss)*Avg(QTR4ORebPct) As OREB4,
	   AVG(Qtr4Poss)*Avg(QTR4FTAPct)    As FTA4,
   	   AVG(Qtr4Poss)*Avg(QTR4TOPct)     As TRNOV4,
	   
	   ((AVG(Qtr1ShortShotPct) * AVG(Qtr1Poss))  *  (Avg(Qtr12PTShortMakePct))) As ShortTwoPtMade1,
	   ((AVG(Qtr1MidRgeShotPct) * AVG(Qtr1Poss))  *  (Avg(Qtr12PTMidMakePct)))  As MidTwoPtMade1,
		AVG(Qtr1Poss)  *  Avg(Qtr13PTMakePct)       As LongMade1,   
		   
		   
	   ((AVG(Qtr2ShortShotPct) * AVG(Qtr2Poss))  *  (Avg(Qtr22PTShortMakePct))) As ShortTwoPtMade2,
	   ((AVG(Qtr2MidRgeShotPct) * AVG(Qtr2Poss))  *  (Avg(Qtr22PTMidMakePct)))  As MidTwoPtMade2,
		AVG(Qtr2Poss)  *  Avg(Qtr23PTMakePct)       As LongMade2,   
		
		
	   
	   ((AVG(Qtr3ShortShotPct) * AVG(Qtr3Poss))  *  (Avg(Qtr32PTShortMakePct))) As ShortTwoPtMade3,
	   ((AVG(Qtr3MidRgeShotPct) * AVG(Qtr3Poss))  *  (Avg(Qtr32PTMidMakePct)))  As MidTwoPtMade3,
		AVG(Qtr3Poss)  *  Avg(Qtr33PTMakePct)       As LongMade3,   
		

	   
   	   ((AVG(Qtr4ShortShotPct) * AVG(Qtr4Poss))  *  (Avg(Qtr42PTShortMakePct))) As ShortTwoPtMade4,
	   ((AVG(Qtr4MidRgeShotPct) * AVG(Qtr4Poss))  *  (Avg(Qtr42PTMidMakePct)))  As MidTwoPtMade4,
		AVG(Qtr4Poss)  *  Avg(Qtr43PTMakePct)       As LongMade4 

	   
FROM PBPGameSimPcts
WHERE OFFDEF='D'	   
GROUP BY TEAM	
</cfquery>
		
<cfdump var="#GetOffStats#">
<cfdump var="#GetDefStats#">

		
-- Create Calculation for 1st Quarter Possessions<p>

<cfset tmFGA        = GetOffStats["FGA1"][1]> 
<cfset tmTurnovers  = GetOffStats["TRNOV1"][1]>
<cfset tmFTA        = GetOffStats["FTA1"][1]>
<cfset tmOffReb     = GetOffStats["OREB1"][1]>
<cfset oppDefReb    = GetOffStats["DREB1"][2]>
<cfset tmFGM        = GetOffStats["SHORTTWOPTMADE1"][1] + GetOffStats["MIDTWOPTMADE1"][1] + GetOffStats["LONGMADE1"][1]>
<cfset oppFGA       = GetOffStats["FGA1"][2]>
<cfset oppFTA       = GetOffStats["FTA1"][2]>
<cfset oppOffReb    = GetOffStats["OREB1"][2]>
<cfset tmDefReb     = GetOffStats["DREB1"][1]>
<cfset oppFGM       = GetOffStats["SHORTTWOPTMADE1"][2] + GetOffStats["MIDTWOPTMADE1"][2] + GetOffStats["LONGMADE1"][2]>
<cfset oppTurnovers = GetOffStats["TRNOV1"][2]>

<cfoutput>
tmFGA        = #tmFGA#<br>  
tmTurnovers  = #tmTurnovers#<br>
tmFTA        = #tmFTA#<br>
tmOffReb     = #tmOffReb#<br>
oppDefReb    = #oppDefReb#<br>
tmFGM        = #tmFGM#<br>
oppFGA       = #oppFGA#<br>
oppFTA       = #oppFTA#<br>
oppOffReb    = #oppOffReb#<br>
tmDefReb     = #tmDefReb#<br>
oppFGM       = #oppFGM#<br>
oppTurnovers = #oppTurnovers#<br>
</cfoutput>

<!---
<cfset TotPosQtr1 = .5*((tmfga + 0.4 * tmFTA - 1.07 * (tmOffReb/(tmOffReb + oppDefReb)) * (tmFGA - tmFGM) + tmTurnovers) + (oppFGA + 0.4 * (oppFTA) - 1.07*(oppOffReb)/(oppOffReb+tmDefReb)) * (oppFGA - oppFGM) + oppTurnovers)))  >   
--->

<cfset TotPosQtr1 = tmfga + (0.475 * tmFTA) - tmOffReb + tmTurnovers>
<cfset TotPosQtr2 = oppfga + (0.475 * oppFTA) - oppOffReb + oppTurnovers>
<cfset Final = (TotPosQtr1 + TotPosQtr2)/2>


<p>
<cfoutput>
Total 1stQ Possesions is #Final#
</cfoutput>
 
		












<cfset tmFGA        = GetOffStats["FGA2"][1]> 
<cfset tmTurnovers  = GetOffStats["TRNOV2"][1]>
<cfset tmFTA        = GetOffStats["FTA2"][1]>
<cfset tmOffReb     = GetOffStats["OREB2"][1]>
<cfset oppDefReb    = GetOffStats["DREB2"][2]>
<cfset tmFGM        = GetOffStats["SHORTTWOPTMADE2"][1] + GetOffStats["MIDTWOPTMADE2"][1] + GetOffStats["LONGMADE2"][1]>
<cfset oppFGA       = GetOffStats["FGA2"][2]>
<cfset oppFTA       = GetOffStats["FTA2"][2]>
<cfset oppOffReb    = GetOffStats["OREB2"][2]>
<cfset tmDefReb     = GetOffStats["DREB2"][1]>
<cfset oppFGM       = GetOffStats["SHORTTWOPTMADE2"][2] + GetOffStats["MIDTWOPTMADE2"][2] + GetOffStats["LONGMADE2"][2]>
<cfset oppTurnovers = GetOffStats["TRNOV2"][2]>

<cfoutput>
tmFGA        = #tmFGA#<br>  
tmTurnovers  = #tmTurnovers#<br>
tmFTA        = #tmFTA#<br>
tmOffReb     = #tmOffReb#<br>
oppDefReb    = #oppDefReb#<br>
tmFGM        = #tmFGM#<br>
oppFGA       = #oppFGA#<br>
oppFTA       = #oppFTA#<br>
oppOffReb    = #oppOffReb#<br>
tmDefReb     = #tmDefReb#<br>
oppFGM       = #oppFGM#<br>
oppTurnovers = #oppTurnovers#<br>
</cfoutput>

<cfset TotPosQtr2 = .5*((tmfga + 0.4 * tmFTA - 1.07 * (tmOffReb/(tmOffReb + oppDefReb)) * (tmFGA - tmFGM) + tmTurnovers)     + (oppFGA + 0.4 * (oppFTA) - 1.07*(oppOffReb/(oppOffReb+tmDefReb))    * (oppFGA - oppFGM) + oppTurnovers))  >   
<p>
<cfoutput>
Total 2nd Possesions is #TotPosQtr2#
</cfoutput>
 </cfif>
	













	
	
	
	
	







<cfloop index="x" from="1" to="1">

	
		
<cfset team = 'DEN'>
<cfset opp  = 'MIL'>
		


<cfquery datasource="NBA" name="GetShortMissReb">
Select Period,COUNT(*) as Stat from PbPResults
where ShotLength < 10
and PlayType = '2PTMISS'
and Team = '#Team#'
and OffDef='O'
and id + 2 IN (Select Id FROM PBPResults Where Team = '#Team#' and OffDef='O' AND PlayType='OFFREB')
and Period = #x#
Group By Period
</cfquery>


<cfquery datasource="NBA" name="GetMidMissReb">
Select Period,COUNT(*) as Stat from PbPResults
where (ShotLength >= 10 AND ShotLength < 22)
and PlayType = '2PTMISS'
and Team = '#Team#'
and OffDef='O'
and id + 2 IN (Select Id FROM PBPResults Where Team = '#Team#' and OffDef='O' AND PlayType='OFFREB')
and Period = #x#
Group By Period
</cfquery>

<cfquery datasource="NBA" name="GetLongMissReb">
Select Period,COUNT(*) as Stat from PbPResults
where PlayType = '3PTMISS'
and Team = '#Team#'
and OffDef='O'
and id + 2 IN (Select Id FROM PBPResults Where Team = '#Team#' and OffDef='O' AND PlayType='OFFREB')
and Period = #x#
Group By Period
</cfquery>



<cfquery datasource="NBA" name="oppGetShortMissReb">
Select Period,COUNT(*) as Stat from PbPResults
where ShotLength < 10
and PlayType = '2PTMISS'
and Team = '#opp#'
and OffDef='O'
and id + 2 IN (Select Id FROM PBPResults Where Team = '#opp#' and OffDef='O' AND PlayType='OFFREB')
and Period = #x#
Group By Period
</cfquery>


<cfquery datasource="NBA" name="oppGetMidMissReb">
Select Period,COUNT(*) as Stat from PbPResults
where (ShotLength >= 10 AND ShotLength < 22)
and PlayType = '2PTMISS'
and Team = '#opp#'
and OffDef='O'
and id + 2 IN (Select Id FROM PBPResults Where Team = '#opp#' and OffDef='O' AND PlayType='OFFREB')
and Period = #x#
Group By Period
</cfquery>

<cfquery datasource="NBA" name="oppGetLongMissReb">
Select Period,COUNT(*) as Stat from PbPResults
where PlayType = '3PTMISS'
and Team = '#opp#'
and OffDef='O'
and id + 2 IN (Select Id FROM PBPResults Where Team = '#opp#' and OffDef='O' AND PlayType='OFFREB')
and Period = #x#
Group By Period
</cfquery>







<cfquery datasource="NBA" name="oppGetOffReb">
Select count(*) as Stat,period 
from PBPResults where PlayType in ('OFFREB') 
AND Team='#opp#' 
AND OFFDEF='O'
and Period = #x#
group by team,period
</cfquery>		



		
<cfquery datasource="NBA" name="GetOffStats">
Select count(*) as Stat,period 
from PBPResults where PlayType in ('2PTMADE','2PTMISS','3PTMADE','3PTMISS','FTMADE','FTMISS','TURNOVER') 
AND Team='#Team#' 
AND OFFDEF='O'
and Period = #x#
group by team,period
</cfquery>		
		
<cfquery datasource="NBA" name="oppGetOffStats">
Select count(*) as Stat,period 
from PBPResults where PlayType in ('2PTMADE','2PTMISS','3PTMADE','3PTMISS','FTMADE','FTMISS','TURNOVER') 
AND Team='#opp#' 
AND OFFDEF='O'
and Period = #x#
group by team,period
</cfquery>		
		
<cfquery datasource="NBA" name="Get2ptmake">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('2PTMADE') 
AND Team='#Team#' 
AND OFFDEF='O'
and Period = #x#
group by team,period
</cfquery>		

<cfquery datasource="NBA" name="Get2ptshortmake">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('2PTMADE') 
AND Team='#Team#' 
AND OFFDEF='O'
AND ShotLength < 10
and Period = #x#
group by team,period
</cfquery>		


<cfquery datasource="NBA" name="Get2ptshortmiss">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('2PTMISS') 
AND Team='#Team#' 
AND OFFDEF='O'
AND ShotLength < 10
and Period = #x#
group by team,period
</cfquery>		

<cfquery datasource="NBA" name="Get2ptMidmake">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('2PTMADE') 
AND Team='#Team#' 
AND OFFDEF='O'
AND (ShotLength >= 10 and ShotLength < 22)
and Period = #x#
group by team,period
</cfquery>		

<cfquery datasource="NBA" name="Get2ptMidmiss">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('2PTMISS') 
AND Team='#Team#' 
AND OFFDEF='O'
AND (ShotLength >= 10 and ShotLength < 22)
and Period = #x#
group by team,period
</cfquery>		


<cfquery datasource="NBA" name="oppGet2ptshortmake">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('2PTMADE') 
AND Team='#opp#' 
AND OFFDEF='O'
AND ShotLength < 10
and Period = #x#
group by team,period
</cfquery>		


<cfquery datasource="NBA" name="oppGet2ptshortmiss">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('2PTMISS') 
AND Team='#opp#' 
AND OFFDEF='O'
AND ShotLength < 10
and Period = #x#
group by team,period
</cfquery>		

<cfquery datasource="NBA" name="oppGet2ptMidmake">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('2PTMADE') 
AND Team='#opp#' 
AND OFFDEF='O'
AND (ShotLength >= 10 and ShotLength < 22)
and Period = #x#
group by team,period
</cfquery>		

<cfquery datasource="NBA" name="oppGet2ptMidmiss">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('2PTMISS') 
AND Team='#opp#' 
AND OFFDEF='O'
AND (ShotLength >= 10 and ShotLength < 22)
and Period = #x#
group by team,period
</cfquery>		













	
<cfquery datasource="NBA" name="oppGet2ptmake">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('2PTMADE') 
AND Team='#opp#' 
AND OFFDEF='O'
and Period = #x#
group by team,period
</cfquery>		

<cfquery datasource="NBA" name="Get2ptmiss">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('2PTMISS') 
AND Team='#Team#' 
AND OFFDEF='O'
and Period = #x#
group by team,period
</cfquery>		
	
<cfquery datasource="NBA" name="oppGet2ptmiss">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('2PTMISS') 
AND Team='#opp#' 
AND OFFDEF='O'
and Period = #x#
group by team,period
</cfquery>		


<cfquery datasource="NBA" name="Get3ptmake">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('3PTMADE') 
AND Team='#Team#' 
AND OFFDEF='O'
and Period = #x#
group by team,period
</cfquery>		
	
<cfquery datasource="NBA" name="oppGet3ptmake">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('3PTMADE') 
AND Team='#opp#' 
AND OFFDEF='O'
and Period = #x#
group by team,period
</cfquery>		

<cfquery datasource="NBA" name="Get3ptmiss">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('3PTMISS') 
AND Team='#Team#' 
AND OFFDEF='O'
and Period = #x#
group by team,period
</cfquery>		
	
<cfquery datasource="NBA" name="oppGet3ptmiss">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('3PTMISS') 
AND Team='#opp#' 
AND OFFDEF='O'
and Period = #x#
group by team,period
</cfquery>		


<cfquery datasource="NBA" name="GetFTmake">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('FTMADE') 
AND Team='#Team#' 
AND OFFDEF='O'
and Period = #x#
group by team,period
</cfquery>		
	
<cfquery datasource="NBA" name="oppGetFTmake">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('FTMADE') 
AND Team='#opp#' 
AND OFFDEF='O'
and Period = #x#
group by team,period
</cfquery>		

<cfquery datasource="NBA" name="GetFTmiss">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('FTMISS') 
AND Team='#Team#' 
AND OFFDEF='O'
and Period = #x#
group by team,period
</cfquery>		
	
<cfquery datasource="NBA" name="oppGetFTmiss">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('FTMISS') 
AND Team='#opp#' 
AND OFFDEF='O'
and Period = #x#
group by team,period
</cfquery>		

<cfquery datasource="NBA" name="GetTurnovers">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('TURNOVER') 
AND Team='#Team#' 
AND OFFDEF='O'
and Period = #x#
group by team,period
</cfquery>		
	
<cfquery datasource="NBA" name="oppGetTurnovers">
Select count(*) as STAT,period 
from PBPResults where PlayType in ('TURNOVER') 
AND Team='#opp#' 
AND OFFDEF='O'
and Period = #x#
group by team,period
</cfquery>		


<cfset tm2ptmakePct1 = 0>
<cfset tm2ptmakePct2 = 0>
<cfset tm2ptmakePct3 = 0>
<cfset tm2ptmakePct4 = 0>


<cfif Get2ptmake["Period"][1] gt ''>
	<cfset tm2ptmakePct1 = Get2ptmake["Stat"][1]>
</cfif>

<cfif Get2ptmake["Period"][2] gt ''>	
	<cfset tm2ptmakePct2 = Get2ptmake["Stat"][2]>
</cfif>	
	
<cfif Get2ptmake["Period"][3] gt ''>	
	<cfset tm2ptmakePct3 = Get2ptmake["Stat"][3]>
</cfif>
	
<cfif Get2ptmake["Period"][4] gt ''>	
	<cfset tm2ptmakePct4 = Get2ptmake["Stat"][4]>
</cfif>

<cfif oppGet2ptmake["Period"][1] gt ''>
	<cfset opp2ptmakePct1 = oppGet2ptmake["Stat"][1]>
</cfif>

<cfif oppGet2ptmake["Period"][2] gt ''>	
	<cfset opp2ptmakePct2 = oppGet2ptmake["Stat"][2]>
</cfif>

<cfif oppGet2ptmake["Period"][3] gt ''>	
	<cfset opp2ptmakePct3 = oppGet2ptmake["Stat"][3]>
</cfif>

<cfif oppGet2ptmake["Period"][4] gt ''>	
	<cfset opp2ptmakePct4 = oppGet2ptmake["Stat"][4]>
</cfif>		

<cfset tm2ptmissPct1 = 0>
<cfset tm2ptmissPct2 = 0>
<cfset tm2ptmissPct3 = 0>
<cfset tm2ptmissPct4 = 0>
<cfset opp2ptmissPct1 = 0>
<cfset opp2ptmissPct2 = 0>
<cfset opp2ptmissPct3 = 0>
<cfset opp2ptmissPct4 = 0>

<cfif Get2ptmiss["Period"][1] gt ''>
	<cfset tm2ptmissPct1 = Get2ptmiss["Stat"][1]>
</cfif>

<cfif Get2ptmiss["Period"][2] gt ''>
	<cfset tm2ptmissPct2 = Get2ptmiss["Stat"][2]>
</cfif>

<cfif Get2ptmiss["Period"][3] gt ''>
	<cfset tm2ptmissPct3 = Get2ptmiss["Stat"][3]>
</cfif>

<cfif Get2ptmiss["Period"][4] gt ''>
	<cfset tm2ptmissPct4 = Get2ptmiss["Stat"][4]>
</cfif>


<cfif oppGet2ptmiss["Period"][1] gt ''>
	<cfset opp2ptmissPct1 = oppGet2ptmiss["Stat"][1]>
</cfif>

<cfif oppGet2ptmiss["Period"][2] gt ''>
	<cfset opp2ptmissPct2 = oppGet2ptmiss["Stat"][2]>
</cfif>

<cfif oppGet2ptmiss["Period"][3] gt ''>
	<cfset opp2ptmissPct3 = oppGet2ptmiss["Stat"][3]>
</cfif>

<cfif oppGet2ptmiss["Period"][4] gt ''>
	<cfset opp2ptmissPct4 = oppGet2ptmiss["Stat"][4]>
</cfif>


<cfset tm3ptmakePct1 = 0>
<cfset tm3ptmakePct2 = 0>
<cfset tm3ptmakePct3 = 0>
<cfset tm3ptmakePct4 = 0>
<cfset opp3ptmakePct1 = 0>
<cfset opp3ptmakePct2 = 0>
<cfset opp3ptmakePct3 = 0>
<cfset opp3ptmakePct4 = 0>
		

<cfif Get3ptmake["Period"][1] gt ''>
	<cfset tm3ptmakePct1 = Get3ptmake["Stat"][1]>
</cfif>

<cfif Get3ptmake["Period"][2] gt ''>
	<cfset tm3ptmakePct2 = Get3ptmake["Stat"][2]>
</cfif>

<cfif Get3ptmake["Period"][3] gt ''>
	<cfset tm3ptmakePct3 = Get3ptmake["Stat"][3]>
</cfif>

<cfif Get3ptmake["Period"][4] gt ''>
	<cfset tm3ptmakePct4 = Get3ptmake["Stat"][4]>
</cfif>


<cfif oppGet3ptmake["Period"][1] gt ''>
	<cfset opp3ptmakePct1 = oppGet3ptmake["Stat"][1]>
</cfif>

<cfif oppGet3ptmake["Period"][2] gt ''>
	<cfset opp3ptmakePct2 = oppGet3ptmake["Stat"][2]>
</cfif>

<cfif oppGet3ptmake["Period"][3] gt ''>
	<cfset opp3ptmakePct3 = oppGet3ptmake["Stat"][3]>
</cfif>

<cfif oppGet3ptmake["Period"][4] gt ''>
	<cfset opp3ptmakePct4 = oppGet3ptmake["Stat"][4]>
</cfif>






<cfset tm3ptmissPct1 = 0>
<cfset tm3ptmissPct2 = 0>
<cfset tm3ptmissPct3 = 0>
<cfset tm3ptmissPct4 = 0>
<cfset opp3ptmissPct1 = 0>
<cfset opp3ptmissPct2 = 0>
<cfset opp3ptmissPct3 = 0>
<cfset opp3ptmissPct4 = 0>
		

<cfif Get3ptmiss["Period"][1] gt ''>
	<cfset tm3ptmissPct1 = Get3ptmiss["Stat"][1]>
</cfif>

<cfif Get3ptmiss["Period"][2] gt ''>
	<cfset tm3ptmissPct2 = Get3ptmiss["Stat"][2]>
</cfif>

<cfif Get3ptmiss["Period"][3] gt ''>
	<cfset tm3ptmissPct3 = Get3ptmiss["Stat"][3]>
</cfif>

<cfif Get3ptmiss["Period"][4] gt ''>
	<cfset tm3ptmissPct4 = Get3ptmiss["Stat"][4]>
</cfif>


<cfif oppGet3ptmiss["Period"][1] gt ''>
	<cfset opp3ptmissPct1 = oppGet3ptmiss["Stat"][1]>
</cfif>

<cfif oppGet3ptmiss["Period"][2] gt ''>
	<cfset opp3ptmissPct2 = oppGet3ptmiss["Stat"][2]>
</cfif>

<cfif oppGet3ptmiss["Period"][3] gt ''>
	<cfset opp3ptmissPct3 = oppGet3ptmiss["Stat"][3]>
</cfif>

<cfif oppGet3ptmiss["Period"][4] gt ''>
	<cfset opp3ptmissPct4 = oppGet3ptmiss["Stat"][4]>
</cfif>























		
		
		
		
		



<cfset oppFTmissPct1 = 0>
<cfset oppFTmissPct2 = 0>
<cfset oppFTmissPct3 = 0>
<cfset oppFTmissPct4 = 0>
<cfset oppFTmakePct1 = 0>		
<cfset oppFTmakePct2 = 0>		
<cfset oppFTmakePct3 = 0>		
<cfset oppFTmakePct4 = 0>		
		
		
		
		
<cfset tmFTmissPct1 = 0>
<cfset tmFTmissPct2 = 0>
<cfset tmFTmissPct3 = 0>
<cfset tmFTmissPct4 = 0>
<cfset tmFTmakePct1 = 0>		
<cfset tmFTmakePct2 = 0>		
<cfset tmFTmakePct3 = 0>		
<cfset tmFTmakePct4 = 0>		


<cfif GetFTmake["Period"][1] gt ''>
	<cfset tmFTmakePct1 = GetFTmake["Stat"][1]>
</cfif>

<cfif GetFTmake["Period"][2] gt ''>
	<cfset tmFTmakePct2 = GetFTmake["Stat"][2]>
</cfif>

<cfif GetFTmake["Period"][3] gt ''>
	<cfset tmFTmakePct3 = GetFTmake["Stat"][3]>
</cfif>

<cfif GetFTmake["Period"][4] gt ''>
	<cfset tmFTmakePct4 = GetFTmake["Stat"][4]>
</cfif>


<cfif oppGetFTmake["Period"][1] gt ''>
	<cfset oppFTmakePct1 = oppGetFTmake["Stat"][1]>
</cfif>

<cfif oppGetFTmake["Period"][2] gt ''>
	<cfset oppFTmakePct2 = oppGetFTmake["Stat"][2]>
</cfif>

<cfif oppGetFTmake["Period"][3] gt ''>
	<cfset oppFTmakePct3 = oppGetFTmake["Stat"][3]>
</cfif>

<cfif oppGetFTmake["Period"][4] gt ''>
	<cfset oppFTmakePct4 = oppGetFTmake["Stat"][4]>
</cfif>




<cfif GetFTmiss["Period"][1] gt ''>
	<cfset tmFTmissPct1 = GetFTmiss["Stat"][1]>
</cfif>

<cfif GetFTmiss["Period"][2] gt ''>
	<cfset tmFTmissPct2 = GetFTmiss["Stat"][2]>
</cfif>
<cfif GetFTmiss["Period"][2] gt ''>
	<cfset tmFTmissPct3 = GetFTmiss["Stat"][3]>
</cfif>
<cfif GetFTmiss["Period"][4] gt ''>
	<cfset tmFTmissPct4 = GetFTmiss["Stat"][4]>
</cfif>

<cfif oppGetFTmiss["Period"][1] gt ''>
	<cfset oppFTmissPct1 = oppGetFTmiss["Stat"][1]>
</cfif>

<cfif oppGetFTmiss["Period"][2] gt ''>
	<cfset oppFTmissPct2 = oppGetFTmiss["Stat"][2]>
</cfif>

<cfif oppGetFTmiss["Period"][3] gt ''>
	<cfset oppFTmissPct3 = oppGetFTmiss["Stat"][3]>
</cfif>

<cfif oppGetFTmiss["Period"][4] gt ''>
	<cfset oppFTmissPct4 = oppGetFTmiss["Stat"][4]>
</cfif>



<cfset tmTurnover1 = 0>
<cfset tmTurnover2 = 0>
<cfset tmTurnover3 = 0>
<cfset tmTurnover4 = 0>
<cfset oppTurnover1 = 0>
<cfset oppTurnover2 = 0>
<cfset oppTurnover3 = 0>
<cfset oppTurnover4 = 0>

<cfif GetTurnovers["Period"][1] gt ''>
	<cfset tmTurnover1 = GetTurnovers["Stat"][1]>
</cfif>
<cfif GetTurnovers["Period"][2] gt ''>
	<cfset tmTurnover2 = GetTurnovers["Stat"][2]>
</cfif>
<cfif GetTurnovers["Period"][3] gt ''>
	<cfset tmTurnover3 = GetTurnovers["Stat"][3]>
</cfif>
<cfif GetTurnovers["Period"][4] gt ''>	
	<cfset tmTurnover4 = GetTurnovers["Stat"][4]>
</cfif>

<cfif oppGetTurnovers["Period"][1] gt ''>
	<cfset oppTurnover1 = oppGetTurnovers["Stat"][1]>
</cfif>
<cfif oppGetTurnovers["Period"][2] gt ''>	
	<cfset oppTurnover2 = oppGetTurnovers["Stat"][2]>
</cfif>
<cfif oppGetTurnovers["Period"][3] gt ''>	
	<cfset oppTurnover3 = oppGetTurnovers["Stat"][3]>
</cfif>
<cfif oppGetTurnovers["Period"][4] gt ''>
	<cfset oppTurnover4 = oppGetTurnovers["Stat"][4]>
</cfif>

<cfset Stat1 = 0>
<cfset Stat2 = 0>
<cfset Stat3 = 0>
<cfset Stat4 = 0>

<cfif GetOffStats["Stat"][#x#] gt ''>
	<cfset Stat1 = GetOffStats["Stat"][#x#]>
</cfif>

<cfif GetShortMissReb["Stat"][#x#] gt ''>
	<cfset Stat2 = GetShortMissReb["Stat"][#x#]>
</cfif>	

<cfif GetMidMissReb["Stat"][#x#] gt ''>
	<cfset Stat3 = GetMidMissReb["Stat"][#x#]>
</cfif>

<cfif GetLongMissReb["Stat"][#x#] gt ''>
	<cfset Stat4 = GetLongMissReb["Stat"][#x#]>
</cfif>	

<cfset TotPlays1 = Stat1 - (Stat2 + Stat3 + Stat4) >


<cfoutput>
DEN<p>
Total Plays for Simulation Qtr1: #TotPlays1#<br>
2ptmakePct = #tm2ptmakepct1/GetOffStats["Stat"][1]#<br>
2ptmissPct = #tm2ptmisspct1/GetOffStats["Stat"][1]#<br>
3ptmakePct = #tm3ptmakepct1/GetOffStats["Stat"][1]#<br>
3ptmissPct = #tm3ptmisspct1/GetOffStats["Stat"][1]#<br>
FTmakePct = #tmFTmakepct1/GetOffStats["Stat"][1]#<br>
FTmissPct = #tmFTmisspct1/GetOffStats["Stat"][1]#<br>
TURNOVER Pct = #tmTurnover1/GetOffStats["Stat"][1]#<br>
2ptmissshort Pct = #Get2ptshortmiss["Stat"][1]/GetOffStats["Stat"][1]#<br> 
2ptmakeshort Pct = #Get2ptshortmake["Stat"][1]/GetOffStats["Stat"][1]#<br> 
2ptmissMid Pct = #Get2ptmidmiss["Stat"][1]/GetOffStats["Stat"][1]#<br> 
<cfif Get2ptmidmake["Stat"][#x#] gt ''>
	2ptmakeMid Pct = #Get2ptmidmake["Stat"][1]/GetOffStats["Stat"][1]#<br> 
<cfelse>
	2ptmakeMid Pct = 0<br>
</cfif>
	

<cfset Stat1 = 0>
<cfset Stat2 = 0>
<cfset Stat3 = 0>

<cfif GetShortMissReb["Stat"][#x#] gt ''>
	<cfset Stat1 = GetShortMissReb["Stat"][#x#]>
</cfif>

<cfif GetMidMissReb["Stat"][#x#] gt ''>
	<cfset Stat2 = GetMidMissReb["Stat"][#x#]>
</cfif>

<cfif GetLongMissReb["Stat"][#x#] gt ''>
	<cfset Stat3 = GetLongMissReb["Stat"][#x#]>
</cfif>
OffReb         = #Stat1 + stat2 + stat3#<br>

<cfif GetShortMissReb["Stat"][x] gt ''>
ShortRebPct    = #GetShortMissReb["Stat"][x] / Get2ptshortmiss["Stat"][x]#<br>
<cfelse>
ShortRebPct = 0<br>
</cfif>

<cfif GetMidMissReb["Stat"][x] gt ''>
MidRebPct      = #GetMidMissReb["Stat"][x] / Get2ptmidmiss["Stat"][x]#<br>
<cfelse>
MidRebPct      = 0<br>
</cfif>

<cfif GetLongMissReb["Stat"][x] gt ''>
	LongRebPct     = #GetLongMissReb["Stat"][x] / Get3ptmiss["Stat"][x]#<br>
<cfelse>
LongRebPct     = 0<br>
</cfif>
<cfdump var="#GetShortMissReb#">
<cfdump var="#GetMidMissReb#">
<cfdump var="#GetLongMissReb#">

<cfabort>

<p>


MIL<p>
Total Plays for Simulation Qtr1: #TotPlays1#<br>
2ptmakePct = #opp2ptmakepct1/oppGetOffStats["Stat"][1]#<br>
2ptmissPct = #opp2ptmisspct1/oppGetOffStats["Stat"][1]#<br>
3ptmakePct = #opp3ptmakepct1/oppGetOffStats["Stat"][1]#<br>
3ptmissPct = #opp3ptmisspct1/oppGetOffStats["Stat"][1]#<br>
FTmakePct = #oppFTmakepct1/oppGetOffStats["Stat"][1]#<br>
FTmissPct = #oppFTmisspct1/oppGetOffStats["Stat"][1]#<br>
TURNOVER Pct = #oppTurnover1/oppGetOffStats["Stat"][1]#<br>
2ptmissshort Pct = #oppGet2ptshortmiss["Stat"][1]/oppGetOffStats["Stat"][1]#<br> 
2ptmakeshort Pct = #oppGet2ptshortmake["Stat"][1]/oppGetOffStats["Stat"][1]#<br> 
2ptmissMid Pct = #oppGet2ptmidmiss["Stat"][1]/oppGetOffStats["Stat"][1]#<br> 
2ptmakeMid Pct = #oppGet2ptmidmake["Stat"][1]/oppGetOffStats["Stat"][1]#<br> 
OffReb         = #oppGetShortMissReb["Stat"][1] + oppGetMidMissReb["Stat"][1] + oppGetLongMissReb["Stat"][1]#<br>
ShortRebPct    = #oppGetShortMissReb["Stat"][1] / oppGet2ptshortmiss["Stat"][1]#<br>
MidRebPct      = #oppGetMidMissReb["Stat"][1] / oppGet2ptmidmiss["Stat"][1]#<br>
LongRebPct     = #oppGetLongMissReb["Stat"][1] / oppGet3ptmiss["Stat"][1]#<br>
<p>


<p>

</cfoutput>
</cfloop>