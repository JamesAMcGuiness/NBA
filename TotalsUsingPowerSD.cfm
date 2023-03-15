

<cfquery datasource="nba" name="GetDay">
Select Gametime 
from NBAGametime
</cfquery>

<cfset theday = GetDay.Gametime> 

<cfquery datasource="nba" name="Getspds">
Select *
from nbaschedule
where GameTime = '#theday#'
</cfquery>

<cfloop query="GetSpds">

	<cfset fav           = '#GetSpds.Fav#'> 
	<cfset und           = '#GetSpds.Und#'>
	<cfset ha            = '#GetSpds.ha#'>
	<cfset spd           = Getspds.spd>
	
	<cfquery datasource="NBA" name="FavPower">
	select *
	from PowerSD
	where Team = '#fav#'
	and ha = '#ha#'
	</cfquery>   

	<cfset myha = 'H'>
	<cfif ha is 'H'>
		<cfset myha = 'A'>
	</cfif>

	<cfquery datasource="NBA" name="UndPower">
	select *
	from PowerSD
	where Team = '#und#'
	and ha = '#myha#'
	</cfquery>   

	<Table border="1">
	<tr>

	<td>
	TEAM
	</td>

	<td>
	Lo FGPCT
	</td>

	<td>
	Hi DFGPCT
	</td>

	<td>
	Lo FTA
	</td>

	<td>
	Hi DFTA
	</td>

	<td>
	Lo TPA
	</td>

	<td>
	Hi DTPA
	</td>

	<cfoutput query="FavPower">
	<tr>

	<td>
	#Team#
	</td>


	<td>
	#lofgpct#
	</td>

	<td>
	#hidfgpct#
	</td>

	<td>
	#lofta#
	</td>

	<td>
	#hidfta#
	</td>

	<td>
	#lotpa#
	</td>

	<td>
	#hidtpa#
	</td>

	</tr>
	
	<cfset c_lofgpct  = lofgpct>
	<cfset c_hidfgpct = hidfgpct>
	<cfset c_lofta    = lofta>
	<cfset c_hidfta   = hidfta>
	<cfset c_lotpa    = lotpa>	
	<cfset c_hidtpa   = hidtpa>	
	
	
	</cfoutput>



	<cfoutput query="UndPower">
	<tr>

	<td>
	#Team#
	</td>

	<td>
	#lofgpct#
	</td>

	<td>
	#hidfgpct#
	</td>

	<td>
	#lofta#
	</td>

	<td>
	#hidfta#
	</td>

	<td>
	#lotpa#
	</td>

	<td>
	#hidtpa#
	</td>

	</tr>
	
	<cfset c_lofgpct  = 100*(c_lofgpct  + lofgpct)/2>
	<cfset c_hidfgpct = 100*(c_hidfgpct + hidfgpct)/2>
	<cfset c_lofta    = 100*(c_lofta + lofta)/2>
	<cfset c_hidfta   = 100*(c_hidfta + hidfta)/2>
	<cfset c_lotpa    = 100*(c_lotpa + lotpa)/2>	
	<cfset c_hidtpa   = 100*(c_hidtpa + hidtpa)/2>	
	
	</cfoutput>

	<cfoutput>
	<tr>

	<td>
	Combined
	</td>

	<td>
	<cfif c_lofgpct gte 60 >
		<b>#c_lofgpct#</b>
	<cfelse>	
		#c_lofgpct#
	</cfif>	
	</td>

	<td>
	<cfif c_hidfgpct gte 60 >
		<b>#c_hidfgpct#</b>
	<cfelse>	
		#c_hidfgpct#
	</cfif>
	</td>

	<td>
	<cfif c_lofta gte 60 >
		<b>#c_lofta#</b>
	<cfelse>	
		#c_lofta#
	</cfif>
	</td>

	<td>
	<cfif c_hidfta gte 60 >
		<b>	#c_hidfta#</b>
	<cfelse>	
			#c_hidfta#
	</cfif>
	</td>

	<td>
	<cfif c_lotpa gte 60 >
		<b>	#c_lotpa#</b>
	<cfelse>	
			#c_lotpa#
	</cfif>
	
	</td>

	<td>
	
	<cfif c_hidtpa gte 60 >
		<b>	#c_hidtpa#</b>
	<cfelse>	
			#c_hidtpa#
	</cfif>
	</td>

	</tr>
	</cfoutput>


	</table>
	<p>
		
	<cfif c_lofgpct gte 60 and c_hidfgpct gte 60 and c_lofta gte 60>
		
		<cfquery name="addit" datasource="nba">
		Update FinalPicks
		Set SYS55 = 'UNDER'
		Where Gametime = '#theday#'
		and FAV = '#fav#'
		</cfquery>
		
	</cfif>	
	
	
	<cfset c_lofgpct  = 0>
	<cfset c_hidfgpct = 0>
	<cfset c_lofta    = 0>
	<cfset c_hidfta   = 0>
	<cfset c_lotpa    = 0>	
	<cfset c_hidtpa   = 0>	
	
	
</cfloop>	
