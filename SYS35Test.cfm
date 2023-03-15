<cfset mygametime = "20171024">
		     

<cfquery datasource="NBA" name="GetGames">
Select fp.und 
from finalpicks fp
where fp.gametime = '#mygametime#'
and fp.FavHealthL7  < -7

</cfquery>

<cfif GetGames.recordcount gt 0>
	We have a PLAY!
<cfelse>
No PLAYS
</cfif>


<cfoutput query="GetGames">
#gametime#....#und#<br>

<cfquery datasource="NBA" name="upd">
Update FinalPicks 
Set SYS35 = '#GetGames.und#'
where Gametime = '#mygametime#'
and Und = '#GetGames.Und#'
</cfquery>

</cfoutput>
**********************<p>

and fp.UndHealthL7  > fp.FavHealthL7
and fp.spd >= 4