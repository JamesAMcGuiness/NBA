<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>
<cfset mygametime = '20080128'>
<cfset SystemId        = 'PowerSystem'>

<cfquery datasource="nbapicks" name="Addit">
	Delete from NBAPicks
	where SystemId = '#SystemId#'
	and Gametime = '#myGametime#'
</cfquery>

<cfquery datasource="nbaschedule" name="Getspds">
Select *
from nbaschedule
where GameTime = '#mygametime#'
</cfquery>

<cfloop query="GetSpds">

	<cfset fav           = '#GetSpds.Fav#'> 
	<cfset und           = '#GetSpds.Und#'>
	<cfset ha            = '#GetSpds.ha#'>
	<cfset Client.spread = #GetSpds.spd#>

	Show What the Favorite has done against allt the opponents....<br>
	<cfquery  datasource="nbastats" name="GetAdv">
	Select 
		opp.Team,Avg(opp.dps) as oppdps,
		f.ps,
	    f.ps - Avg(opp.dps) as OffPower
 	from nbadata f, nbadata opp
  	where 
		f.Team       = '#fav#'
	and opp.opp      = f.team
	and f.GameTime   < '#myGameTime#'
	and opp.GameTime < '#myGameTime#'
	group by opp.Team
	order by OffPower desc
	</cfquery>

	<cfset ct = 0>
	<cfset AvgPts = 0>
	<cfoutput query="GetAdv">
	<!--- #team#,#ps#,#oppdps#,#OffPower#<br> --->
		<cfset AvgPts = AvgPts + OffPower>
		<cfset ct = ct + 1>
	</cfoutput>
	
	<cfset AvgFavOffPow = AvgPts/ct>
	
	<cfoutput>#fav#:#AvgFavOffPow#<br></cfoutput>
----------------------------------------------------------------------------------------------------------------------<br>
	Show What the Underdog has done against allt the opponents....<br>
	<cfquery  datasource="nbastats" name="GetAdv">
	Select 
		opp.Team,Avg(opp.dps) as oppdps,
		f.ps,
	    f.ps - Avg(opp.dps) as OffPower
 	from nbadata f, nbadata opp
  	where 
		f.Team       = '#und#'
	and opp.opp      = f.team
	and f.GameTime   < '#myGameTime#'
	and opp.GameTime < '#myGameTime#'
	group by opp.Team
	order by OffPower desc
	</cfquery>

	<cfset ct = 0>
	<cfset AvgPts = 0>
	<cfoutput query="GetAdv">
	<!--- #team#,#ps#,#oppdps#,#OffPower#<br> --->
		<cfset AvgPts = AvgPts + OffPower>
		<cfset ct = ct + 1>
	</cfoutput>
	
	<cfset AvgUndOffPow = AvgPts/ct>
	
	<cfoutput>#und#:#AvgUndOffPow#<br></cfoutput>
	***************************************************************************************************************<br>



















	<cfquery  datasource="nbastats" name="GetAdv">
	Select 
	    Avg(opp.ps) - f.ps as DefPower
 	from nbadata f, nbadata opp
  	where 
		f.Team       = '#fav#'
	and opp.opp      = f.team
	and f.GameTime   < '#myGameTime#'
	and opp.GameTime < '#myGameTime#'
	group by opp.Team
	
	</cfquery>

	<cfset ct = 0>
	<cfset AvgPts = 0>
	<cfoutput query="GetAdv">
	<!--- #team#,#ps#,#oppdps#,#OffPower#<br> --->
		<cfset AvgPts = AvgPts + DefPower>
		<cfset ct = ct + 1>
	</cfoutput>
	
	<cfset AvgFavDefPow = AvgPts/ct>
	
	<cfoutput>#fav#:#AvgFavDefPow#<br></cfoutput>
----------------------------------------------------------------------------------------------------------------------<br>


	Show What the Underdog has done against allt the opponents....<br>
	<cfquery  datasource="nbastats" name="GetAdv">
	Select 
	    Avg(opp.ps) - f.ps as DefPower
 	from nbadata f, nbadata opp
  	where 
		f.Team       = '#und#'
	and opp.opp      = f.team
	and f.GameTime   < '#myGameTime#'
	and opp.GameTime < '#myGameTime#'
	group by opp.Team
	
	</cfquery>

	<cfset ct = 0>
	<cfset AvgPts = 0>
	<cfoutput query="GetAdv">
	<!--- #team#,#ps#,#oppdps#,#OffPower#<br> --->
		<cfset AvgPts = AvgPts + DefPower>
		<cfset ct = ct + 1>
	</cfoutput>
	
	<cfset AvgUndDefPow = AvgPts/ct>
	
	<cfoutput>#und#:#AvgUndDefPow#<br></cfoutput>
	***************************************************************************************************************<br>
	
	<cfset TotalFavPow = AvgFavOffPow + AvgFavDefPow>
	<cfset TotalUndPow = AvgUndOffPow + AvgUndDefPow>
	----------------------------------------------------------------------------------------------------------------<br>
		<cfif Ha is 'H'>
			<cfset PredFavScore = TotalFavPow + 2.5>
			
		<cfelse>
			<cfset PredFavScore = TotalFavPow - 2.5>
		</cfif>	
			
		<cfset PredMOV = PredFavScore>
						
		<cfif PredMOV gt #Client.spread#>
				<cfset Pick = fav>
				<cfset Rating = PredMOV - Client.spread>
		<cfelse>
			<cfif PredMOV lt 0>
				<cfset Pick = und>
				<cfset Rating = Client.spread - PredMOV>
			<cfelse>
				<cfset Pick = und>
				<cfset Rating = Client.spread - PredMOV>
			</cfif>
		</cfif>
			
		<cfoutput>Pick for #fav# vs. #und# is #pick# with rating of #Rating#<br></cfoutput>
	
	<cfquery datasource="nbapicks" name="Addit">
		Insert into NBAPicks
		(
		SystemId,
		Gametime,
		Fav,
		Ha,
		Spd,
		Und,
		Pick,
		Pct)
		Values
		(
		'#SystemId#',
		'#MYGametime#',
		'#fav#',
		'#HA#',
		#Client.spread#,
		'#und#',
		'#pick#',
		#(rating)#
		)
	</cfquery>
	
</cfloop>	



</body>
</html>
