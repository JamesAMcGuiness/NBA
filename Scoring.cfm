<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

<cfif 1 is 1>
<cfset fav='IND'>
<cfset und='NYK'>

<cfquery datasource="nba" name="GetFavGames">
Select avg(ps) as favps from wl where team = '#fav#' and opp = '#und#' and ps <> 0 
</cfquery>

<cfquery datasource="nba" name="GetUndGames">
Select avg(ps) as undps from wl where team = '#und#' and opp = '#fav#' and ps <> 0 
</cfquery>

<cfquery datasource="nba" name="GetFavDefGames">
Select avg(dps) as favps from wl where team = '#fav#' and opp = '#und#' and dps <> 0 
</cfquery>


<cfquery datasource="nba" name="GetUndDefGames">
Select avg(dps) as undps from wl where team = '#und#' and opp = '#fav#' and dps <> 0 
</cfquery>


<cfoutput>
Fav:#(GetFavGames.favps + GetUndDefGames.undps)/2#<br>
Und:#(GetUndGames.Undps + GetFavDefGames.favps)/2#
</cfoutput>

</cfif>

<cfabort>

<cfquery datasource="Nba" >
Delete from Scoring
</cfquery>

<cfquery datasource="nba">
Delete from WL
</cfquery>

<cfquery datasource="Nba" name="GetRunct">
	Select RunCt,Gametime
	from NBAGameTime
</cfquery>

<cfset variables.gametime = Getrunct.Gametime>
	<cfquery datasource="Nbastats" name="nbaavg">
	Select Avg(ps) as NBAoffavg from nbadata 
	</cfquery>	
	
	<cfset aps = nbaavg.nbaoffavg>
	
	Scoring<br>
	<cfquery datasource="Nbastats" name="myquery">
	Select Team,Avg(ps) as ps, Avg(dps) as dps
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	</cfquery>

	<cfoutput query="myquery">
	<cfquery datasource="Nba" name="GetPow">
		Select Avg(ps) as pspow, Avg(dps) as dpspow
		from power
		where team = '#myquery.Team#'
	</cfquery>
	
	<cfset totps  = myquery.ps  + getpow.pspow>
	<cfset totdps = myquery.dps - getpow.dpspow> 	

	<cfquery datasource="nba">
	Insert into Scoring
	(
	Team,
	ps,
	dps,
	pctBetterOff,
	pctBetterDef
	)
	Values
	(
	'#myquery.team#',
	#totps#,
	#totdps#,
	#totps - aps#,
	#aps - totdps#
	)
	</cfquery>
	</cfoutput>
	
		
	
	<cfquery datasource="nbastats" name="GetGames">
		Select * from nbaschedule
		where gametime < '#GetRunct.Gametime#'
	</cfquery>	
	
	<cfloop query="GetGames">
	
		<cfset fav  = GetGames.Fav>
		<cfset Und  = GetGames.Und>
		<cfset ha   = GetGames.ha>
		<cfset spd  = GetGames.spd>
		<cfset thegametime = GetGames.Gametime>
		
		<cfquery datasource="nbastats" name="GetFavResults">
		Select * from nbaData
		where gametime = '#thegametime#'
		and Team = '#fav#'
		</cfquery>	
	
		<cfquery datasource="nbastats" name="GetUndResults">
		Select * from nbaData
		where gametime = '#thegametime#'
		and Team = '#und#'
		</cfquery>	
		
		<cfset skipit = 'N'>
		<cfif GetFavResults.recordcount is 0 or GetUndResults.recordcount is 0>
			<cfset skipit = 'Y'>
		</cfif> 
		
		
		<cfif skipit is 'N'>
		
		<!-- Did the favorite cover? -->
		<cfset scoreatleast = GetFavResults.ps>
		<cfset willgiveup   = GetFavResults.dps>
		
			<!-- Get all the teams rated better offensively -->
			<cfquery datasource="nba" name="GetRowsToUpdate">
				Select s2.team,  (s2.pctbetteroff - s1.pctbetteroff + #scoreatleast#) as predsc 
				from scoring s1, scoring s2
				where s2.pctbetteroff >= s1.pctbetteroff  
				and s1.Team = '#fav#'
			</cfquery>
		
			<cfoutput query="GetRowsToUpdate">
						
				<cfquery datasource="nba">
				Insert into WL
				(
				Team,
				Opp,
				ha,
				spread,
				FavFlag,
				Ps,
				Dps
				)
				values
				(
				'#GetRowsToUpdate.Team#',
				'#und#',
				'#ha#',
				#spd#,
				'Y',
				#GetRowsToUpdate.predsc#,
				0
				)
				</cfquery>
			
			</cfoutput>
			
			
			<!-- Get all the teams rated worse offensively -->
			<cfquery datasource="nba" name="GetRowsToUpdate">
				Select s2.team,  (#scoreatleast# - (s1.pctbetteroff - s2.pctbetteroff)) as predsc 
				from scoring s1, scoring s2
				where s2.pctbetteroff < s1.pctbetteroff  
				and s1.Team = '#fav#'
			</cfquery>
			
			
			<cfoutput query="GetRowsToUpdate">
						
				<cfquery datasource="nba">
				Insert into WL
				(
				Team,
				Opp,
				ha,
				spread,
				FavFlag,
				Ps,
				Dps
				)
				values
				(
				'#GetRowsToUpdate.Team#',
				'#und#',
				'#ha#',
				#spd#,
				'Y',
				#GetRowsToUpdate.predsc#,
				0
				)
				</cfquery>
			
			</cfoutput>
				



			<!-- Get all the teams rated better defensively -->
			<cfquery datasource="nba" name="GetRowsToUpdate">
				Select s2.team,  (#willgiveup# - (s2.pctbetteroff - s1.pctbetteroff)) as predsc 
				from scoring s1, scoring s2
				where s2.pctbetterdef >= s1.pctbetterdef  
				and s1.Team = '#fav#'
			</cfquery>
		
			<cfoutput query="GetRowsToUpdate">
						
				<cfquery datasource="nba">
				Insert into WL
				(
				Team,
				Opp,
				ha,
				spread,
				FavFlag,
				Ps,
				Dps
				)
				values
				(
				'#GetRowsToUpdate.Team#',
				'#und#',
				'#ha#',
				#spd#,
				'Y',
				0,
				#GetRowsToUpdate.predsc#
				
				)
				</cfquery>
			
			</cfoutput>
			
			
			<!-- Get all the teams rated worse defensively -->
			<cfquery datasource="nba" name="GetRowsToUpdate">
				Select s2.team,  (#willgiveup# + (s1.pctbetteroff - s2.pctbetteroff)) as predsc 
				from scoring s1, scoring s2
				where s2.pctbetterdef < s1.pctbetterdef  
				and s1.Team = '#fav#'
			</cfquery>
			
			
			<cfoutput query="GetRowsToUpdate">
						
				<cfquery datasource="nba">
				Insert into WL
				(
				Team,
				Opp,
				ha,
				spread,
				FavFlag,
				Ps,
				Dps
				)
				values
				(
				'#GetRowsToUpdate.Team#',
				'#und#',
				'#ha#',
				#spd#,
				'Y',
				#GetRowsToUpdate.predsc#,
				0
				)
				</cfquery>
			
			</cfoutput>
		</cfif>	
	</cfloop>
</body>
</html>
