<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

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

<cfset variables.gametime = '#GetRunCt.GameTime#'>

<cfquery datasource="nbaschedule" name="Getspds">
Select *
from nbaschedule
where GameTime = '#variables.gametime#'
 </cfquery>

 <cfoutput>
 The count is #Getspds.recordcount#, #variables.gametime#
 </cfoutput>
 
<cfset gamect = 0>
<cfloop query="GetSpds">


here!!
	<cfset fav           = '#GetSpds.Fav#'> 
	<cfset und           = '#GetSpds.Und#'>
	<cfset ha            = '#GetSpds.ha#'>
	<cfset spd           = #GetSpds.spd#>
	<cfset ou          = #GetSpds.ou#>  

<cfquery datasource="Nba" name="GetGAPFav">
	Select FTAtt
	from GAP
	Where Team = '#Fav#'
</cfquery>

<cfquery datasource="Nba" name="GetGAPUnd">
	Select FTAtt
	from GAP
	Where Team = '#Und#'
</cfquery>

<cfquery datasource="Nba" name="GetGAP">
	Select Team
	from GAP
	Where FTAtt = '#GetGAPUnd.FTAtt#'
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


<cfoutput query="TotalScenarios">
#team#,#opp#,#spd#,fav=#fav#<br>
</cfoutput>


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
	from GAP
	Where FTAtt = '#GetGAPFav.FTAtt#'
</cfquery>

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
	FavScore,
	UndScore,
	Pct,
	Systemid,
	ou,
	oupick,
	oupct,
	ouscore
	)
	values
	(
	'#variables.gametime#',
	'#fav#',
	'#ha#',
	#spd#,
	'#und#',
	'#ourpick#',
	#Numberformat(FavPredPs,'999.99')#,
	#Numberformat(UndPredPs,'999.99')#,
	#ourrat#,
	'GAPFTAtt',
	#ou#,
	'#ourtotalpick#',
	#ourtotrat#,
	#Numberformat(PredTot,'999.99')#
	)
	</cfquery>



</cfoutput>
</cfloop>

<!--- <cfquery datasource="Nba" name="GetRunct">
	Update NbaGameTime
	Set Gametime = '#myDate#',
	RunCt = 0
</cfquery> --->

<!---  
<cfscript>
function gap(myteamarr,myteam,gHigh,aHigh,pHigh)
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
--->
</body>
</html>
