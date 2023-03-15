
<cfif 1 is 1>

<cfquery datasource="Nba" name="Addit">
DELETE FROM PBPGameSimPcts
</cfquery>	

<cfloop index="x" from="1" to="2">
	<cfif x is 1>
		<cfset ha = 'A'>
		<cfset StoreTeam = 'MIL'>
		<cfset OppTeam   = 'DEN'>
		 
	<cfelse>	
		<cfset StoreTeam = 'DEN'>
		<cfset OppTeam = 'MIL'>
	</cfif>

<cfset AwayTeam  = StoreTeam>
<cfset Gametime = "20180227">

<cfquery datasource="NBA" name="GetShortMissReb">
Select Period,COUNT(*) as OffRebOffShort from PbPResults
where ShotLength < 6
and PlayType = '2PTMISS'
and Team = '#AwayTeam#'
and OffDef='O'
and id + 2 IN (Select Id FROM PBPResults Where Team = '#AwayTeam#' and OffDef='O' AND PlayType='OFFREB')
Group By Period
</cfquery>

<cfdump var="#GetShortMissReb#">

<cfquery datasource="NBA" name="GetMidMissReb">
Select period,COUNT(*) as OffRebOffMid from PbPResults
where (ShotLength >= 6 and ShotLength < 22)
and PlayType = '2PTMISS'
and Team = '#AwayTeam#'
and OffDef='O'
and id + 2 IN (Select Id FROM PBPResults Where Team = '#AwayTeam#' and OffDef='O' AND PlayType='OFFREB')
Group By Period
</cfquery>

<cfdump var="#GetMidMissReb#">

<cfquery datasource="NBA" name="GetLongMissReb">
Select Period,COUNT(*) as OffRebOffLong from PbPResults
where PlayType = '3PTMISS'
and Team = '#AwayTeam#'
and OffDef='O'
and id + 2 IN (Select Id FROM PBPResults Where Team = '#AwayTeam#' and OffDef='O' AND PlayType='OFFREB')
Group By Period
</cfquery>

<cfdump var="#GetLongMissReb#">

<cfquery datasource="NBA" name="GetLongAtt">
Select Period,COUNT(*) as Stat from PbPResults
where PlayType IN ('3PTMISS','3PTMADE')
and Team = '#AwayTeam#'
and OffDef='O'
Group By Period
</cfquery>













<cfquery datasource="NBA" name="GetShortMissCt">
Select Period,COUNT(*) as ct from PbPResults
where ShotLength < 6
and PlayType = '2PTMISS'
and Team = '#AwayTeam#'
and OffDef='O'
Group By Period
</cfquery>

<cfdump var="#GetShortMissCt#">

<cfquery datasource="NBA" name="GetMidMissCt">
Select period,COUNT(*) as ct from PbPResults
where (ShotLength >= 6 and ShotLength < 22)
and PlayType = '2PTMISS'
and Team = '#AwayTeam#'
and OffDef='O'
Group By Period
</cfquery>

<cfdump var="#GetMidMissCt#">

<cfquery datasource="NBA" name="GetLongMissCt">
Select Period,COUNT(*) as ct from PbPResults
where PlayType = '3PTMISS'
and Team = '#AwayTeam#'
and OffDef='O'
and id + 2 IN (Select Id FROM PBPResults Where Team = '#AwayTeam#' and OffDef='O' AND PlayType='OFFREB')
Group By Period
</cfquery>

<cfdump var="#GetLongMissCt#">

<cfset ShortMissRebPct1 =0>
<cfif GetShortMissCt["ct"][1] gt ''>
<cfif GetShortMissReb["OffRebOffShort"][1] gt ''>
	
		<cfset ShortMissRebPct1 = GetShortMissReb["OffRebOffShort"][1] / GetShortMissCt["ct"][1] >
	</cfif>
</cfif>

<cfset ShortMissRebPct2 =0>
<cfif GetShortMissCt["ct"][2] gt ''>
<cfif GetShortMissReb["OffRebOffShort"][2] gt ''>
	
		<cfset ShortMissRebPct2 = GetShortMissReb["OffRebOffShort"][2] / GetShortMissCt["ct"][2] >
	</cfif>
</cfif>

<cfset ShortMissRebPct3 =0>
<cfif GetShortMissCt["ct"][3] gt ''>
<cfif GetShortMissReb["OffRebOffShort"][3] gt ''>
	
		<cfset ShortMissRebPct3 = GetShortMissReb["OffRebOffShort"][3] / GetShortMissCt["ct"][3] >
	</cfif>
</cfif>		

<cfset ShortMissRebPct4 =0>
<cfif GetShortMissCt["ct"][4] gt ''>
<cfif GetShortMissReb["OffRebOffShort"][4] gt ''>
	
		<cfset ShortMissRebPct4 = GetShortMissReb["OffRebOffShort"][4] / GetShortMissCt["ct"][4] >
	</cfif>
</cfif>

<cfset MidMissRebPct1 =0>
<cfif GetMidMissReb["OffRebOffMid"][1] gt ''>
	<cfif GetMidMissCt["ct"][1] gt ''>
		<cfset MidMissRebPct1 = GetMidMissReb["OffRebOffMid"][1] / GetMidMissCt["ct"][1] >
	</cfif>
</cfif>
	
<cfset MidMissRebPct2 =0>
<cfif GetMidMissReb["OffRebOffMid"][2] gt ''>
	<cfif GetMidMissCt["ct"][2] gt ''>
		<cfset MidMissRebPct2 = GetMidMissReb["OffRebOffMid"][2] / GetMidMissCt["ct"][2] >
	</cfif>
</cfif>

<cfset MidMissRebPct3 =0>
<cfif GetMidMissReb["OffRebOffMid"][3] gt ''>
	<cfif GetMidMissCt["ct"][3] gt ''>
		<cfset MidMissRebPct3 = GetMidMissReb["OffRebOffMid"][3] / GetMidMissCt["ct"][3] >
	</cfif>
</cfif>

<cfset MidMissRebPct4 =0>
<cfif GetMidMissReb["OffRebOffMid"][4] gt ''>
	<cfif GetMidMissCt["ct"][4] gt ''>
		<cfset MidMissRebPct4 = GetMidMissReb["OffRebOffMid"][4] / GetMidMissCt["ct"][4] >
	</cfif>
</cfif>

<cfset LongMissRebPct1 =0>
<cfif GetLongMissReb["OffRebOffLong"][1] gt ''>
	<cfif GetLongMissCt["ct"][1] gt ''>
		<cfset LongMissRebPct1 = GetLongMissReb["OffRebOffLong"][1] / GetLongMissCt["ct"][1] >
	</cfif>
</cfif>

<cfset LongMissRebPct2 =0>
<cfif GetLongMissReb["OffRebOffLong"][2] gt ''>
	<cfif GetLongMissCt["ct"][2] gt ''>
		<cfset LongMissRebPct2 = GetLongMissReb["OffRebOffLong"][2] / GetLongMissCt["ct"][2] >
	</cfif>	
</cfif>		
		

<cfset LongMissRebPct3 =0>
<cfif GetLongMissReb["OffRebOffLong"][3] gt ''>
	<cfif GetLongMissCt["ct"][3] gt ''>
		<cfset LongMissRebPct3 = GetLongMissReb["OffRebOffLong"][3] / GetLongMissCt["ct"][3] >
	</cfif>	
</cfif>		

<cfset LongMissRebPct4 =0>
<cfif GetLongMissReb["OffRebOffLong"][4] gt ''>
	<cfif GetLongMissCt["ct"][4] gt ''>
		<cfset LongMissRebPct4 = GetLongMissReb["OffRebOffLong"][4] / GetLongMissCt["ct"][4] >
	</cfif>	
</cfif>		









<cfoutput>
ShortMissRebPct1 = #ShortMissRebPct1#<br>
ShortMissRebPct2 = #ShortMissRebPct2#<br>
ShortMissRebPct3 = #ShortMissRebPct3#<br>
ShortMissRebPct4 = #ShortMissRebPct4#<br>

MidMissRebPct1 = #MidMissRebPct1#<br>
MidMissRebPct2 = #MidMissRebPct2#<br>
MidMissRebPct3 = #MidMissRebPct3#<br>
MidMissRebPct4 = #MidMissRebPct4#<br>

LongMissRebPct1 = #LongMissRebPct1#<br>
LongMissRebPct2 = #LongMissRebPct2#<br>
LongMissRebPct3 = #LongMissRebPct3#<br>
LongMissRebPct4 = #LongMissRebPct4#<br>
</cfoutput>

<cfquery datasource="NBA" name="GetShort">
Select Team,period,count(*) as ShortShot
from PBPResults
where ShotType = 'SHOT' 
and Team = '#AwayTeam#'
and OffDef = 'O'
and ShotLength < 6
Group By Team,Period
</cfquery>


