
<cfquery datasource="Nba" name="GetRunct">
	Select RunCt,Gametime
	from NBAGameTime
</cfquery>
<cfset Gametime = '#GetRunCt.Gametime#'>



<cfif 1 is 1>
<cfquery name="UpdPowPts" datasource="nba">
	UPDATE BetterThanAvg
	SET PowerPts = oPs + dps
	
</cfquery>

</cfif>




<cfset multiplier = 1>

<cfquery name="GetPowPts" datasource="nba">
SELECT Team, PowerPts
FROM BetterThanAvg
</cfquery>


<CFLOOP query="GetPowPts">

	<cfquery name="UpdPowPts" datasource="nba">
	UPDATE BetterThanAvg
	SET PowerPts = #GetPowPts.PowerPts#
	WHERE TEAM = '#GetPowPts.Team#'
	</cfquery>

</CFLOOP>




<cfquery name="GetTeams" datasource="nba">
SELECT Distinct Team
FROM NBAData
</cfquery>


<cfloop query="GetTeams">

	
	<cfquery name="GetOpp" datasource="nba">
	SELECT Team,Opp,gametime,ha,ps,dps
	FROM NbaData
	WHERE Team = '#GetTeams.Team#'
	
	</cfquery>


	
	<cfset TotPts     = 0>
	<cfset Pts        = 0>
	<cfset TotGames = GetOpp.Recordcount>
	
	<cfset Gamect = 0>
	<cfloop query="GetOpp">
	
			<cfset Gamect = Gamect + 1>
			<cfif TotGames gt 10>
			
				<cfif Gamect gt 10 >
					
					<cfif Gamect/totgames gt .80>
						<cfset Multiplier = 1.20>
					<cfelse>
						<cfset Multiplier = 1>
					</cfif>	
					
				<cfelse>
					<cfset Multiplier = 1>
				</cfif>
	
			</cfif>
	
			
	
	
			<cfquery name="OppPowPts" datasource="nba">
			SELECT PowerPts
			FROM BetterThanAvg
			WHERE TEAM = '#GetOpp.opp#'
			</cfquery>
						
			<cfif Getopp.DPS lte GetOpp.PS>
			
				<cfif GetOpp.PS - GetOpp.dPS lte 3>
					<cfset pts = OppPowPts.PowerPts + 2>
				<cfelseif GetOpp.PS - GetOpp.dPS lte 6>
					<cfset pts = OppPowPts.PowerPts + 5>
				<cfelseif GetOpp.PS - GetOpp.dPS lte 9>
					<cfset pts = OppPowPts.PowerPts + 8>
				<cfelse>
					<cfset pts = OppPowPts.PowerPts + 11>
				</cfif>
			
			<cfelse>
			
				<cfif GetOpp.dPS - GetOpp.PS lte 3>
					<cfset pts = OppPowPts.PowerPts - 2>
				<cfelseif GetOpp.dPS - GetOpp.PS lte 6>
					<cfset pts = OppPowPts.PowerPts - 5>
				<cfelseif GetOpp.dPS - GetOpp.PS lte 9>
					<cfset pts = OppPowPts.PowerPts - 8>
				<cfelse>
					<cfset pts = OppPowPts.PowerPts - 11>
				</cfif>
			
			</cfif>
	
			<cfif GetOpp.HA is 'H'>
				<cfset Pts = Pts + 3>
			</cfif>
	
			<cfset TotPts = TotPts + (Multiplier*pts)>
		
	</cfloop>
	
	
	<cfquery name="UpdPowPts" datasource="nba">
		UPDATE BetterThanAvg
		SET PowerPts = #TotPts/gamect#,
		PowerReb = oReb + dReb,
		PowerInside = oftm + dftm,
		PowerOutside = otpm + dtpm,
		PowerTurnover = oto + dto,
		PowerFGPCT    = ofgpct + dfgpct,
		PowerPace     = (ofga + dfga + otpa + dtpa)
		WHERE TEAM = '#GetTeams.Team#'
	</cfquery>

	
	
	<p>
	<p>	

</cfloop>

<cfquery datasource="nba" name="Getspds">
Select *
from nbaschedule
where GameTime = '#GameTime#'
</cfquery>

<cfloop query="GetSpds">

    <cfset fav           = '#GetSpds.Fav#'>
    <cfset und           = '#GetSpds.Und#'>
    <cfset ha            = '#GetSpds.ha#'>
    <cfset spd           = Getspds.spd>


<cfquery datasource="NBA" name="GetFav">
Select PowerPts as Power
from BetterThanAvg 
where team = '#fav#'
</cfquery>

<cfquery datasource="NBA" name="GetUnd">
Select PowerPts as Power
from BetterThanAvg 
where team = '#und#'
</cfquery>

<cfset favpow = #Getfav.Power#>
<cfset undpow = #GetUnd.Power#>

<cfif ha is 'H' >
	<cfset favpow = favpow + 2.33>
<cfelse>
	<cfset undpow = undpow + 2.33>
</cfif>

<cfset PredMOV = FavPow - UndPow>


	
</cfloop>	
	






