<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>
<!--- <cfinclude template="CreatePowerMinutes.cfm"> --->

<cfquery datasource="Nba" name="GetRunct">
	Select RunCt,Gametime
	from NBAGameTime
</cfquery>

<cfset yyyy = left(GetRunCt.gametime,4)>
<cfset mm   = mid(GetRunCt.gametime,5,2)>
<cfset dd   = right(GetRunCt.gametime,2)>
<cfset mydate = #Dateformat(DateAdd("d",1,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>

<cfoutput>
#mydate#<br>
</cfoutput>


<cfif GetRunct.recordcount ge 10>
<!--- 	<cfquery datasource="Nba" name="GetRunct">
	Update NbaGameTime
	Set Gametime = '#myDate#',
	RunCt = 0
	</cfquery>
 --->	
	<cfset variables.gametime = '#myDate#'>
	
<cfelse>

	<cfset variables.gametime = '#GetRunCt.GameTime#'>
</cfif>
	
<cfloop index="ii" from="1" to="20">

<cfset myteamarr = arraynew(1)>	

<cfif ii is 1>
	<cfset mystat = 'Turnovers'>

	Turnovers<br>	
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(dturnovers) + Avg(oturnovers) as stat
	from power
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(dturnovers) + Avg(oturnovers) desc
	</cfquery>
	
</cfif>

<cfif ii is 2>
	<cfset mystat = 'Scoring'>
	
	Scoring<br>
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(ps + dps) as stat
	from power
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(ps + dps) desc
	</cfquery>
</cfif>
	
<cfif ii is 3>
	<cfset mystat = 'FGAtt'>
	
	FGAtt<br>
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(ofga + dfga) as stat
	from Power
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(ofga + dfga) desc
	</cfquery>
</cfif>
	
<cfif ii is 4>
	<cfset mystat = 'FGPct'>
	
	FGpct....<br>
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(ofgpct + dfgpct) as stat
	from Power
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(ofgpct + dfgpct) desc
	</cfquery>
</cfif>
	
<cfif ii is 5>
	<cfset mystat = 'Rebounding'>
	
	Rebounding...<br>
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(otreb  + dtreb) as stat
	from Power
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(otreb  + dtreb) desc
	</cfquery>
</cfif>

<cfif ii is 6>
	<cfset mystat = 'FTAtt'>
	
	FTAtt...<br>
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(ofta + dfta) as stat
	from Power
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(ofta + dfta) desc
	</cfquery>
</cfif>
	
<cfif ii is 7>
	<cfset mystat = 'TPAtt'>
	
	TPAtt...<br>
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(otpm + dtpm) as stat
	from Power
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(otpm + dtpm) desc
	</cfquery>
</cfif>


<cfif ii is 8>
	<cfset mystat = 'TPPct'>
	
	TPPct...<br>
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(otppct + dtppct) as stat
	from Power
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(otppct + dtppct) desc
	</cfquery>
</cfif>


<cfif ii is 9>
	<cfset mystat = 'ops'>
	
	
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(ps) as stat
	from Power
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(ps) desc
	</cfquery>
</cfif>
	
<cfif ii is 10>
	<cfset mystat = 'dps'>
		
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(dps) as stat
	from Power
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(dps) desc
	</cfquery>
</cfif>	
	
<cfif ii is 11>
	<cfset mystat = 'ofgpct'>
		
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(ofgpct) as stat
	from Power
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(ofgpct) desc
	</cfquery>
</cfif>	
	
<cfif ii is 12>
	<cfset mystat = 'dfgpct'>
		
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(dfgpct) as stat
	from Power
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(dfgpct) desc
	</cfquery>
</cfif>	
	
<cfif ii is 13>
	<cfset mystat = 'orebounding'>
		
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(oReb) as stat
	from Power
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(oReb) desc
	</cfquery>
</cfif>	
	
<cfif ii is 14>
	<cfset mystat = 'drebounding'>
		
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(dReb) as stat
	from Power
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(dReb) desc
	</cfquery>
