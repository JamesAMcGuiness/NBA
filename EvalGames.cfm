<cfquery datasource="Nba" name="GetRunct">
    Select Gametime
    from NBAGameTime
</cfquery>

<cfset GameTime = GetRunct.GameTime>

<cfset GameTime = '20160115'>



        <cfset yyyy        = left(gametime,4)>
        <cfset mm          = mid(gametime,5,2)>
        <cfset dd          = right(gametime,2)>
        <cfset mydate      = #Dateformat(DateAdd("d",0,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
        <CFSET DAYcheck    = #Dateformat(DateAdd("d",-10,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
        <CFSET DAYcheckSTR = ToString(DAYCheck)>



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


<cfquery datasource="NBA" name="GetGames">
Select p.*,d.DefEffort, d.ps as ps1,d.dps as dps1, d.ps + d.dps as TotPoints, f.whocovered, f.fav,f.spd,f.und , scd.ou
from Power p, NBAData d, FinalPicks f, nbaschedule scd
where p.team = '#fav#'
and p.Gametime > '#DAYcheckSTR#'

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
<td>DEFEFFORT</td>

        
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
<cfset DefEff = 0>

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
<td>#defEffort#</td>

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

        <cfif #DefEffort# gte 10>
            <cfset defeff = defeff + 1 >
        </cfif>

        
        
    </cfif>


</tr>
</cfoutput>
</table>

<cfoutput>
<cfif defeff is 2>
**********************************************************************<br>
PLAY against #fav# and on #und# and look to the OVER at #ou#<br>
**********************************************************************<br>
<p>
</cfif>

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
Select p.*,d.DefEffort, d.ps as ps1,d.dps as dps1, d.ps + d.dps as TotPoints, f.whocovered, f.fav,f.spd,f.und , scd.ou
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
<cfset DefEff = 0>

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
<td>DEFEFFORT</td>

        
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
        
        <cfif #DefEffort# gte 10>
            <cfset DefEff = DefEff + 1 >
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
<td>#defEffort#</td>


<td>#PS1#</td>
<td>#DPS1#</td>
<td>#totpoints#
<td>#ou#</td>
<td>#spd#</td>
<td>#whocovered#</td>
</cfoutput>
</table>

<cfoutput>
<cfif defeff is 2>
**********************************************************************<br>
PLAY against #und# and on #fav# and look to the OVER at #ou#<br>
**********************************************************************<br>
<p>
</cfif>


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