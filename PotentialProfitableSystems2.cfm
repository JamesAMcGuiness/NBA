<cfset mygametime="20120116">


<cfquery datasource="NBA" name="GetGamesimAvgScore">
select distinct fpf.*,n.pick
from finalpicks fpf,  NBAPicks n
where fpf.whocovered <> 'PUSH'
and fpf.gametime >= '20120101'
and fpf.gametime = n.gametime
and n.systemid = 'MATRIX'
and n.fav = fpf.fav
order by fpf.gametime desc
</cfquery>

<!--- and fgap.fgpct <> 'P'
and fpf.ha = 'H'
and fpf.favhealth > fpu.undhealth  --->


<cfset w = 0>
<cfset g = 0>
<cfoutput query="GetGamesimAvgScore">
	
<cfset skip = false>	
<cfif '#pick#' is '#fav#' and '#favplayedyest#' is 'Y'>
	<cfset skip = true>	
<cfelse>

	<cfif #favhealth# lt -4>
		<cfset skip = true>	
	</cfif>	
</cfif>	

<cfif '#pick#' is '**#fav#' and '#favplayedyest#' is 'Y' >
	<cfset skip = true>	
<cfelse>

	<cfif #favhealth# lt -4>
		<cfset skip = true>	
	</cfif>	
</cfif>	


<cfif '#pick#' is '#und#' and '#undplayedyest#' is 'Y'>
	<cfset skip = true>	
<cfelse>

	<cfif #undhealth# lt -4>
		<cfset skip = true>	
	</cfif>	
</cfif>	

<cfif '#pick#' is '**#und#' and '#undplayedyest#' is 'Y' and #undhealth# lt -3>
	<cfset skip = true>	
<cfelse>

	<cfif #undhealth# lt -4>
		<cfset skip = true>	
	</cfif>	
</cfif>	




<cfif skip is false>		
<cfset g = g + 1>
#gametime#..#spd#....#Whocovered#....#Pick#...#favhealth#.....#undhealth#....#ha#<br> 


<cfif '#whocovered#' is '#pick#' or '**#whocovered#' is '#pick#'>
	WINNER!<br>
	<cfset w = w + 1>
</cfif>	
</cfif>
</cfoutput>

<cfoutput>
#w/g#<br>
#w# - #g - w#
</cfoutput>
<p>
<p>
<p>