</cfif>	
	
	
<cfif ii is 15>
	<cfset mystat = 'ofta'>
		
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(ofta) as stat
	from Power
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(ofta) desc
	</cfquery>
</cfif>	
	
<cfif ii is 16>
	<cfset mystat = 'dfta'>
		
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(dfta) as stat
	from Power
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(dfta) desc
	</cfquery>
</cfif>	
	
<cfif ii is 17>
	<cfset mystat = 'otppct'>
		
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(otppct) as stat
	from Power
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(otppct) desc
	</cfquery>
</cfif>	
	
<cfif ii is 18>
	<cfset mystat = 'dtppct'>
		
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(dtppct) as stat
	from Power
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(dtppct) desc
	</cfquery>
</cfif>	
	
<cfif ii is 19>
	<cfset mystat = 'oturnovers'>
		
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(oturnovers) as stat
	from Power
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(oturnovers) desc
	</cfquery>
</cfif>	
	
<cfif ii is 20>
	<cfset mystat = 'dturnovers'>
		
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(dturnovers) as stat
	from Power
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(dturnovers) desc
	</cfquery>
</cfif>	
	
	
	
	
<cfoutput query="myquery">
	<cfset  arrayappend(myteamarr,'#team#')> 
</cfoutput>


<cfoutput query="myquery">
	<cfset myRat = gappow(myteamarr,'#myquery.Team#',10,20,30)>
<!-- 	#Team#: #myrat#...#stat#<br> -->
	
	<cfquery datasource="Nba" name="checkit">
		Select * from gappower
		Where Team = '#team#'
	</cfquery>

	<cfif checkit.recordcount is 0>
		<cfquery datasource="Nba" name="changeit">
		Insert into GAPpower
		(
		team ,
		#mystat#
		)
		Values
		(
		'#team#',
		'#myrat#'
		)
		</cfquery>
	<cfelse>

	
		
		<cfquery datasource="Nba" name="changeit">
			Update GAPpower
			Set #mystat# = '#myrat#'
			Where Team = '#team#'
		</cfquery>

	</cfif>
</cfoutput>

</cfloop>



<cfquery datasource="nbaschedule" name="Getspds">
Select *
from nbaschedule
where GameTime = '#variables.gametime#'
 </cfquery>

<cfset gamect = 0>
<cfloop query="GetSpds">

	<cfset fav           = '#GetSpds.Fav#'> 
	<cfset und           = '#GetSpds.Und#'>
	<cfset ha            = '#GetSpds.ha#'>
	<cfset spd           = #GetSpds.spd#>
	<cfset ou          = #GetSpds.ou#>  

<cfquery datasource="Nba" name="GetGAPFav">
	Select Scoring
	from GAPpower
	Where Team = '#Fav#'
</cfquery>

<cfquery datasource="Nba" name="GetGAPUnd">
	Select Scoring
	from GAPpower
	Where Team = '#Und#'
</cfquery>

<cfquery datasource="Nba" name="GetGAP">
	Select Team
	from GAPpower
	Where scoring = '#GetGAPUnd.scoring#'
</cfquery>


