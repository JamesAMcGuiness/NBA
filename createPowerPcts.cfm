	<cfquery datasource="nba" name="Getspds">
	Delete from PowerPcts 
	</cfquery>

<cfquery datasource="Nba" name="GetRunct">
	Select RunCt,Gametime
	from NBAGameTime
</cfquery>
<cfset Gametime = '#GetRunCt.Gametime#'>



<cfquery datasource="nba" name="GetTeams">
Select distinct Team
from nbadata
</cfquery>

<p>

<cfoutput query="GetTeams">
	<cfset homect = 0>
	<cfset awayct = 0>
	

	<cfset hoverct  = 0>
	<cfset aoverct  = 0>
	<cfset hunderct = 0>
	<cfset aunderct = 0>
	<cfset aoverct  = 0>
	<cfset overct  = 0>
	
	<cfset underct  = 0>
	<cfset dunderct  = 0>
	<cfset aunderct  = 0>
	<cfset daunderct  = 0>
	

	<cfset dhoverct  = 0>
	<cfset daoverct  = 0>
	<cfset dhunderct = 0>
	<cfset daunderct = 0>
	<cfset daoverct  = 0>
	<cfset doverct  = 0>


	
	<cfset gamect  = 0>
		
	<cfset theteam = '#GetTeams.Team#'>

	<cfquery datasource="nba" name="GetIt">
	Select *
	from Power
	where gametime < '#gametime#'
	and team = '#theteam#'
	</cfquery>

	
	<cfloop query="GetIt">
	
		<cfset thegameday = GetIt.gametime>
	
	
	<cfset gamect  = gamect + 1>
	
	<cfif Getit.ha is 'H'>
		<cfset homect = homect + 1>
	</cfif>
	
	<cfif Getit.ha is 'A'>
		<cfset awayct = awayct + 1>
	</cfif>


	
	<cfif Getit.ps gt 0>
		<cfset overct = overct + 1>
		<cfif Getit.ha is 'H'>
			<cfset hoverct = hoverct + 1>
		</cfif>
		<cfif Getit.ha is 'A'>
			<cfset aoverct = aoverct + 1>
		</cfif>
				
		
	</cfif>
	
	<cfif Getit.ps lt 0>
		<cfset underct = underct + 1>
		
		<cfif Getit.ha is 'H'>
			<cfset hunderct = hunderct + 1>
		</cfif>
		
		<cfif Getit.ha is 'A'>
			<cfset aunderct = aunderct + 1>
		</cfif>
		
		
	</cfif>



	<cfif Getit.dps gt 0>
		<cfset doverct = doverct + 1>
		<cfif Getit.ha is 'H'>
			<cfset dhoverct = dhoverct + 1>
		</cfif>
		<cfif Getit.ha is 'A'>
			<cfset daoverct = daoverct + 1>
		</cfif>
				
		
	</cfif>
	
	<cfif Getit.dps lt 0>
		<cfset dunderct = dunderct + 1>
		
		<cfif Getit.ha is 'H'>
			<cfset dhunderct = dhunderct + 1>
		</cfif>
		
		<cfif Getit.ha is 'A'>
			<cfset daunderct = daunderct + 1>
		</cfif>
		
		
	</cfif>
	
	<cfif Getit.ha is 'H'>
		<cfquery datasource="nba" name="uGetIt">
		Update Power
		SET hPowerTotal = #Getit.ps - Getit.dps#
		where gametime = '#thegameday#'
		and team       = '#theteam#'
		</cfquery>
	<cfelse>
		<cfquery datasource="nba" name="uGetIt">
		Update Power
		SET aPowerTotal = #Getit.ps - Getit.dps#
		where gametime = '#thegameday#'
		and team       = '#theteam#'
		</cfquery>
		
	</cfif>
	
	
	</cfloop>
	

	<cfquery datasource="nba" name="Getspds">
	Insert into PowerPcts (Team,PSover,DPSOver,HPSover,HDPSOver,APSover,ADPSOver) VALUES ('#theteam#',#overct/GameCt#,#1 - (doverct/GameCt)#,#hoverct/homeCt#,#1 - (dhoverct/HomeCt)#,#aoverct/AwayCt#,#1 - (doverct/GameCt)#)
	</cfquery>
	
	
</cfoutput>

		<cfquery datasource="nba" name="uGetIt">
		Update Power
		SET OverallPowerTotal = hPowerTotal + aPowerTotal
		</cfquery>




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
Select AVG(PS) + AVG(DPS) as Power
from Power 
where team = '#fav#'
</cfquery>

<cfquery datasource="NBA" name="GetUnd">
Select AVG(PS) + AVG(DPS) as Power
from Power 
where team = '#und#'
</cfquery>


<cfdump var = #GetFav#>
<cfdump var = #GetUnd#>


<cfquery datasource="NBA" name="GetFavP">
Select *
from BetterThanAvg 
where team = '#fav#'
</cfquery>

<cfquery datasource="NBA" name="GetUndP">
Select *
from BetterThanAvg 
where team = '#und#'
</cfquery>


<cfset ptsdif = GetFavP.PowerPts - GetUndP.PowerPts>
<cfset rebdif = GetFavP.PowerReb - GetUndP.PowerReb>
<cfset Insidedif = GetFavP.PowerInside - GetUndP.PowerInside>
<cfset outsidedif = GetFavP.PowerOutside - GetUndP.PowerOutside>
<cfset todif = GetFavP.PowerTurnover - GetUndP.PowerTurnover>
<cfset fgdif = GetFavP.PowerFGPct - GetUndP.PowerFGPct>

<cfset favpow = #Getfav.Power#>
<cfset undpow = #GetUnd.Power#>

<cfif ha is 'H' >
	<cfset favpow = favpow + 2.33>
<cfelse>
	<cfset undpow = undpow + 2.33>
</cfif>

<cfset PredMOV = FavPow - UndPow>



<cfquery datasource="NBA" name="GetFavPY">
Select *
from FinalPicks 
where Fav = '#fav#'
and gametime = '#gametime#'
and FavPlayedYest = 'Y'
</cfquery>

<cfquery datasource="NBA" name="GetUndPY">
Select *
from FinalPicks 
where Fav = '#fav#'
and gametime = '#gametime#'
and UndPlayedYest = 'Y'
</cfquery>

<cfset Pick = 'N/A'>
<cfset PickRat = 0>

<cfif GetFavPY.recordcount gt 0 AND GetUndPY.recordcount gt 0>

<cfelse>

	<cfif GetFavPY.recordcount gt 0>
		<cfset PredMOV = PredMOV - 2.5>
	</cfif>

	<cfif GetUndPY.recordcount gt 0>
		<cfset PredMOV = PredMOV + 2.5>
	</cfif>
</cfif>


<cfif PredMov - spd gt 0>
	<cfset pick = fav>
	<cfset PickRat = PredMov - spd>
</cfif>

<cfif PredMov - spd lt 0>
	<cfset pick = und>
	<cfset PickRat = PredMov + spd>
</cfif>

<cfif PredMov lt spd>
	<cfset pick = und>
	<cfset PickRat = spd - PredMov>
</cfif>


<cfif PickRat gte 4.0>
	<cfset Pick = '#Pick#*'>
</cfif>

<cfoutput>The PredMOV is #PredMOV#, the pickrat is #pickrat#</cfoutput><br>

<cfquery datasource="NBA" name="GetUndPY">
Update FinalPicks 
SET SYS500 = '#Pick#'
where Fav = '#fav#'
and gametime = '#gametime#'
</cfquery>


</cfloop>

<cfquery datasource="Nba" name="UpdStatus">
		Insert into NBADataloadStatus(StepName) values('Finished CreatePowerPcts.cfm - Loads SYS500')
</cfquery>