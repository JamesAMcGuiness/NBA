	<cfquery datasource="nba" name="getinfo">
	Select fp.gametime, pfav.TEAM as FavTm, pfav.PS, pfav.DPS,  
	pund.TEAM as UndTm, pund.PS, pund.DPS, pfav.PS + pfav.DPS as FavTOTPS, pund.PS + pund.DPS as UndTOTPS, fp.WhoCovered
	
	from Power pfav, Power pund, FinalPicks fp
	Where fp.Gametime = pfav.Gametime
	and fp.Gametime = pund.Gametime
	and fp.Gametime = pfav.Gametime
	and fp.Fav = pfav.TEAM
	and fp.Und = pund.TEAM
	order by fp.Gametime desc
	</cfquery>
	
	<cfset win = 0>
	<cfset loss = 0>
	

	<cfoutput query="GetInfo">
	
		<cfif #GetInfo.Favtotps# gt #GetInfo.UndTotPs# >
			<cfif '#GetInfo.Whocovered#' neq 'PUSH'>
				<cfif '#GetInfo.FavTm#' is '#GetInfo.WhoCovered#'> 
					<cfset win = win + 1>
				<cfelse>
					<cfset Loss = Loss + 1>
				</cfif>
			</cfif>	
		</cfif>
	
	
		<cfif #GetInfo.Favtotps# lt #GetInfo.UndTotPs# >
		<cfif '#GetInfo.Whocovered#' neq 'PUSH'>
			<cfif '#GetInfo.UndTm#' is '#GetInfo.WhoCovered#'> 
				<cfset win = win + 1>
			<cfelse>
				<cfset Loss = Loss + 1>
			</cfif>
		</cfif>	
		</cfif>


	
	</cfoutput>


	
	
	<cfoutput>
	Wins = #win#<br>
	Losses = #loss#<br>
	
	</cfoutput>