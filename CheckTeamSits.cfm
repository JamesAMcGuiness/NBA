<cfquery datasource="Nba" name="GetFavsPlaying">
	Select Gametime, Fav, HA, spd, Und, WhoCovered, UndHealthl7, FavHealthL7
	from FinalPicks
	where 1 = 1
	and FavConseqRdCt >= 4
	and HA = 'H'
	and whocovered > ''
	and whocovered <> 'PUSH'
	and spd >= 3
	
	order by gametime desc
</cfquery>



<cfquery datasource="Nba" name="GetFavsPlaying">
	Select Gametime, Fav, HA, spd, Und, WhoCovered, UndHealthl7, FavHealthL7
	from FinalPicks
	where 1 = 1
	and UndConseqRdCt >= 4
	and HA = 'H'
	and whocovered > ''
	and whocovered <> 'PUSH'
	and spd < 8
	
	order by gametime desc
</cfquery>



<cfset w = 0>
<cfset l = 0>

<table border="1">
<cfoutput query="GetFavsPlaying">


<CFIF 1 IS 2>
<cfquery datasource="Nba" name="Updit">
	Update FinalPicks
	SET SYS69 = '#Und#'
	where Gametime = '#GetFavsPlaying.Gametime#'
	and fav = '#GetFavsPlaying.fav#'
</cfquery>
</CFIF>

<CFIF 1 IS 1>
<cfquery datasource="Nba" name="Updit">
	Update FinalPicks
	SET SYS70 = '#fav#'
	where Gametime = '#GetFavsPlaying.Gametime#'
	and fav = '#GetFavsPlaying.fav#'
</cfquery>
</CFIF>


<tr>
<td>#Gametime#</td>
<td>#fav#</td>
<td>#ha#</td>
<td>#spd#</td>
<td>#und#</td>
<td>Undh7:#UndHealthl7#</td>
<td>favh7:#FavHealthl7#</td>
<td>#whocovered#</td>
<td><cfif '#whocovered#' is '#Und#'>WINNER!<cfelse>LOSER</cfif></td>
<cfif '#whocovered#' is '#und#'>
<cfset w = w + 1>
<cfelse>
<cfset l = l + 1>
</cfif>
</tr>
</cfoutput>
<table>
<cfoutput>
#w# - #l#
</cfoutput>