<cfquery datasource="Nbastats" name="sc">
	Select Avg(ps) ps, Avg(dps) dps, Avg(ps + dps) as aps 
	from NBAData
	Where opp in (#QuotedValueList(GetGap.Team)#)
	and team='#fav#'
	and gametime < '#variables.gametime#'
</cfquery>

<cfquery datasource="Nbastats" name="TotalScenarios">
	Select *
	from NBAData d, NBASchedule s
	Where d.opp in (#QuotedValueList(GetGap.Team)#)
	and d.team='#fav#'
	and s.fav = '#fav#'
	and s.spd >= #spd - 2#
	and s.spd <= #spd + 2#
	and s.und = d.opp
	and s.gametime = d.gametime
	and s.gametime < '#variables.gametime#'
	order by d.gametime
</cfquery>


<!-- <cfoutput query="TotalScenarios">
#team#,#opp#,#spd#,fav=#fav#<br>
</cfoutput>
 -->

<cfquery datasource="Nbastats" name="TotalCoverd">
	Select *
	from NBAData d, NBASchedule s
	Where d.opp in (#QuotedValueList(GetGap.Team)#)
	and d.team='#fav#'
	and d.ps-d.dps > #spd#
	and s.fav = '#fav#'
	and s.spd >= #spd - 2#
	and s.spd <= #spd + 2#
	and s.und = d.opp
	and s.gametime = d.gametime
	and s.gametime < '#variables.gametime#'
</cfquery>

<cfquery datasource="Nbastats" name="TotalouScenarios">
	Select *
	from NBAData d
	Where d.opp in (#QuotedValueList(GetGap.Team)#)
	and d.team='#fav#'
	and d.gametime < '#variables.gametime#'
</cfquery>

<cfquery datasource="Nbastats" name="TotalOverCoverd">
	Select *
	from NBAData d
	Where d.opp in (#QuotedValueList(GetGap.Team)#)
	and d.team='#fav#'
	and d.ps + d.dps > #ou#
	and d.gametime < '#variables.gametime#'
</cfquery>


<cfset FavAvgPS  = sc.ps>
<cfset FavAvgDPS = sc.dps>

<!--- <cfoutput>
#fav# Avg PS= #sc.ps#, Avg DPS= #sc.dps#<br>
#fav# covered this number #numberformat(100*(totalcoverd.recordcount/totalscenarios.recordcount),'99.9')#<br>
#fav# covered OVER #numberformat(100*(totalovercoverd.recordcount/totalouscenarios.recordcount),'99.9')#<br>
</cfoutput> --->

<cfquery datasource="Nba" name="GetGAP">
	Select Team
	from GAPpower
	Where scoring = '#GetGAPFav.scoring#'
</cfquery>

<cfif GetGAP.recordcount neq 0>

<cfquery datasource="Nbastats" name="TotalScenarios">
	Select *
	from NBAData d, NBASchedule s
	Where d.opp in (#QuotedValueList(GetGap.Team)#)
	and d.team='#und#'
	and s.und = '#und#'
	and s.spd >= #spd - 2#
	and s.spd <= #spd + 2#
	and s.fav = d.opp
	and s.gametime = d.gametime
	and s.gametime < '#variables.gametime#'	
	order by d.gametime
</cfquery>

<cfquery datasource="Nbastats" name="TotalCoverd">
	Select *
	from NBAData d, NBASchedule s
	Where d.opp in (#QuotedValueList(GetGap.Team)#)
	and d.team='#und#'
	and s.und = '#und#'
	and s.spd >= #spd - 2#
	and s.spd <= #spd + 2#
	and s.fav = d.opp
	and (d.ps - d.dps > 0 or d.dps - d.ps < #spd#)
	and s.gametime = d.gametime
	and s.gametime < '#variables.gametime#'
	order by d.gametime
</cfquery>


<cfquery datasource="Nbastats" name="TotalouScenarios">
	Select *
	from NBAData d
	Where d.opp in (#QuotedValueList(GetGap.Team)#)
	and d.team='#und#'
	and d.gametime < '#variables.gametime#'
</cfquery>


<cfquery datasource="Nbastats" name="TotalOverCoverd">
	Select *
	from NBAData d
	Where d.opp in (#QuotedValueList(GetGap.Team)#)
	and d.team='#und#'
	and d.ps + d.dps > #ou#
	and d.gametime < '#variables.gametime#'
</cfquery>


<cfquery datasource="Nbastats" name="Sc">
	Select Avg(ps) ps, Avg(dps) dps, Avg(ps + dps) as aps
	from NBAData
	Where Team = '#und#'
	and opp in (#QuotedValueList(GetGap.Team)#)
	and gametime < '#variables.gametime#'
</cfquery>

<cfoutput>
<br>
<!--- #und# Avg PS= #sc.ps#, Avg DPS= #sc.dps#<br>
#und# covered this number #numberformat(100*(totalcoverd.recordcount/totalscenarios.recordcount),'99.9')#<br>
#und# covered OVER #numberformat(100*(totalovercoverd.recordcount/totalouscenarios.recordcount),'99.9')#<br>
 --->
<cfset UndAvgPS  = sc.ps>
<cfset UndAvgDPS = sc.dps>

<cfset FavPredPs = (FavAvgPS + UndAvgDPS)/2>
<cfset UndPredPs = (UndAvgPS + FavAvgDPS)/2>

<cfif ha is 'H'>
	<cfset FavPredPs = FavPredPS + 3.5>
<cfelse>
	<cfset UndPredPs = UndPredPS + 3.5>
</cfif>

<cfset ourpick = "P">
<cfset ourrat  = 0>
<cfset ourtotalpick = "P">
<cfset ourtotrat = 0>
<cfset mov = FavPredPs - UndPredPs>


<cfif mov gt spd>
	<cfset ourpick = "#fav#">
	<cfset ourrat  = mov - spd>
</cfif>

<cfif mov lt spd>
	<cfset ourpick = "#und#">
	<cfset ourrat  = spd - mov>
</cfif>

<cfif mov lt 0>
	<cfset ourpick = "#und#">
	<cfset ourrat  = spd - mov>
</cfif>

<cfset PredTot = FavPredPs + UndPredPs - 3.5>
<cfif Predtot gt ou>
	<cfset ourtotalpick = "O">
	<cfset ourtotrat    = Predtot - ou>
<cfelse>
	<cfset ourtotalpick = "U">
	<cfset ourtotrat    = ou - Predtot>
</cfif>	


<br>
Final Prediction:<br>
#fav#: #Numberformat(FavPredPs,'999.99')#<br>
#und#: #Numberformat(UndPredPs,'999.99')#<br>
#fav# by #Numberformat(mov,'999.99')#<br>
Vegas Line: #fav# by #spd#<br>
Our Pick is: #ourpick# with a rating of: #ourrat#<br>

TOTAL: #Numberformat(FavPredPs + UndPredPs - 3.5,'999.99')#<br>
Our TOTAL Pick is: #ourtotalpick# with a rating of: #ourtotrat#<br>
Vegas Total: #ou#<br>

**************************************************************************

	<cfquery datasource="NBAPicks" name="AddPicks">
	Insert into NBAPicks
	(GameTime,
	Fav,
	Ha,
	Spd,
	Und,
	Pick,
	Pct,
	Systemid,
	ou,
	oupick,
	oupct
	)
	values
	(
	'#variables.gametime#',
	'#fav#',
	'#ha#',
	#spd#,
	'#und#',
	'#ourpick#',
	#ourrat#,
	'GAPPower',
	#ou#,
	'#ourtotalpick#',
	#ourtotrat#
	)
	</cfquery>



</cfoutput>
</cfif>

</cfloop>






<cfscript>
function gappow(myteamarr,myteam,gHigh,aHigh,pHigh)
{

var currentRow = 1;
for (; currentRow lte ArrayLen(myteamarr) ;)
	
	//WriteOutput(#myteamarr[currentRow]#);

	{

//	WriteOutput('....' & currentRow); 
		if (#trim(myteam)# is #trim(myteamarr[currentRow])#)
		{
		
			//WriteOutput('Yes....'); 
			if (currentRow lte gHigh)
			{
				return 'G';
			}
			
			if (currentRow lte aHigh)
			{
				return 'A';
			}
			
			if (currentRow lte pHigh)
			{
				return 'P';
			}
			
		}
		else
		{
				
		}
		currentRow = currentRow + 1;
	}	
	return 'N/A'; 
}
</cfscript>

</body>
</html>
