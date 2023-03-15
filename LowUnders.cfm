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


<cfif ha is 'H'>

	<cfquery datasource="NBA" name="GetGames">
	Select Avg(of.oPIP),Avg(of.dPIP),Avg(ou.oPIP),Avg(du.dPIP) 
	from MatrixPIP of, MatrixPIP ou, MatrixdPIP df, MatrixdPIP du
	where of.team = '#fav#'
	and ou.team   = '#und#'
	and of.ha     = 'H'
	and ou.ha     = 'A'
	and of.opp    = '#und#'
	and ou.opp    = '#fav#'
	
	
	</cfquery>
	
	and p.team = d.team
	and (f.fav = p.team or f.und = p.team)
	and d.gametime = f.gametime
	and d.gametime = p.gametime
	and scd.gametime = d.gametime
	and scd.fav = f.fav
	
	order by p.Gametime desc
	</cfquery>

<cfoutput>
**********<br>
#Fav#<br>
**********
</cfoutput>
<table border="1">

<tr>
<td>GameTime</td>
<td>HA</td>
<td>OPP</td>
<td>PS</td>
<td>DPS</td>
<td>TOTAL PTS</td>
<td>FGPCT</td>
<td>DFGPCT</td>
		
<td>PS</td>
<td>DPS</td>
<td>Total Points
<td>Vegas Total</td>
<td>Spread</td>
<td>Who Covered</td>
	
<cfset rowct    = 0>	
<cfset dps10    = 0>
<cfset dfgpct5  = 0>
<cfset dfgpct12 = 0>
<cfset totpts   = 0>	
	
<cfoutput query="GetGames" >
	<cfset rowct = rowct + 1>
<tr>
<td>#Gametime#</td>	
<td>#ha#</td>
<td>#opp#</td>
<td>#ps#</td>
<td>#dps#</td>
<td>#ps + dps#</td>
<td>#ofgpct#</td>
<td>#dfgpct#</td>

<td>#PS1#</td>
<td>#DPS1#</td>
<td>#totpoints#
<td>#ou#</td>
<td>#spd#</td>
<td>#whocovered#</td>

	<!--- Get last two games --->

	<cfif rowct lt 3>
		
		<cfif totpoints lt 190>
			<cfset totpts = totpts + 1>
		</cfif>
		
		<cfif #DPS# gte 10>
			<cfset dps10 = dps10 + 1 >
		</cfif>

		<cfif #Dfgpct# gte 5>
			<cfset dfgpct5 = dfgpct5 + 1 >
		</cfif>

		<cfif #Dfgpct# gte 12>
			<cfset dfgpct12 = dfgpct12 + 1 >
		</cfif>

	</cfif>


</tr>
</cfoutput>
</table>

<cfoutput>
<cfif Totpts is 2>
**********************************************************************<br>
PLAY OVER in the #fav# game... Tot Points lt 190 last two games<br>
**********************************************************************<br>
<p>
</cfif>


<cfif dps10 is 2>
***********************************************************<br>
PLAY OVER in the #fav# game... DPS >= 10 last two games<br>
***********************************************************<br>
<p>
</cfif>

<cfif dfgpct5 is 2>
*******************************************************************************<br>
PLAY OVER in the #fav# game and AGAINST #fav#... DFGpct >= 5 last two games<br>
********************************************************************************<br>
<p>
</cfif>


<cfif dfgpct12 is 2>
*************************************************************************************<br>
PLAY OVER in the #fav# game and AGAINST #fav#... combined DFGpct >= 12 last two games<br>
**************************************************************************************<br>
<p>
</cfif>
</cfoutput>


<hr>

<cfquery datasource="NBA" name="GetGames">
Select p.*, d.ps as ps1,d.dps as dps1, d.ps + d.dps as TotPoints, f.whocovered, f.fav,f.spd,f.und , scd.ou
from Power p, NBAData d, FinalPicks f, nbaschedule scd
where p.team = '#und#'
and p.Gametime > '#DAYcheckSTR#'

and p.team = d.team
and (f.fav = p.team or f.und = p.team)
and d.gametime = f.gametime
and d.gametime = p.gametime
and scd.gametime = d.gametime
and scd.fav = f.fav

order by p.Gametime desc
</cfquery>


<cfset rowct    = 0>	
<cfset dps10    = 0>
<cfset dfgpct5  = 0>
<cfset dfgpct12 = 0>
<cfset totpts   = 0>

<cfoutput>
**********<br>
#Und#<br>
**********
</cfoutput>
<table border="1">

<tr>
<td>GameTime</td>
<td>HA</td>
<td>OPP</td>
<td>PS</td>
<td>DPS</td>
<td>TOTAL PTS</td>
<td>FGPCT</td>
<td>DFGPCT</td>
		
<td>PS</td>
<td>DPS</td>
<td>Total Points
<td>Vegas Total</td>
<td>Spread</td>
<td>Who Covered</td>
		
<cfoutput query="GetGames" >
	
	<cfset rowct = rowct + 1>
	<!--- Get last two games --->

	<cfif rowct lt 3>
		<cfif totpoints lt 190>
			<cfset totpts = totpts + 1>
		</cfif>
	
		<cfif #DPS# gte 10>
			<cfset dps10 = dps10 + 1 >
		</cfif>

		<cfif #Dfgpct# gte 5>
			<cfset dfgpct5 = dfgpct5 + 1 >
		</cfif>

		<cfif #Dfgpct# gte 12>
			<cfset dfgpct12 = dfgpct12 + 1 >
		</cfif>

	</cfif>
	
	
	
	
<tr>
<td>#Gametime#</td>	
<td>#ha#</td>
<td>#opp#</td>
<td>#ps#</td>
<td>#dps#</td>
<td>#ps + dps#</td>
<td>#ofgpct#</td>
<td>#dfgpct#</td>

<td>#PS1#</td>
<td>#DPS1#</td>
<td>#totpoints#
<td>#ou#</td>
<td>#spd#</td>
<td>#whocovered#</td>
</cfoutput>
</table>

<cfoutput>
<cfif Totpts is 2>
**********************************************************************<br>
PLAY OVER in the #fav# game... Tot Points less than 380 last two games<br>
**********************************************************************<br>
<p>
</cfif>



<cfif dps10 is 2>
***********************************************************<br>
PLAY OVER in the #fav# game... DPS >= 10 last two games<br>
***********************************************************<br>
<p>
</cfif>

<cfif dfgpct5 is 2>
*******************************************************************************<br>
PLAY OVER in the #fav# game and AGAINST #und#... DFGpct >= 5 last two games<br>
********************************************************************************<br>
<p>
</cfif>


<cfif dfgpct12 is 2>
*************************************************************************************<br>
PLAY OVER in the #fav# game and AGAINST #und#... combined DFGpct >= 12 last two games<br>
**************************************************************************************<br>
<p>
</cfif>
</cfoutput>




</cfloop>