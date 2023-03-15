
 
<cfquery datasource="NBA" name="GetGames">
Update FinalPicks 
Set SYS80 = ''
where Gametime >= '20151115'
</cfquery>


<cfquery datasource="NBA" name="GetGames">
Select s.gametime, 
		s.fav,
		s.und,
		s.spd,
		fp.whocovered 
		 
from ImportantStatPreds i, finalpicks fp, nbaschedule s
where i.gametime = fp.gametime
and   s.gametime = i.gametime 
and   (s.fav = i.fav)
and fp.fav = i.fav
and i.gametime >= '20151115'
and i.PIPAdv   = s.und
and i.RebAdv   = s.und
and i.FGPCTAdv = s.und
and whocovered <> 'PUSH'
and s.spd >= 5.5
and fp.UndPlayedYest = 'N'
order by s.gametime desc
</cfquery>


<table border="1">
<tr>
<td>
Gametime
</td>	
<td>
Fav
</td>	
<td>
Und
</td>	
<td>
Spd
</td>	
<td>
Who Covered
</td>	
</tr>

<cfset w = 0>
<cfset l = 0>


<cfoutput query="GetGames">
<tr>
<td>#gametime#</td>
<td>#fav#</td>
<td>#und#</td>
<td>#spd#</td>
<cfset cl = ''>
<cfif whocovered neq '' and whocovered neq 'PUSH'> 
	<cfif whocovered is und>
		<cfset cl = 'green'>
		<cfset w = w + 1>
	<cfelse>
		<cfset l = l + 1>
	</cfif>	
<td bgcolor='#cl#'>#WhoCovered#</td>

</tr>


<cfquery datasource="NBA" name="UpdGames">
Update FinalPicks 
Set SYS80 = '#und#'
where Gametime = '#GetGames.gametime#'
and und = '#GetGames.UND#'
</cfquery>
</cfif>
</cfoutput>

<cfquery datasource="Nba" name="GetStatus">
	Insert into NBADataLoadStatus (StepName)
	values('TestPIPGames-For-SYS80')
</cfquery>


<!--- <cfoutput>
#w# - #l#
</cfoutput> --->
