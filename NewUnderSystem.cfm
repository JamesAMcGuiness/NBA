
<cfquery datasource="Nba" name="GetRunct">
	Select Gametime
	from NBAGameTime
</cfquery>

<cfset GameTime = GetRunct.GameTime>


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
	<cfset ou            = getspds.ou>

<cfset oudiv  = ou/2>
<cfset spddiv = spd/2>

<cfset FavNum = oudiv + spddiv>
<cfset UndNum = oudiv - spddiv>


<cfset FavUndCt = 0>
<cfset UndUndCt = 0>
<cfset FavOvrCt = 0>
<cfset UndOvrCt = 0>
<cfset FavPshCt = 0>
<cfset UndPshCt = 0>
<cfset FavTotGames = 0>
<cfset UndTotGames = 0>
<cfset FavScore = 0>
<cfset UndScore = 0>




<cfquery datasource="NBA" name="FavStats">
Select oPS
from MATRIX
WHERE Team = '#fav#'
AND   HA   = '#ha#'
AND   OPP  = '#und#'

</cfquery>


<cfset otherha = 'H'>
<cfif ha is 'H'>
	<cfset otherha = 'A'>
</cfif>


<cfquery datasource="NBA" name="UndStats">
Select oPS
from MATRIX
WHERE Team = '#Und#'
AND   HA   = '#otherha#'
AND   OPP  = '#fav#'

</cfquery>


<cfloop query="FavStats">

	<cfif Favstats.ops lt FavNum>
		<cfset FavUndCt = FavUndCt + 1>
	</cfif>


	<cfif Favstats.ops gt FavNum>
		<cfset FavOvrCt = FavOvrCt + 1>
	</cfif>


	<cfif Favstats.ops eq FavNum>
		<cfset FavPshCt = FavPshCt + 1>
	</cfif>

	<cfset FavTotGames = FavTotGames + 1>
	
	<cfset FavScore = FavScore + FavStats.ops>
</cfloop>



<cfloop query="UndStats">

	<cfif Undstats.ops lt UndNum>
		<cfset UndUndCt = UndUndCt + 1>
	</cfif>


	<cfif Undstats.ops gt UndNum>
		<cfset UndOvrCt = UndOvrCt + 1>
	</cfif>


	<cfif Undstats.ops eq UndNum>
		<cfset UndPshCt = UndPshCt + 1>
	</cfif>

	<cfset UndTotGames = UndTotGames + 1>
	
	<cfset UndScore = UndScore + UndStats.ops>
	
</cfloop>






<cfquery datasource="NBA" name="FavStats">
Select dPS
from MATRIXdps
WHERE Team = '#fav#'
AND   HA   = '#ha#'
AND   OPP  = '#und#'

</cfquery>

<cfquery datasource="NBA" name="UndStats">
Select dPS
from MATRIXdps
WHERE Team = '#Und#'
AND   HA   = '#otherha#'
AND   OPP  = '#fav#'

</cfquery>


<cfloop query="FavStats">

	<cfif Favstats.dps lt UndNum>
		<cfset UndUndCt = UndUndCt + 1>
	</cfif>


	<cfif Favstats.dps gt UndNum>
		<cfset UndOvrCt = UndOvrCt + 1>
	</cfif>


	<cfif Favstats.dps eq UndNum>
		<cfset UndPshCt = UndPshCt + 1>
	</cfif>

	<cfset FavTotGames = FavTotGames + 1>
	
	<cfset UndScore = UndScore + FavStats.dps>
	
</cfloop>



<cfloop query="UndStats">

	<cfif Undstats.dps lt FavNum>
		<cfset FavUndCt = FavUndCt + 1>
	</cfif>


	<cfif Undstats.dps gt FavNum>
		<cfset FavOvrCt = FavOvrCt + 1>
	</cfif>


	<cfif Undstats.dps eq FavNum>
		<cfset FavPshCt = UndPshCt + 1>
	</cfif>

	<cfset UndTotGames = UndTotGames + 1>
	
	<cfset FavScore = FavScore + UndStats.dps>
	
</cfloop>

<cfif (favUndCt /FavTotGames) gte .60 and (UndUndCt /UndTotGames) gte .60>
<cfoutput>
Parameters:<br>
#Fav# predicted by vegas: #FavNum#<br>
#Und# predicted by vegas: #UndNum#<br>
<hr>
<p>
********************************************************************************<br>
The Percent Of The Time #fav# goes under #favnum# is #favUndCt /FavTotGames#<br>
The Percent Of The Time #Und# goes under #Undnum# is #UndUndCt /UndTotGames#<br>

<cfset totscr = FavScore+Undscore>
<cfset totgms = FavTotGames+UndTotGames>
<cfset pred   = 2*(totscr/totgms)>

The Avg Total Predicted Points is: #pred#<br> 

********************************************************************************<br>
</cfoutput>
</cfif>
</cfloop>