<cfquery datasource="NBA" name="GetShortMakePct">
Select Team,period,count(*) as ShortMake
from PBPResults
where ShotType = 'SHOT' 
and Team = '#AwayTeam#'
and OffDef = 'O'
and ShotLength < 6
and PlayType = '2PTMADE'
Group By Team,Period
</cfquery>


<cfquery datasource="NBA" name="GetMid">
Select Team,period,count(*) as Mid
from PBPResults
where ShotType = 'SHOT' 
and Team = '#AwayTeam#'
and OffDef = 'O'
and (ShotLength > 5 and ShotLength < 22)
Group By Team,Period
</cfquery>


<cfquery datasource="NBA" name="GetMidMakePct">
Select Team,period,count(*) as MidMake
from PBPResults
where ShotType = 'SHOT' 
and Team = '#AwayTeam#'
and OffDef = 'O'
and (ShotLength > 5 and ShotLength < 22)
and PlayType = '2PTMADE'
Group By Team,Period
</cfquery>


<cfquery datasource="NBA" name="GetLongMakePct">
Select Team,period,count(*) as Stat
from PBPResults
where ShotType = 'SHOT' 
and Team = '#AwayTeam#'
and OffDef = 'O'
and PlayType = '3PTMADE'
Group By Team,Period
</cfquery>






FGA
<cfquery datasource="NBA" name="GetFGA">
Select Team,period,count(*) as fga
from PBPResults
where ShotType = 'SHOT' 
and Team = '#AwayTeam#'
and OffDef = 'O'
Group By Team,Period
</cfquery>


<cfquery datasource="NBA" name="GetMisses">
Select Team,period,count(*) as Stat
from PBPResults
where ShotType = 'SHOT' 
and Team = '#AwayTeam#'
and OffDef = 'O'
and PlayType in ('2PTMISS','3PTMISS')
Group By Team,Period
</cfquery>



FTA
<cfquery datasource="NBA" name="GetFTA">
Select Team,period,count(*) as fta
from PBPResults
where ShotType = 'FTA'
and Team = '#AwayTeam#'
and OffDef = 'O' 
Group By Team,Period
</cfquery>

Off Reb
<cfquery datasource="NBA" name="GetOffReb">
Select Team,period,count(*) as OffReb
from PBPResults
where ShotType = 'REBOUND' 
and PlayType = 'OFFREB'
and Team = '#AwayTeam#'
and OffDef = 'O'
and id not in
(
Select Id from PBPResults where Playtype='OFFREB' and 
	ID - 2 IN (Select ID from PBPResults Where PlayType='FTMISS' and OffDef='O' and Team='#awayteam#')
)
Group By Team,Period
</cfquery>

Def Reb
<cfquery datasource="NBA" name="GetDefReb">
Select Team,period,count(*) as DefReb
from PBPResults
where ShotType = 'REBOUND' 
and PlayType = 'DEFREB'
and Team = '#AwayTeam#'
and OffDef = 'D'
Group By Team,Period
</cfquery>

Turnovers
<cfquery datasource="NBA" name="GetOffTurnovers">
Select Team,period,count(*) as oTurnovers
from PBPResults
where ShotType = 'TURNOVER'
and Team = '#AwayTeam#'
and OffDef = 'O'
Group By Team,Period
</cfquery>

Turnovers
<cfquery datasource="NBA" name="GetDefTurnovers">
Select Team,period,count(*) as dTurnovers
from PBPResults
where ShotType = 'TURNOVER'
and Team = '#AwayTeam#'
and OffDef = 'D'
Group By Team,Period
</cfquery>

<table>
<tr>
<td>Team
</td>
<td>Quarter
</td>
<td>FGA
</td>
</tr>
<cfoutput query="GetFGA">
<tr>
<td>#Team#
</td>
<td>#Period#
</td>
<td>#FGA#
</td>
</tr>
</cfoutput>
</table>

<table>
<tr>
<td>Team
</td>
<td>Quarter
</td>
<td>FTA
</td>
</tr>
<cfoutput query="GetFTA">
<tr>
<td>#Team#
</td>
<td>#Period#
</td>
<td>#FTA#
</td>
</tr>
</cfoutput>
</table>


<table>
<tr>
<td>Team
</td>
<td>Quarter
</td>
<td>Off Reb
</td>
</tr>
<cfoutput query="GetOffReb">
<tr>
<td>#Team#
</td>
<td>#Period#
</td>
<td>#OffReb#
</td>
</tr>
</cfoutput>
</table>

<table>
<tr>
<td>Team
</td>
<td>Quarter
</td>
<td>Def Reb
</td>
</tr>
<cfoutput query="GetDefReb">
<tr>
<td>#Team#
</td>
<td>#Period#
</td>
<td>#DefReb#
</td>
</tr>
</cfoutput>
</table>

<table>
<tr>
<td>Team
</td>
<td>Quarter
</td>
<td>Off Turnovers
</td>
</tr>
<cfoutput query="GetoffTurnovers">
<tr>
<td>#Team#
</td>
<td>#Period#
</td>
<td>#oTurnovers#
</td>
</tr>
</cfoutput>
</table>


<table>
<tr>
<td>Team
</td>
<td> Quarter
</td>
<td>Def Turnovers
</td>
</tr>
<cfoutput query="GetDefTurnovers">
<tr>
<td>#Team#
</td>
<td>#Period#
</td>
<td>#dTurnovers#
</td>
</tr>
</cfoutput>
</table>


<cfset PosQtr1 = GetFGA["fga"][1] + GetFTA["fta"][1] + GetOffReb["OffReb"][1] + GetDefReb["DefReb"][1] + GetDefTurnovers["DTurnovers"][1] >
<cfset PosQtr2 = GetFGA["fga"][2] + GetFTA["fta"][2] + GetOffReb["OffReb"][2] + GetDefReb["DefReb"][2] + GetDefTurnovers["DTurnovers"][2] >
<cfset PosQtr3 = GetFGA["fga"][3] + GetFTA["fta"][3] + GetOffReb["OffReb"][3] + GetDefReb["DefReb"][3] + GetDefTurnovers["DTurnovers"][3] >
<cfset PosQtr4 = GetFGA["fga"][4] + GetFTA["fta"][4] + GetOffReb["OffReb"][4] + GetDefReb["DefReb"][4] + GetDefTurnovers["DTurnovers"][4] >
<cfset TotPoss = PosQtr1 + PosQtr2 + PosQtr3 + PosQtr4>










<cfquery datasource="NBA" name="GetPoss">
Select Team,period,count(*) as Stat
from PBPResults
where ShotType IN ('TURNOVER','SHOT','FTA')
and Team = '#AwayTeam#'
and OffDef = 'O'
Group By Team,Period
</cfquery>

<cfset PosQtr1 = GetPOSS["stat"][1]>
<cfset PosQtr2 = GetPOSS["stat"][2]>
<cfset PosQtr3 = GetPOSS["stat"][3]>
<cfset PosQtr4 = GetPOSS["stat"][4]>

<cfquery datasource="NBA" name="GetTOPct">
Select Team,period,count(*) as Stat
from PBPResults
where ShotType IN ('TURNOVER')
and Team = '#AwayTeam#'
and OffDef = 'O'
Group By Team,Period
</cfquery>

<cfset TOPct1 = 0>
<cfset TOPct2 = 0>
<cfset TOPct3 = 0>
<cfset TOPct4 = 0>

<cfif GetTOPct["Stat"][1] gt ''>
	<cfset TOPct1 = GetTOPct["Stat"][1] / PosQtr1>
</cfif>	
<cfif GetTOPct["Stat"][2] gt ''>
	<cfset TOPct2 = GetTOPct["Stat"][2] / PosQtr2>
</cfif>	
<cfif GetTOPct["Stat"][3] gt ''>
	<cfset TOPct3 = GetTOPct["Stat"][3] / PosQtr3>
</cfif>	
<cfif GetTOPct["Stat"][4] gt ''>
	<cfset TOPct4 = GetTOPct["Stat"][4] / PosQtr4>
</cfif>	

<cfset LongMakePct1 = 0>
<cfif GetLongMakePct["Period"][1] gt ''>
	<cfset LongMakePct1 = GetLongMakePct["Stat"][1] / PosQtr1>
</cfif>	

<cfset LongMakePct2 = 0>
<cfif GetLongMakePct["Period"][2] gt ''>
	<cfset LongMakePct2 = GetLongMakePct["Stat"][2] / PosQtr2>
</cfif>	

<cfset LongMakePct3 = 0>
<cfif GetLongMakePct["Period"][3] gt ''>
	<cfset LongMakePct3 = GetLongMakePct["Stat"][3] / PosQtr3>
</cfif>	

<cfset LongMakePct4 = 0>
<cfif GetLongMakePct["Period"][4] gt ''>
	<cfset LongMakePct4 = GetLongMakePct["Stat"][4] / PosQtr4>
</cfif>	

<cfdump var="#GetLongMakePct#">
<cfdump var="#GetLongAtt#">
done
	
