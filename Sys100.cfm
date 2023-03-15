<cfset Gametime = '20191217'>

<cfquery datasource="NBA" name="Getit">
Select distinct Gametime, Fav,Und,spd,whocovered
from FinalPicks p, GAP gund, GAP gfav
Where p.Und = gund.Team
and p.fav = gfav.Team
and gund.dRebounding in ('G')
and gund.ops <> 'P'
and gfav.ops in ('P','A')
and p.Gametime = '#gametime#'
and p.spd >= 3.5
</cfquery>

<cfquery datasource="NBA" name="Upd">
	Update FinalPicks
	Set Sys100 = ''
	where Gametime = '#gametime#'
	and Sys100 = 'UNDER'
</cfquery>


<cfoutput query="Getit">


Found one... #Gametime#<br>

	<cfquery datasource="NBA" name="Upd2">
	Update FinalPicks
	Set Sys100 = '#Getit.und#'
	where Gametime = '#gametime#'
	and Fav = '#Getit.Fav#'
	</cfquery>
	
</cfoutput>
