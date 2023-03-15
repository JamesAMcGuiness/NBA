

<cfquery datasource="nba" name="getgames">
Select * from NbaSchedule fp
where gametime in (select gametime from nbagametime)
</cfquery>

<cfoutput>
<b>
<DIV align="left"><u>NBA System Plays For: #getgames.gametime#</u></div>
</b>
</cfoutput>

<br>
<cfset aSystems = arraynew(1)>
<cfset aSystems[1]  = 'SYS57'>
<cfset aSystems[2]  = 'SYS27'>
<cfset aSystems[3]  = 'SYS50'>
<cfset aSystems[4]  = 'SYS500'>
<cfset aSystems[5]  = 'SYS6'>
<cfset aSystems[6]  = 'SYS51'>
<cfset aSystems[7]  = 'SYS28'>
<cfset aSystems[8]  = 'SYS16'>
<cfset aSystems[9]  = 'SYS99'>
<cfset aSystems[10] = 'SYS102'>
<cfset aSystems[11] = 'SYS19'>
<cfset aSystems[12] = 'SYS42'>
<cfset aSystems[13] = 'SYS300'>
<cfset aSystems[13] = 'SYS34'>
<cfset aSystems[13] = 'SYS36'>
<cfset aSystems[13] = 'SYS33'>

<cfoutput query="getgames">
	<cfset thefav = '#GetGames.Fav#'>
	<cfset theund = '#GetGames.Und#'>
	<cfset thespd =  #GetGames.spd#>

	<cfset thestr2 = ''>
	<cfset thestr1 = "#thefav#" & " -#thespd#" & " #theund#">

	<cfloop index="x" from="1" to="#ArrayLen(aSystems)#">
		<cfset theSYS  = aSystems[#x#]>
		<cfset therec  = GetSysRec(aSystems[#x#])>
		<cfset thePick = GetSysPick(aSystems[#x#],'#thefav#')>

		<cfif thePick gt ''>
			<cfset thestr2 = thestr2 & "=====>" & "#thesys# " & " - " & "#thePick#" & "(#therec#%)" & "<br>">
		</cfif>


	</cfloop>

	<b>#thestr1#</b><br>
	#thestr2#
	<p>
</cfoutput>


<cfabort>


<cffunction name="GetSysRec" access="remote" output="yes" returntype="Numeric">
	<cfargument name="SysNum"              type="String"  required="yes" />

	<cfquery datasource="NBA" name="GetSysRecs">
	Select rec.UpToDatePct 
	from SystemRecord rec
	where rec.SystemNum = '#arguments.SYSNum#'
	
	</cfquery>

	<cfreturn #numberformat(GetSysRecs.UpToDatePct,'999.99')# >

</cffunction>


<cffunction name="GetSysPick" access="remote" output="yes" returntype="String">
	-- Returns the position of where the string was found	
	
	<cfargument name="SysNum"              type="String"  required="yes" />
	<cfargument name="Fav"                  type="String"  required="yes" />
	
	
	<cfquery datasource="NBA" name="GetPick">
	Select fp.*
	from Finalpicks fp, NBAGametime gt
	where #Arguments.SysNum# > ''
	and fp.Gametime = gt.Gametime
	and fp.Fav = '#Arguments.Fav#'
	</cfquery>

	
	<cfset retval ='GetPick.#Arguments.SysNum#'>


	<cfreturn '#evaluate(retval)#' >

</cffunction>


