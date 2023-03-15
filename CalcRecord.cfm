<cfquery datasource="nba" name="GetGameDay">
		Select Max(Gametime) as gameday
		From FinalPicks
</cfquery>


<cfquery datasource="nba" name="updateit">
		Update SystemRecord
			Set W2012 = 0,
	  		 L2012 = 0,
			Pct2012 = 0
		
</cfquery>

<cfquery datasource="NBA" name="GetSystems">
Select * 
from SystemRecord
WHERE Active='Y'
order by PCT2012 desc
</cfquery>

<cfquery datasource="NBA" name="GetResults">
Select * 
from FinalPicks
WHERE Gametime >= '20161201'
AND (Whocovered <> 'PUSH' AND Whocovered > '')
order by gametime desc
</cfquery>

<cfoutput query="GetSystems">

	<cfquery datasource="NBA" name="GetSysResults">
	Select * 
	from FinalPicks
	WHERE GameTime >= '20161201'
	AND #GetSystems.Systemnum# > ''
	and (WhoCovered > '' and whocovered <> 'PUSH')
	order by gametime desc
	</cfquery>

	<cfset w = 0>
	<cfset l = 0>
	
	<cfloop query="GetSysResults">
		<!---
		Checking #gametime#... #RIGHT(evaluate("GetSysResults.#GetSystems.Systemnum#"),3)# vs #GetSysResults.WhoCovered#<br>
		--->
		<cfif #RIGHT(evaluate("GetSysResults.#GetSystems.Systemnum#"),3)# is '#GetSysResults.WhoCovered#'>
			<cfset w = w + 1>
		<cfelse>
			<cfset l = l + 1>
		</cfif>
	
	</cfloop>
	<cfif (w + l) gt 0>
	<cfset myval = Numberformat(100*#w#/(#w# + #l#),'999.99')>
	<cfquery datasource="nba" name="updateit">
		Update SystemRecord
			Set W2012 = #w#,
	  		 L2012 = #l#,
			Pct2012 = #myval#
		where SystemNum = '#GetSystems.Systemnum#'
	</cfquery>
	</cfif>
	

</cfoutput>


<cfquery datasource="NBA" name="GetSysRec">

Select 	(w2012 + Lifetimewins)   as Wins,
		(L2012 + LifetimeLosses) as Losses,
		(w2012 + Lifetimewins) / (w2012 + Lifetimewins + L2012 + LifetimeLosses) As pct,
		Systemnum
from SystemRecord
WHERE Active='Y'
and w2012 + Lifetimewins + L2012 + LifetimeLosses > 0
order by 3 desc
</cfquery>

<table border="1" cellpadding="4" cellspacing="4">
<tr>
<td bgcolor="gray">System</td>
<td bgcolor="gray">WIN Pct</td>
<td bgcolor="gray">WINS</td>
<td bgcolor="gray">LOSSES</td>
<td bgcolor="gray">Picks</td>
<td bgcolor="gray">WIN Pct This YR</td>


</tr>

<cfoutput query="GetSysRec">
<cfif 100*GetSysRec.pct gte 55>
<tr>
<td>
#GetSysRec.SystemNum#
</td>
<td>
#Numberformat(100*GetSysRec.pct,'999.99')#
</td>
<td>
#Wins#
</td>
<td>
#Losses#
</td>
<td>
#Getpicks('#GetSysRec.SystemNum#','#GetGameDay.GameDay#')#
</td>
<td>
#GetPctThisYR('#GetSysRec.SystemNum#')#
</td>
</tr>
</cfif>
</cfoutput>
</table>


<cffunction name="GetPicks">

<cfargument name="SysNum" type="string">
<cfargument name="Gametime" type="string">	
	<cfquery datasource="NBA" name="GetIt">
	Select #SysNum#
	from FinalPicks
	WHERE #SysNum# <> ''
	and Gametime = '#Gametime#'
	
	</cfquery>

	<cfset thepicks = ''>	
	<cfoutput query="GetIt">
		<cfif thepicks neq ''>
			<cfset thepicks = thepicks & ',' & '#evaluate('Getit.#SysNum#')#'>
		<cfelse>
			<cfset thepicks = '#evaluate('Getit.#SysNum#')#'>
		</cfif>
	</cfoutput>

	<cfreturn '#thepicks#'>

</cffunction>


<cffunction name="GetPctThisYR">

<cfargument name="SysNum" type="string">
	
	<cfquery datasource="NBA" name="GetIt">
	Select Pct2012
	from SystemRecord
	WHERE SystemNum = '#SysNum#'
	</cfquery>

	<cfreturn #Getit.Pct2012#>

</cffunction>