<cfset LongAttPct1 = 0>
<cfif GetLongAtt["Period"][1] gt ''>
	<cfset LongAttPct1 = GetLongAtt["Stat"][1] / PosQtr1>
</cfif>		

<cfset LongAttPct2 = 0>
<cfif GetLongAtt["Period"][2] gt ''>
	<cfset LongAttPct2 = GetLongAtt["Stat"][2] / PosQtr2 >
</cfif>		

<cfset LongAttPct3 = 0>
<cfif GetLongAtt["Period"][3] gt ''>
	<cfset LongAttPct3 = GetLongAtt["Stat"][3] / PosQtr3 >
</cfif>		


<cfset LongAttPct4 = 0>
<cfif GetLongAtt["Period"][4] gt ''>
	<cfset LongAttPct4 = GetLongAtt["Stat"][4] / PosQtr4 >
</cfif>		







<cfset FGA1Pct = GetFGA["fga"][1] / PosQtr1>
<cfset FGA2Pct = GetFGA["fga"][2] / PosQtr2>
<cfset FGA3Pct = GetFGA["fga"][3] / PosQtr3>
<cfset FGA4Pct = GetFGA["fga"][4] / PosQtr4>

<cfset FTA1Pct = GetFTA["fta"][1] / PosQtr1>
<cfset FTA2Pct = GetFTA["fta"][2] / PosQtr2>
<cfset FTA3Pct = GetFTA["fta"][3] / PosQtr3>
<cfset FTA4Pct = GetFTA["fta"][4] / PosQtr4>

	<cfif x is 1>

		<cfquery datasource="Nba" name="Addit">
			INSERT INTO PBPGameSimPcts(OffDef,Gametime,Team,opp,ha,Qtr1Poss,Qtr2Poss,Qtr3Poss,Qtr4Poss,Qtr1FGAPct,Qtr2FGAPct,Qtr3FGAPct,Qtr4FGAPct,Qtr1FTAPct,Qtr2FTAPct,Qtr3FTAPct,Qtr4FTAPct)
			VALUES('O','#gametime#','#StoreTeam#','#OppTeam#','A',#PosQtr1#,#PosQtr2#,#PosQtr3#,#PosQtr4#,#FGA1Pct#,#FGA2Pct#,#FGA3Pct#,#FGA4Pct#,#FTA1Pct#,#FTA2Pct#,#FTA3Pct#,#FTA4Pct#)
		</cfquery>	

		<cfquery datasource="Nba" name="Addit">
			INSERT INTO PBPGameSimPcts(OffDef,Gametime,Team,opp,ha,Qtr1Poss,Qtr2Poss,Qtr3Poss,Qtr4Poss,Qtr1FGAPct,Qtr2FGAPct,Qtr3FGAPct,Qtr4FGAPct,Qtr1FTAPct,Qtr2FTAPct,Qtr3FTAPct,Qtr4FTAPct)
			VALUES('D','#gametime#','#OppTeam#','#StoreTeam#','H',#PosQtr1#,#PosQtr2#,#PosQtr3#,#PosQtr4#,#FGA1Pct#,#FGA2Pct#,#FGA3Pct#,#FGA4Pct#,#FTA1Pct#,#FTA2Pct#,#FTA3Pct#,#FTA4Pct#)
		</cfquery>	

	<cfelse>
	
		<cfquery datasource="Nba" name="Addit">
			INSERT INTO PBPGameSimPcts(OffDef,Gametime,Team,opp,ha,Qtr1Poss,Qtr2Poss,Qtr3Poss,Qtr4Poss,Qtr1FGAPct,Qtr2FGAPct,Qtr3FGAPct,Qtr4FGAPct,Qtr1FTAPct,Qtr2FTAPct,Qtr3FTAPct,Qtr4FTAPct)
			VALUES('O','#gametime#','#StoreTeam#','#OppTeam#','H',#PosQtr1#,#PosQtr2#,#PosQtr3#,#PosQtr4#,#FGA1Pct#,#FGA2Pct#,#FGA3Pct#,#FGA4Pct#,#FTA1Pct#,#FTA2Pct#,#FTA3Pct#,#FTA4Pct#)
		</cfquery>	

		<cfquery datasource="Nba" name="Addit">
			INSERT INTO PBPGameSimPcts(OffDef,Gametime,Team,opp,ha,Qtr1Poss,Qtr2Poss,Qtr3Poss,Qtr4Poss,Qtr1FGAPct,Qtr2FGAPct,Qtr3FGAPct,Qtr4FGAPct,Qtr1FTAPct,Qtr2FTAPct,Qtr3FTAPct,Qtr4FTAPct)
			VALUES('D','#gametime#','#OppTeam#','#StoreTeam#','A',#PosQtr1#,#PosQtr2#,#PosQtr3#,#PosQtr4#,#FGA1Pct#,#FGA2Pct#,#FGA3Pct#,#FGA4Pct#,#FTA1Pct#,#FTA2Pct#,#FTA3Pct#,#FTA4Pct#)
		</cfquery>	
	
	
	</cfif>
		
		
		
		
		
<cfset Oreb1Pct = GetOffReb["OffReb"][1] / GetMisses["Stat"][1]>
<cfset Oreb2Pct = GetOffReb["OffReb"][2] / GetMisses["Stat"][2]>
<cfset Oreb3Pct = GetOffReb["OffReb"][3] / GetMisses["Stat"][3]>
<cfset Oreb4Pct = GetOffReb["OffReb"][4] / GetMisses["Stat"][4]>

This is it:<br>
<cfdump var="#GetOffReb#">



<cfset DefReb1Pct = GetDefReb["DefReb"][1] / PosQtr1>
<cfset DefReb2Pct = GetDefReb["DefReb"][2] / PosQtr2>
<cfset DefReb3Pct = GetDefReb["DefReb"][3] / PosQtr3>
<cfset DefReb4Pct = GetDefReb["DefReb"][4] / PosQtr4>

<cfset TOFor1Pct = GetDefTurnovers["DTurnovers"][1] / PosQtr1>
<cfset TOFor2Pct = GetDefTurnovers["DTurnovers"][2] / PosQtr2>
<cfset TOFor3Pct = GetDefTurnovers["DTurnovers"][3] / PosQtr3>
<cfset TOFor4Pct = GetDefTurnovers["DTurnovers"][4] / PosQtr4>

<cfset ShortAtt1Pct = GetShort["ShortShot"][1] / PosQtr1>
<cfset ShortAtt2Pct = GetShort["ShortShot"][2] / PosQtr2>
<cfset ShortAtt3Pct = GetShort["ShortShot"][3] / PosQtr3>
<cfset ShortAtt4Pct = GetShort["ShortShot"][4] / PosQtr4>


<cfset ShortMake1Pct = GetShortMakePct["ShortMake"][1] / GetShort["ShortShot"][1]>
<cfset ShortMake2Pct = GetShortMakePct["ShortMake"][2] / GetShort["ShortShot"][2]>
<cfset ShortMake3Pct = GetShortMakePct["ShortMake"][3] / GetShort["ShortShot"][3]>
<cfset ShortMake4Pct = GetShortMakePct["ShortMake"][4] / GetShort["ShortShot"][4]>

<cfset MidAtt1Pct = 0>
<cfset MidAtt2Pct = 0>
<cfset MidAtt3Pct = 0>
<cfset MidAtt4Pct = 0>
<cfset MidMake1Pct = 0>
<cfset MidMake2Pct = 0>
<cfset MidMake3Pct = 0>
<cfset MidMake4Pct = 0>


<cfif GetMid["Mid"][1] gt ''>

	<cfset MidAtt1Pct = GetMid["Mid"][1] / PosQtr1>

	<cfif GetMidMakePct["MidMake"][1] gt ''>
		<cfset MidMake1Pct = GetMidMakePct["MidMake"][1] / GetMid["Mid"][1]>
	</cfif>
</cfif>

<cfif GetMid["Mid"][2] gt ''>
	<cfset MidAtt2Pct = GetMid["Mid"][2] / PosQtr2>
	
	<cfif GetMidMakePct["MidMake"][2] gt ''>
		<cfset MidMake2Pct = GetMidMakePct["MidMake"][2] / GetMid["Mid"][2]>
	</cfif>
	
</cfif>

<cfif GetMid["Mid"][3] gt ''>
	<cfset MidAtt3Pct = GetMid["Mid"][3] / PosQtr3>
	
	<cfif GetMidMakePct["MidMake"][3] gt ''>
		<cfset MidMake3Pct = GetMidMakePct["MidMake"][3] / GetMid["Mid"][3]>
	</cfif>	
</cfif>

<cfif GetMid["Mid"][4] gt ''>	
	<cfset MidAtt4Pct = GetMid["Mid"][4] / PosQtr4>
	<cfif GetMidMakePct["MidMake"][4] gt ''>
		<cfset MidMake4Pct = GetMidMakePct["MidMake"][4] / GetMid["Mid"][4]>
	</cfif>	
</cfif>










<cfoutput>
#PosQtr1#<br>
#FGA1Pct#<br>
#FTA1Pct#<br>
#Oreb1Pct#<br>
#DefReb1Pct#<br>
#ToFor1Pct#<br>
#FGA1Pct + FTA1Pct + Oreb1Pct + DefReb1Pct + ToFor1Pct#<br>
Short Att:#ShortAtt1Pct#<br>
Short Make Pct: #ShortMake1Pct#<br>
Mid Att:#MidAtt1Pct#<br>
Mid Make Pct: #MidMake1Pct#<br>
</cfoutput>

<p>

<cfoutput>
#PosQtr2#<br>
#FGA2Pct#<br>
#FTA2Pct#<br>
#Oreb2Pct#<br>
#DefReb2Pct#<br>
#ToFor2Pct#<br>
#FGA2Pct + FTA2Pct + Oreb2Pct + DefReb2Pct + ToFor2Pct#<br>
Short Att:#ShortAtt2Pct#<br>
Short Make Pct: #ShortMake2Pct#<br>
Mid Att:#MidAtt2Pct#<br>
Mid Make Pct: #MidMake2Pct#<br>
</cfoutput>


<p>


<cfoutput>
#PosQtr3#<br>
#FGA3Pct#<br>
#FTA3Pct#<br>
#Oreb3Pct#<br>
#DefReb3Pct#<br>
#ToFor3Pct#<br>
#FGA3Pct + FTA3Pct + Oreb3Pct + DefReb3Pct + ToFor3Pct#<br>
Short Att:#ShortAtt3Pct#<br>
Short Make Pct: #ShortMake3Pct#<br>
Mid Att:#MidAtt3Pct#<br>
Mid Make Pct: #MidMake3Pct#<br>
</cfoutput>


<p>

<cfoutput>
#PosQtr4#<br>
#FGA4Pct#<br>
#FTA4Pct#<br>
#Oreb4Pct#<br>
#DefReb4Pct#<br>
#ToFor4Pct#<br>
#FGA4Pct + FTA4Pct + Oreb4Pct + DefReb4Pct + ToFor4Pct#<br>
Short Att:#ShortAtt4Pct#<br>
Short Make Pct: #ShortMake4Pct#<br>
Mid Att:#MidAtt4Pct#<br>
Mid Make Pct: #MidMake4Pct#<br>
</cfoutput>


<p>

<cfquery datasource="NBA" name="GetSit">
	Select Team,period,AVG(TeamScore - oppscore) as Sit
	from PBPResults
	where Team = '#AwayTeam#'
	and OffDef = 'O'
	Group By Team,Period
</cfquery>

<cfdump var="#GetSit#">


<cfif x is 1>
	<cfquery datasource="Nba" name="Addit">
		UPDATE PBPGameSimPcts
		SET 
			Qtr1ScoreSit        = #GetSit["Sit"][1]#,
			Qtr2ScoreSit        = #GetSit["Sit"][2]#,
			Qtr3ScoreSit        = #GetSit["Sit"][3]#,
			Qtr4ScoreSit        = #GetSit["Sit"][4]#,
			
			Qtr1ShortShotPct    = #ShortAtt1Pct#,
			Qtr12ptShortMakePct = #ShortMake1Pct#,
			Qtr2ShortShotPct    = #ShortAtt2Pct#,
			Qtr22ptShortMakePct = #ShortMake2Pct#,
			Qtr3ShortShotPct    = #ShortAtt3Pct#,
			Qtr32ptShortMakePct = #ShortMake3Pct#,
			Qtr4ShortShotPct    = #ShortAtt4Pct#,
			Qtr42ptShortMakePct = #ShortMake4Pct#,
			
			Qtr1MidRgeShotPct    = #MidAtt1Pct#,
			Qtr12ptMidMakePct    = #MidMake1Pct#,
			Qtr2MidRgeShotPct    = #MidAtt2Pct#,
			Qtr22ptMidMakePct    = #MidMake2Pct#,
			
			Qtr3MidRgeShotPct    = #MidAtt3Pct#,
			Qtr32ptMidMakePct    = #MidMake3Pct#,
			Qtr4MidRgeShotPct    = #MidAtt4Pct#,
			Qtr42ptMidMakePct    = #MidMake4Pct#,
			
			Qtr13ptShotPct       = #LongAttPct1#,
			Qtr23ptShotPct       = #LongAttPct2#,
			Qtr33ptShotPct       = #LongAttPct3#,
			Qtr43ptShotPct       = #LongAttPct4#,
			
			Qtr13ptMakePct   = #LongMakePct1#,
			Qtr23ptMakePct   = #LongMakePct2#,
			Qtr33ptMakePct   = #LongMakePct3#,
			Qtr43ptMakePct   = #LongMakePct4#,
			
			Qtr1TOPct        = #TOPct1#,
			Qtr2TOPct        = #TOPct2#,
			Qtr3TOPct        = #TOPct3#,
			Qtr4TOPct        = #TOPct4#,
			
			Qtr1ORebPct    = #OReb1Pct#,
			Qtr2ORebPct    = #OReb2Pct#,
			Qtr3ORebPct    = #OReb3Pct#,
			Qtr4ORebPct    = #OReb4Pct#,

			Qtr1DefRebPct    = #DefReb1Pct#,
			Qtr2DefRebPct    = #DefReb2Pct#,
			Qtr3DefRebPct    = #DefReb3Pct#,
			Qtr4DefRebPct    = #DefReb4Pct#,
		
		    PACE = 	QTR1POSS + QTR2POSS + QTR3POSS + QTR4POSS		
		Where Gametime = '#gametime#'
		and Team = '#storeteam#'
        and OffDef='O'		
	</cfquery>	
	

		<cfquery datasource="Nba" name="Addit">
		UPDATE PBPGameSimPcts
		SET 
			Qtr1ScoreSit        = #GetSit["Sit"][1]#,
			Qtr2ScoreSit        = #GetSit["Sit"][2]#,
			Qtr3ScoreSit        = #GetSit["Sit"][3]#,
			Qtr4ScoreSit        = #GetSit["Sit"][4]#,
			
			Qtr1ShortShotPct    = #ShortAtt1Pct#,
			Qtr12ptShortMakePct = #ShortMake1Pct#,
			Qtr2ShortShotPct    = #ShortAtt2Pct#,
			Qtr22ptShortMakePct = #ShortMake2Pct#,
			Qtr3ShortShotPct    = #ShortAtt3Pct#,
			Qtr32ptShortMakePct = #ShortMake3Pct#,
			Qtr4ShortShotPct    = #ShortAtt4Pct#,
			Qtr42ptShortMakePct = #ShortMake4Pct#,
			
			Qtr1MidRgeShotPct    = #MidAtt1Pct#,
			Qtr12ptMidMakePct    = #MidMake1Pct#,
			Qtr2MidRgeShotPct    = #MidAtt2Pct#,
			Qtr22ptMidMakePct    = #MidMake2Pct#,
			
			Qtr3MidRgeShotPct    = #MidAtt3Pct#,
			Qtr32ptMidMakePct    = #MidMake3Pct#,
			Qtr4MidRgeShotPct    = #MidAtt4Pct#,
			Qtr42ptMidMakePct    = #MidMake4Pct#,
			
			Qtr13ptShotPct       = #LongAttPct1#,
			Qtr23ptShotPct       = #LongAttPct2#,
			Qtr33ptShotPct       = #LongAttPct3#,
			Qtr43ptShotPct       = #LongAttPct4#,
			
			Qtr13ptMakePct   = #LongMakePct1#,
			Qtr23ptMakePct   = #LongMakePct2#,
			Qtr33ptMakePct   = #LongMakePct3#,
			Qtr43ptMakePct   = #LongMakePct4#,
			
			Qtr1TOPct        = #TOPct1#,
			Qtr2TOPct        = #TOPct2#,
			Qtr3TOPct        = #TOPct3#,
			Qtr4TOPct        = #TOPct4#,
			
			Qtr1ORebPct    = #OReb1Pct#,
			Qtr2ORebPct    = #OReb2Pct#,
			Qtr3ORebPct    = #OReb3Pct#,
			Qtr4ORebPct    = #OReb4Pct#,

			Qtr1DefRebPct    = #DefReb1Pct#,
			Qtr2DefRebPct    = #DefReb2Pct#,
			Qtr3DefRebPct    = #DefReb3Pct#,
			Qtr4DefRebPct    = #DefReb4Pct#,
		
		    PACE = 	QTR1POSS + QTR2POSS + QTR3POSS + QTR4POSS		
		Where Gametime = '#gametime#'
		and Team = '#oppteam#'
        and OffDef='D'		
	</cfquery>	

<cfelse>

	<cfquery datasource="Nba" name="Addit">
		UPDATE PBPGameSimPcts
		SET 
			Qtr1ScoreSit        = #GetSit["Sit"][1]#,
			Qtr2ScoreSit        = #GetSit["Sit"][2]#,
			Qtr3ScoreSit        = #GetSit["Sit"][3]#,
			Qtr4ScoreSit        = #GetSit["Sit"][4]#,
			
			Qtr1ShortShotPct    = #ShortAtt1Pct#,
			Qtr12ptShortMakePct = #ShortMake1Pct#,
			Qtr2ShortShotPct    = #ShortAtt2Pct#,
			Qtr22ptShortMakePct = #ShortMake2Pct#,
			Qtr3ShortShotPct    = #ShortAtt3Pct#,
			Qtr32ptShortMakePct = #ShortMake3Pct#,
			Qtr4ShortShotPct    = #ShortAtt4Pct#,
			Qtr42ptShortMakePct = #ShortMake4Pct#,
			
			Qtr1MidRgeShotPct    = #MidAtt1Pct#,
			Qtr12ptMidMakePct    = #MidMake1Pct#,
			Qtr2MidRgeShotPct    = #MidAtt2Pct#,
			Qtr22ptMidMakePct    = #MidMake2Pct#,
			
			Qtr3MidRgeShotPct    = #MidAtt3Pct#,
			Qtr32ptMidMakePct    = #MidMake3Pct#,
			Qtr4MidRgeShotPct    = #MidAtt4Pct#,
			Qtr42ptMidMakePct    = #MidMake4Pct#,
			
			Qtr13ptShotPct       = #LongAttPct1#,
			Qtr23ptShotPct       = #LongAttPct2#,
			Qtr33ptShotPct       = #LongAttPct3#,
			Qtr43ptShotPct       = #LongAttPct4#,
			
			Qtr13ptMakePct   = #LongMakePct1#,
			Qtr23ptMakePct   = #LongMakePct2#,
			Qtr33ptMakePct   = #LongMakePct3#,
			Qtr43ptMakePct   = #LongMakePct4#,
			
			Qtr1TOPct        = #TOPct1#,
			Qtr2TOPct        = #TOPct2#,
			Qtr3TOPct        = #TOPct3#,
			Qtr4TOPct        = #TOPct4#,
			
			Qtr1ORebPct    = #OReb1Pct#,
			Qtr2ORebPct    = #OReb2Pct#,
			Qtr3ORebPct    = #OReb3Pct#,
			Qtr4ORebPct    = #OReb4Pct#,

			Qtr1DefRebPct    = #DefReb1Pct#,
			Qtr2DefRebPct    = #DefReb2Pct#,
			Qtr3DefRebPct    = #DefReb3Pct#,
			Qtr4DefRebPct    = #DefReb4Pct#,
		
		    PACE = 	QTR1POSS + QTR2POSS + QTR3POSS + QTR4POSS		
		Where Gametime = '#gametime#'
		and Team = '#storeteam#'
        and OffDef='O'		
	</cfquery>	
	

		<cfquery datasource="Nba" name="Addit">
		UPDATE PBPGameSimPcts
		SET 
			Qtr1ScoreSit        = #GetSit["Sit"][1]#,
			Qtr2ScoreSit        = #GetSit["Sit"][2]#,
			Qtr3ScoreSit        = #GetSit["Sit"][3]#,
			Qtr4ScoreSit        = #GetSit["Sit"][4]#,
			
			Qtr1ShortShotPct    = #ShortAtt1Pct#,
			Qtr12ptShortMakePct = #ShortMake1Pct#,
			Qtr2ShortShotPct    = #ShortAtt2Pct#,
			Qtr22ptShortMakePct = #ShortMake2Pct#,
			Qtr3ShortShotPct    = #ShortAtt3Pct#,
			Qtr32ptShortMakePct = #ShortMake3Pct#,
			Qtr4ShortShotPct    = #ShortAtt4Pct#,
			Qtr42ptShortMakePct = #ShortMake4Pct#,
			
			Qtr1MidRgeShotPct    = #MidAtt1Pct#,
			Qtr12ptMidMakePct    = #MidMake1Pct#,
			Qtr2MidRgeShotPct    = #MidAtt2Pct#,
			Qtr22ptMidMakePct    = #MidMake2Pct#,
			
			Qtr3MidRgeShotPct    = #MidAtt3Pct#,
			Qtr32ptMidMakePct    = #MidMake3Pct#,
			Qtr4MidRgeShotPct    = #MidAtt4Pct#,
			Qtr42ptMidMakePct    = #MidMake4Pct#,
			
			Qtr13ptShotPct       = #LongAttPct1#,
			Qtr23ptShotPct       = #LongAttPct2#,
			Qtr33ptShotPct       = #LongAttPct3#,
			Qtr43ptShotPct       = #LongAttPct4#,
			
			Qtr13ptMakePct   = #LongMakePct1#,
			Qtr23ptMakePct   = #LongMakePct2#,
			Qtr33ptMakePct   = #LongMakePct3#,
			Qtr43ptMakePct   = #LongMakePct4#,
			
			Qtr1TOPct        = #TOPct1#,
			Qtr2TOPct        = #TOPct2#,
			Qtr3TOPct        = #TOPct3#,
			Qtr4TOPct        = #TOPct4#,
			
			Qtr1ORebPct    = #OReb1Pct#,
			Qtr2ORebPct    = #OReb2Pct#,
			Qtr3ORebPct    = #OReb3Pct#,
			Qtr4ORebPct    = #OReb4Pct#,

			Qtr1DefRebPct    = #DefReb1Pct#,
			Qtr2DefRebPct    = #DefReb2Pct#,
			Qtr3DefRebPct    = #DefReb3Pct#,
			Qtr4DefRebPct    = #DefReb4Pct#,
		
		    PACE = 	QTR1POSS + QTR2POSS + QTR3POSS + QTR4POSS		
		Where Gametime = '#gametime#'
		and Team = '#oppteam#'
        and OffDef='D'		
	</cfquery>	





</cfif>	
	
	
	
	
</cfloop>	
<cfabort>



























<cfoutput>
#PosQtr2#<br>
#PosQtr3#<br>
#PosQtr4#<br>
#PosQtr1 + PosQtr2 + PosQtr3 + PosQtr4#<br>
</cfoutput>





<cfquery datasource="NBA" name="GetFGA">
Select Team,period,count(*) as fga
from PBPResults
where ShotType = 'SHOT' 
and Team = '#HomeTeam#'
and OffDef = 'O'
Group By Team,Period
</cfquery>

FTA
<cfquery datasource="NBA" name="GetFTA">
Select Team,period,count(*) as fta
from PBPResults
where ShotType = 'FTA'
and Team = '#HomeTeam#'
and OffDef = 'O' 
Group By Team,Period
</cfquery>

Off Reb - Remove any rebounds from missed ft
<cfquery datasource="NBA" name="GetOffReb">
Select Team,period,count(*) as OffReb
from PBPResults
where ShotType = 'REBOUND' 
and PlayType = 'OFFREB'
and Team = '#HomeTeam#'
and OffDef = 'O'
and id not in
(
Select Id from PBPResults where Playtype='OFFREB' and 
	ID - 2 IN (Select ID from PBPResults Where PlayType='FTMISS' and OffDef='O' and Team='#hometeam#')
)
Group By Team,Period
</cfquery>

Def Reb
<cfquery datasource="NBA" name="GetDefReb">
Select Team,period,count(*) as DefReb
from PBPResults
where ShotType = 'REBOUND' 
and PlayType = 'DEFREB'
and Team = '#HomeTeam#'
and OffDef = 'D'
Group By Team,Period
</cfquery>

Turnovers
<cfquery datasource="NBA" name="GetOffTurnovers">
Select Team,period,count(*) as oTurnovers
from PBPResults
where ShotType = 'TURNOVER'
and Team = '#HomeTeam#'
and OffDef = 'O'
Group By Team,Period
</cfquery>

Turnovers
<cfquery datasource="NBA" name="GetDefTurnovers">
Select Team,period,count(*) as dTurnovers
from PBPResults
where ShotType = 'TURNOVER'
and Team = '#HomeTeam#'
and OffDef = 'D'
Group By Team,Period
</cfquery>



<cfset PosQtr1 = GetFGA["fga"][1] + GetFTA["fta"][1] + GetOffReb["OffReb"][1] + GetDefReb["DefReb"][1] + GetDefTurnovers["DTurnovers"][1] >
<cfset PosQtr2 = GetFGA["fga"][2] + GetFTA["fta"][2] + GetOffReb["OffReb"][2] + GetDefReb["DefReb"][2] + GetDefTurnovers["DTurnovers"][2] >
<cfset PosQtr3 = GetFGA["fga"][3] + GetFTA["fta"][3] + GetOffReb["OffReb"][3] + GetDefReb["DefReb"][3] + GetDefTurnovers["DTurnovers"][3] >
<cfset PosQtr4 = GetFGA["fga"][4] + GetFTA["fta"][4] + GetOffReb["OffReb"][4] + GetDefReb["DefReb"][4] + GetDefTurnovers["DTurnovers"][4] >
<cfset TotPoss = PosQtr1 + PosQtr2 + PosQtr3 + PosQtr4>


<cfset FGA1Pct = GetFGA["fga"][1] / PosQtr1>
<cfset FGA2Pct = GetFGA["fga"][2] / PosQtr2>
<cfset FGA3Pct = GetFGA["fga"][3] / PosQtr3>
<cfset FGA4Pct = GetFGA["fga"][4] / PosQtr4>

<cfset FTA1Pct = GetFTA["fta"][1] / PosQtr1>
<cfset FTA2Pct = GetFTA["fta"][2] / PosQtr2>
<cfset FTA3Pct = GetFTA["fta"][3] / PosQtr3>
<cfset FTA4Pct = GetFTA["fta"][4] / PosQtr4>

<cfset Oreb1Pct = GetOffReb["OffReb"][1] / PosQtr1>
<cfset Oreb2Pct = GetOffReb["OffReb"][2] / PosQtr2>
<cfset Oreb3Pct = GetOffReb["OffReb"][3] / PosQtr3>
<cfset Oreb4Pct = GetOffReb["OffReb"][4] / PosQtr4>

<cfset DefReb1Pct = GetDefReb["DefReb"][1] / PosQtr1>
<cfset DefReb2Pct = GetDefReb["DefReb"][2] / PosQtr2>
<cfset DefReb3Pct = GetDefReb["DefReb"][3] / PosQtr3>
<cfset DefReb4Pct = GetDefReb["DefReb"][4] / PosQtr4>

<cfset TOFor1Pct = GetDefTurnovers["DTurnovers"][1] / PosQtr1>
<cfset TOFor2Pct = GetDefTurnovers["DTurnovers"][2] / PosQtr2>
<cfset TOFor3Pct = GetDefTurnovers["DTurnovers"][3] / PosQtr3>
<cfset TOFor4Pct = GetDefTurnovers["DTurnovers"][4] / PosQtr4>



*************************************************************<br>
<p>
<cfoutput>
#PosQtr1#<br>
#FGA1Pct#<br>
#FTA1Pct#<br>
#Oreb1Pct#<br>
#DefReb1Pct#<br>
#ToFor1Pct#<br>
#FGA1Pct + FTA1Pct + Oreb1Pct + DefReb1Pct + ToFor1Pct#<br>
</cfoutput>

<p>

<cfoutput>
#PosQtr2#<br>
#FGA2Pct#<br>
#FTA2Pct#<br>
#Oreb2Pct#<br>
#DefReb2Pct#<br>
#ToFor2Pct#<br>
#FGA2Pct + FTA2Pct + Oreb2Pct + DefReb2Pct + ToFor2Pct#<br>
</cfoutput>

<p>


<cfoutput>
#PosQtr3#<br>
#FGA3Pct#<br>
#FTA3Pct#<br>
#Oreb3Pct#<br>
#DefReb3Pct#<br>
#ToFor3Pct#<br>
#FGA3Pct + FTA3Pct + Oreb3Pct + DefReb3Pct + ToFor3Pct#<br>
</cfoutput>

<p>

<cfoutput>
#PosQtr4#<br>
#FGA4Pct#<br>
#FTA4Pct#<br>
#Oreb4Pct#<br>
#DefReb4Pct#<br>
#ToFor4Pct#<br>
#FGA4Pct + FTA4Pct + Oreb4Pct + DefReb4Pct + ToFor4Pct#<br>
</cfoutput>

<p>







<cfoutput>
#PosQtr2#<br>
#PosQtr3#<br>
#PosQtr4#<br>
#PosQtr1 + PosQtr2 + PosQtr3 + PosQtr4#<br>
</cfoutput>





<cfabort>
</cfif>

<cfif 1 is 1>
<cfset Gametime = "20180227">

<cfquery datasource="nba" name="GetIt">
Select * from RawPBP order by id
</cfquery>


<cfset AwayTeam = 'MIL'>
<cfset HomeTeam = 'DEN'>

<cfquery datasource="Nba" name="Addit">
		DELETE FROM PBPResults
		where Gametime = '#gametime#'
		and team = '#awayteam#'
		and opp  = '#awayteam#'
</cfquery>




<cfset AwayPosCtr = 0>
<cfset HomePosCtr = 0>

<cfset Homescore = 0>
<cfset Awayscore = 0>


<cfset x = 0>
<cfoutput query="GetIt">
<cfset x = x + 1>
<cfset thestring = GetIt["thedata"][#x#]>
<cfset thePeriod = GetIt["Quarter"][#x#]>

<cfset thesubstring = "*BEGIN*">
<p>
<cfset occurrences = ( Len(thestring) - Len(Replace(thestring,"#thesubstring#",'','all')) ) / Len(thesubstring) >
The string is #thestring#<br>

<cfset thestring = GetIt["thedata"][#x#]>
<cfset thesubstring = "*BEGIN*&nbsp;*END*">

<cfset foundthem = FINDNOCASE('#thesubstring#','#thestring#')>

<cfset occurrences = ( Len(thestring) - Len(Replace(thestring,"#thesubstring#",'','all')) ) / Len(thesubstring) >

<cfset StatsFor = HomeTeam>
<cfif Foundthem lt 50>
	<cfset StatsFor = AwayTeam>
</cfif>	

The Stats are for #StatsFor#<br>

<cfset TimeOfPlay = ParseIt('#thestring#',1,'*BEGIN*','*END*')>
The TIME OF PLAY is: #TimeOfPlay#<br>		

<cfset pt = getPlayType(thestring)>
PlayType is #pt#<br>

<cfset st = getShotType(thestring)>
Shot Type is #st#<br>

<cfset sl = 0>
<cfif st is 'SHOT'>
	<cfset sl = getShotLength(thestring)>
	Shot Length is #sl#<br>
</cfif>

<cfif st is 'SHOT' or st is 'FTA' or st is 'REBOUND' or st is 'TURNOVER'>

<cfif StatsFor is AwayTeam>
	<cfset AwayPosCtr = AwayPosCtr + 1>
	The Away Possession Ctr is #AwayPosCtr#<br>
<cfelse>
	<cfset HomePosCtr = HomePosCtr + 1>
	The Home Possession Ctr is #HomePosCtr#<br>
</cfif>
	




	<cfif pt is '2PTMADE'>
	
		<cfif StatsFor is AwayTeam>
			<cfset AwayScore = AwayScore + 2>	 
		<cfelse>
			<cfset HomeScore = HomeScore + 2>
		</cfif>

	</cfif>	
	
	<cfif pt is '3PTMADE'>
	
		<cfif StatsFor is AwayTeam>
			<cfset AwayScore = AwayScore + 3>	 
		<cfelse>
			<cfset HomeScore = HomeScore + 3>
		</cfif>

	</cfif>	
	
	<cfif pt is 'FTMADE' or pt is 'TECHFTMADE' >
	
		<cfif StatsFor is AwayTeam>
			<cfset AwayScore = AwayScore + 1>	 
		<cfelse>
			<cfset HomeScore = HomeScore + 1>
		</cfif>

	</cfif>	
	
</cfif>	
AwayScore = #AwayScore#<br>
HomeScore = #HomeScore#<br>
<cfset Sit = AwayScore - HomeScore>
The Away Score situation is: #Sit#<br>
	
<cfset nf = FINDNOCASE('not found','#pt#')>	

	
	
	
<cfif nf lt 1>	
<cfif st is 'SHOT' or st is 'REBOUND' or st is 'TURNOVER' or st is 'FOUL' or st is 'FTA'>

	<cfif st is 'FTA'>
		<cfset sl = 15>
	</cfif>	

<cfif x is 1>	
	<cfquery datasource="Nba" name="Addit">
		INSERT INTO PBPResults(Gametime,Team,opp,ha,PossessionCtr,Period,ScoreSituation,TimeOfPlay,PlayType,ShotType,ShotLength,OffDef,TeamScore,OppScore)
		VALUES('#gametime#','#AwayTeam#','#HomeTeam#','A',#AwayPosCtr#,#val(theperiod)#,#AwayScore - HomeScore#,'#TimeOfPlay#','#Pt#','#ST#',#sl#,'O',#AwayScore#,#HomeScore#)
	</cfquery>	

	<cfquery datasource="Nba" name="Addit">
		INSERT INTO PBPResults(Gametime,Team,opp,ha,PossessionCtr,Period,ScoreSituation,TimeOfPlay,PlayType,ShotType,ShotLength,OffDef,TeamScore,OppScore)
		VALUES('#gametime#','#HomeTeam#','#AwayTeam#','H',#HomePosCtr#,#val(theperiod)#,#HomeScore - AwayScore#,'#TimeOfPlay#','#Pt#','#St#',#sl#,'D',#HomeScore#,#AwayScore#)
	</cfquery>	
<cfelse>
	<cfquery datasource="Nba" name="Addit">
		INSERT INTO PBPResults(Gametime,Team,opp,ha,PossessionCtr,Period,ScoreSituation,TimeOfPlay,PlayType,ShotType,ShotLength,OffDef,TeamScore,OppScore)
		VALUES('#gametime#','#HomeTeam#','#AwayTeam#','H',#HomePosCtr#,#val(theperiod)#,#HomeScore - AwayScore#,'#TimeOfPlay#','#Pt#','#St#',#sl#,'O',#HomeScore#,#AwayScore#)
	</cfquery>

	<cfquery datasource="Nba" name="Addit">
		INSERT INTO PBPResults(Gametime,Team,opp,ha,PossessionCtr,Period,ScoreSituation,TimeOfPlay,PlayType,ShotType,ShotLength,OffDef,TeamScore,OppScore)
		VALUES('#gametime#','#AwayTeam#','#HomeTeam#','A',#AwayPosCtr#,#val(theperiod)#,#AwayScore - HomeScore#,'#TimeOfPlay#','#Pt#','#St#',#sl#,'D',#AwayScore#,#HomeScore#)
	</cfquery>	

</cfif>
</cfif>
</cfif>	
</cfoutput>
<cfabort>
</cfif>

















<cfif 1 is 2>



<cfquery datasource="Nba" name="GetRunct">
	Select Gametime
	from NBAGameTime
</cfquery>

<cfset GameTime = GetRunct.GameTime>

<cfset Gametime = "20180227">

<cfquery datasource="nba" name="addit">
Delete from RawPBP
</cfquery>
	
 
<cfquery name="GetSpds" datasource="nba" >
SELECT *
FROM nbaschedule
where trim(GAMETIME) = '#GAMETIME#'
</cfquery>
 
<cfloop query="Getspds">

	<cfset myfav      = "#Getspds.fav#">
	<cfset myund      = "#GetSpds.und#">
	<cfset ha         = "#GetSpds.ha#">
	<cfset spd        = "#GetSpds.spd#">
 	<cfset GameTime   = "#Getspds.GameTime#">
	
	<cfoutput>
	#myfav#.....#myund#<br>	
	</cfoutput>		
		
	<cfif ha is 'H'>
		<cfset HomeTeam   = myfav>
		<cfset AwayTeam   = myUnd>
		
		
	<cfelse>
		<cfset HomeTeam   = myund>
		<cfset AwayTeam   = myfav>
	</cfif>

	<cfif hometeam is 'BKN' >
		<cfset hometeam = 'BRK'>
	</cfif>
	
	<cfif hometeam is 'PHX' >
		<cfset hometeam = 'PHO'>
	</cfif>

	<cfif hometeam is 'CHA' >
		<cfset hometeam = 'CHO'>
	</cfif>


	<cfif awayteam is 'BKN' >
		<cfset awayteam = 'BRK'>
	</cfif>
	
	<cfif awayteam is 'PHX' >
		<cfset awayteam = 'PHO'>
	</cfif>

	<cfif awayteam is 'CHA' >
		<cfset awayteam = 'CHO'>
	</cfif>

	<cfset myurl = 'http://www.basketball-reference.com/boxscores/' & '#gametime#' & '0' & '#hometeam#.html'>
	<cfset myurl = 'http://127.0.0.1:8500/NBACode/NBAPBP.html'>

	<cfoutput>
	#myurl#<br>	
	<cfhttp url="#myurl#" method="GET" resolveurl="false">
	</cfhttp>
	</cfoutput>



	<cfset thepage = '#cfhttp.filecontent#'>


<cfset PlayCt   = 0>
<cfset myStruct = StructNew()>
<cfset done     = "N">


<!--- Find Main Lookup tag --->
<cfset LookFor  = 'End of 1st quarter'> 
<cfset startpos = 1>
<cfset EndOfFirstQtr = FindStringInPage('#thepage#','#LookFor#',#startpos#)>

<cfset LookFor  = 'End of 2nd quarter'> 
<cfset startpos = 1>
<cfset EndOfSecondQtr = FindStringInPage('#thepage#','#LookFor#',#startpos#)>

<cfset LookFor  = 'End of 3rd quarter'> 
<cfset startpos = 1>
<cfset EndOfThirdQtr = FindStringInPage('#thepage#','#LookFor#',#startpos#)>

<cfset LookFor  = 'End of 4th quarter'> 
<cfset startpos = 1>
<cfset EndOfFourthQtr = FindStringInPage('#thepage#','#LookFor#',#startpos#)>

<cfset LookFor  = 'Start of 1st quarter'> 
<cfset startpos = 1>
<cfset LookForFirstQtr = FindStringInPage('#thepage#','#LookFor#',#startpos#)>
<cfset Quarter = 1>

<cfset AwayScore = 0>
<cfset HomeScore = 0>

<cfoutput>
*************************************<br>
#EndOfFirstQtr#<br>
#EndOfSecondQtr#<br>
#EndOfThirdQtr#<br>
#EndOfFourthQtr#<br>
*************************************<br>
</cfoutput>

<cfif LookForFirstQtr gt 0> 

	<cfoutput>
	LookForPosition found at pos #LookForFirstQtr#
	</cfoutput>

<cfelse>
	<cfset done = true>
</cfif>


<cfset aTR = ArrayNew(1)>
<cfset aTD = ArrayNew(2)>
<cfset rowct = 0>
<cfset LookForPosition = LookForFirstQtr + 1>
<cfset startpos         = LookForPosition>
<!--- Loop thru all the rows --->
<cfset Done = false>

<!--- Return all data from within the TR --->
		<cfset thepage = replace('#thepage#','<td','*BEGIN*','all')>
		<cfset thepage = replace('#thepage#','</td>','*END*','all')>

		
		
		
<cfset Quarter = 0>		
<cfset LastTOP = 0>

<cfloop condition = "not done">

	<cfset TOP = VAL(ParseIt('#thepage#',#StartPos#,'*BEGIN*>','*END*'))>
	<cfif TOP gt LastTOP>
		<cfset Quarter = Quarter + 1>
	</cfif>
	<cfset LastTOP = TOP>
	
	<cfset LeftSideString   = '<tr>'>
	<cfset RightSideString  = '</tr>'>
	
	<cfset LookForPosition  = FindStringInPage('#thepage#','#LeftSideString#',#startpos#)>

	<p>	
	<cfoutput>
	Starting looking at #LookForPosition#....startpos = #startpos#<br>
	Checking #TOP# versus #LastTOP#
	</cfoutput>
	<p>
	
	<cfif LookForPosition gt 0>

		<cfset rowct = rowct + 1>
		
		
		<cfset myval = ParseIt('#thepage#',#StartPos#,'#LeftSideString#','#RightSideString#')>
		
		<cfoutput>
		The value to save is: #myval#<br>
		</cfoutput>

		
		<cfset myval = replace('#myval#','*BEGIN*>','*BEGIN*','all')>

		<cfset aTR[rowct] = '#myval#'>

		<cfset NoLoad  = FINDNOCASE('Offensive rebound by team','#myval#')>
		<cfset NoLoad2 = FINDNOCASE('Defensive rebound by team','#myval#')>
				
		<cfif NoLoad lt 1>
			<cfif NoLoad2 lt 1>
				<cfquery datasource="nba" name="addit">
				Insert into RawPBP(TheData,Quarter) values ('#myval#',#Quarter#)
				</cfquery>
			</cfif>
		</cfif>
		
		
<!--- Set starting position for the next lookup --->
		<cfset startpos = LookForPosition + 1>	

	<cfelse>
		<cfset done = true>
	</cfif>	

	<cfif rowct gt 500>
		<cfset done = true>
	</cfif>

	
	
	
</cfloop>

<cfabort>
</cfloop>

**********************************************************<br>


</cfif>


<cffunction name="ParseIt" access="remote" output="yes" returntype="String">

	<cfargument name="theViewSourcePage"    type="String"  required="yes" />
	<cfargument name="startLookingPosition" type="Numeric" required="yes" />

	<cfargument name="LeftSideString"       type="String"  required="yes" />
	<cfargument name="RightSideString"      type="String"  required="yes" />
 
	<cfset posOfLeftsidestring = FINDNOCASE('#arguments.LeftSideString#','#arguments.theViewSourcePage#',#arguments.startLookingPosition#)>  
	<!---
	<cfoutput>
	posOfLeftsidestring = #posOfLeftsidestring#
	</cfoutput>
	--->
	
	<cfset LengthOfLeftSideString = LEN('#arguments.LeftSideString#')>

	<cfset posOfRightsidestring    = FINDNOCASE('#arguments.RightSideString#','#arguments.theViewSourcePage#',#posOfLeftsidestring#)>  	
	<cfset LengthOfRightSideString = LEN('#arguments.RightSideString#')>

	<!---

	<cfoutput>
	posOfRightsidestring = #posOfRightsidestring#
	</cfoutput>
	--->
	
	<cfset StartParsePos = posOfLeftsidestring  + LengthOfLeftSideString>
	<cfset EndParsePos   = posOfRightsidestring>
 	<cfset LenOfParseVal = (#EndParsePos# - #StartParsePos#)>

	<!---
	
	<cfoutput>
	StartParsePos = #startparsepos#><br>
	EndParsePos   = #endparsepos#><br>
 	LenOfParseVal = #LenOfParseVal#><br>
	</cfoutput>
	--->
	
	
	<cfset parseVal = Mid('#arguments.theViewSourcePage#',#StartParsePos#,#LenOfParseVal#)>
	
	
	<cfreturn parseVal>

</cffunction>



<cffunction name="FindStringInPage" access="remote" output="yes" returntype="Numeric">

	<cfargument name="theViewSourcePage"    type="String"  required="yes" />
	<cfargument name="LookFor"              type="String"  required="yes" />
	<cfargument name="startLookingPosition" type="Numeric" required="yes" />

	<cfset FoundStringPos = FINDNOCASE('#arguments.LookFor#','#arguments.theViewSourcePage#',#arguments.startLookingPosition#)>  	

	<cfreturn #FoundStringPos# >

</cffunction>



<cffunction name="SetupVariables" access="remote" output="yes" returntype="Numeric">

	<cfargument name="theViewSourcePage"    type="String"  required="yes" />
	<cfargument name="LookFor"              type="String"  required="yes" />
	<cfargument name="startLookingPosition" type="Numeric" required="yes" />

	<cfset FoundStringPos = FINDNOCASE('#arguments.LookFor#','#arguments.theViewSourcePage#',#arguments.startLookingPosition#)>  	

	<cfreturn #FoundStringPos# >

</cffunction>



<cffunction name="getPlayType" access="remote" output="yes" returntype="String">

	<cfargument name="thePlay"    type="String"  required="yes" />
	
	<cfoutput>
	<cfset play = 'Not found - #arguments.theplay#'>
	</cfoutput>

	<cfif FINDNOCASE('makes 2-pt','#arguments.theplay#') gt 0>
		<cfset play = '2PTMADE'>
	</cfif>

	<cfif FINDNOCASE('makes 3-pt','#arguments.theplay#') gt 0>
		<cfset play = '3PTMADE'>
	</cfif>

	<cfif FINDNOCASE('misses 2-pt','#arguments.theplay#') gt 0>
		<cfset play = '2PTMISS'>
	</cfif>

	<cfif FINDNOCASE('misses 3-pt','#arguments.theplay#') gt 0>
		<cfset play = '3PTMISS'>
	</cfif>


	<cfif FINDNOCASE('Offensive rebound','#arguments.theplay#') gt 0>
		<cfset play = 'OFFREB'>
	</cfif>

	<cfif FINDNOCASE('Defensive rebound','#arguments.theplay#') gt 0>
		<cfset play = 'DEFREB'>
	</cfif>

	<cfif FINDNOCASE('Turnover','#arguments.theplay#') gt 0>
		<cfset play = 'TURNOVER'>
	</cfif>

	<cfif FINDNOCASE('Personal foul','#arguments.theplay#') gt 0>
		<cfset play = 'PERSONALFOUL'>
	</cfif>


	<cfif FINDNOCASE('Shooting foul','#arguments.theplay#') gt 0>
		<cfset play = 'SHOOTINGFOUL'>
	</cfif>

	<cfif FINDNOCASE('Loose ball foul','#arguments.theplay#') gt 0>
		<cfset play = 'LOOSEBALLFOUL'>
	</cfif>
	
	<cfif FINDNOCASE('Technical foul','#arguments.theplay#') gt 0>
		<cfset play = 'TECHNICALFOUL'>
	</cfif>
	
	
	<cfif FINDNOCASE('makes free throw','#arguments.theplay#') gt 0>
		<cfset play = 'FTMADE'>
	</cfif>

	<cfif FINDNOCASE('makes technical free throw','#arguments.theplay#') gt 0>
		<cfset play = 'TECHFTMADE'>
	</cfif>

	<cfif FINDNOCASE('misses technical free throw','#arguments.theplay#') gt 0>
		<cfset play = 'TECHFTMISS'>
	</cfif>

		
	<cfif FINDNOCASE('misses free throw','#arguments.theplay#') gt 0>
		<cfset play = 'FTMISS'>
	</cfif>

	<cfif FINDNOCASE('timeout','#arguments.theplay#') gt 0>
		<cfset play = 'TIMEOUT'>
	</cfif>
	
	
	<cfif FINDNOCASE('Offensive charge foul','#arguments.theplay#') gt 0>
		<cfset play = 'CHARGEFOUL'>
	</cfif>
	
	
	<cfif FINDNOCASE('Personal block foul','#arguments.theplay#') gt 0>
		<cfset play = 'BLOCKFOUL'>
	</cfif>
	

	<cfreturn '#play#' >

</cffunction>


<cffunction name="getShotType" access="remote" output="yes" returntype="String">

	<cfargument name="thePlay"    type="String"  required="yes" />
	
	<cfoutput>
	<cfset play = 'Not Found - #arguments.theplay#'>
	</cfoutput>

	<cfif FINDNOCASE('makes 2-pt','#arguments.theplay#') gt 0>
		<cfset play = 'SHOT'>
	</cfif>

	<cfif FINDNOCASE('makes 3-pt','#arguments.theplay#') gt 0>
		<cfset play = 'SHOT'>
	</cfif>

	<cfif FINDNOCASE('misses 2-pt','#arguments.theplay#') gt 0>
		<cfset play = 'SHOT'>
	</cfif>

	<cfif FINDNOCASE('misses 3-pt','#arguments.theplay#') gt 0>
		<cfset play = 'SHOT'>
	</cfif>


	<cfif FINDNOCASE('Offensive rebound','#arguments.theplay#') gt 0>
		<cfset play = 'REBOUND'>
	</cfif>

	<cfif FINDNOCASE('Defensive rebound','#arguments.theplay#') gt 0>
		<cfset play = 'REBOUND'>
	</cfif>

	<cfif FINDNOCASE('Turnover','#arguments.theplay#') gt 0>
		<cfset play = 'TURNOVER'>
	</cfif>

	<cfif FINDNOCASE('Personal foul','#arguments.theplay#') gt 0>
		<cfset play = 'FOUL'>
	</cfif>


	<cfif FINDNOCASE('Shooting foul','#arguments.theplay#') gt 0>
		<cfset play = 'FOUL'>
	</cfif>

	<cfif FINDNOCASE('Loose ball foul','#arguments.theplay#') gt 0>
		<cfset play = 'FOUL'>
	</cfif>
	
	<cfif FINDNOCASE('Technical foul','#arguments.theplay#') gt 0>
		<cfset play = 'FOUL'>
	</cfif>
	
	
	<cfif FINDNOCASE('makes free throw','#arguments.theplay#') gt 0>
		<cfset play = 'FTA'>
	</cfif>

	<cfif FINDNOCASE('makes technical free throw','#arguments.theplay#') gt 0>
		<cfset play = 'FTA'>
	</cfif>

	<cfif FINDNOCASE('misses technical free throw','#arguments.theplay#') gt 0>
		<cfset play = 'FTA'>
	</cfif>

		
	<cfif FINDNOCASE('misses free throw','#arguments.theplay#') gt 0>
		<cfset play = 'FTA'>
	</cfif>

	<cfif FINDNOCASE('timeout','#arguments.theplay#') gt 0>
		<cfset play = 'TIMEOUT'>
	</cfif>
	
	
	<cfif FINDNOCASE('Offensive charge foul','#arguments.theplay#') gt 0>
		<cfset play = 'FOUL'>
	</cfif>
	
	
	<cfif FINDNOCASE('Personal block foul','#arguments.theplay#') gt 0>
		<cfset play = 'FOUL'>
	</cfif>
	
	<cfreturn '#play#' >

</cffunction>



<cffunction name="getShotLength" access="remote" output="yes" returntype="String">
	<cfargument name="thePlay"    type="String"  required="yes" />

	<cfset startpos = 1>
	<cfset los = '-1'>

	<cfset LookForPosition  = FindStringInPage('#arguments.theplay#','at rim',#startpos#)>
	<cfif LookForPosition gt 0> 
		<cfset los = '0'>		
	<cfelse>

		<cfset LeftSideString   = 'from'>
		<cfset RightSideString  = 'ft'>
		<cfset startpos         = 1>
		<cfset LookForPosition  = FindStringInPage('#arguments.theplay#','#RightSideString#',#startpos#)>


		<cfif LookForPosition gt 0>
			<cfset los = ParseIt('#arguments.theplay#',#StartPos#,'#LeftSideString#','#RightSideString#')>
		</cfif>
	</cfif>

	<cfreturn '#los#' >

</cffunction>































