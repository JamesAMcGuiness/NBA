<!--- Create the Home and Away Power Ratings And the Percent of times the Team is above or below the averages of the opponent they faced (Nbapcts) --->
<cfinclude template="CreateAvgsHAPow.cfm">

<!--- Create the Standard Deviations For the stats --->
<cfinclude template="CreatePower2012.cfm">

<cfquery datasource="Nba" name="GetRunct">
	Select RunCt,Gametime
	from NBAGameTime
</cfquery>

<cfset myGametime = GetRunct.gametime>
<!--- <cfset myGametime = '20120320'> --->

<cfquery datasource="nba" name="Getspds">
Select *
from nbaschedule
where GameTime = '#mygametime#'
 </cfquery>


<table width="100%" border="1" cellpadding="4" cellspacing="4">
<tr>
<td>
Favorite
</td>
<td>
Score
</td>
<td>
Underdog
</td>
<td>
Score
</td>
<td>
Our Line
</td>
<td>
Vegas Line
</td>
<td>
Our Total
</td>
<td>
Vegas Total
</td>
<td>
Our Pick
</td>
<td>
% Times Covered
</td>
<td>
Bet Win Confidence
</td>
<td>
Bet Or No Bet?
</td>

</tr>
<cfoutput query="GetSpds">

	<cfset fav           = '#GetSpds.Fav#'> 
	<cfset und           = '#GetSpds.Und#'>
	<cfset ha            = '#GetSpds.ha#'>
	<cfset spd           = #GetSpds.spd#>
	<cfset ou            = #GetSpds.ou#>  
	<cfset overct        = 0>

	<cfif ha is 'H'>
		<cfset undha = 'A'>
	<cfelse>
		<cfset undha = 'H'>
	</cfif>


	<cfquery datasource="Nba" name="GetFavDef">
	Select *  from NBAPowerSD
	where team = '#fav#'
	and OffDef = 'D'
	and ha = '#ha#'
	</cfquery>

	<cfquery datasource="Nba" name="GetUndOff">
	Select *  from NBAPowerSD
	where team = '#Und#'
	and OffDef = 'O'
	and ha = '#undha#'
	</cfquery>
	

<cfquery datasource="Nba" name="GetFavOff">
	Select *  from NBAPowerSD
	where team = '#fav#'
	and OffDef = 'O'
	and ha = '#ha#'
</cfquery>

<cfquery datasource="Nba" name="GetUndDef">
	Select *  from NBAPowerSD
	where team = '#Und#'
	and OffDef = 'D'
	and ha = '#undha#'
</cfquery>


<cfquery datasource="Nba" name="GetFTPct">
	Select Avg(df.oftpct)/100 as fftpct,Avg(du.oftpct)/100 as uftpct
	from NBAData df, NBAData du 
	where du.team = '#Und#'
		and du.ha = '#undha#'
		and df.ha = '#ha#'
	and df.team = '#fav#'

</cfquery>


<cfquery datasource="Nba" name="GetHealth">
	Select hf.TeamHealth as FavHealth, hu.TeamHealth as UndHealth 
	from  TeamHealth hf, teamhealth hu
	where hf.Team = '#Fav#'
	and hu.Team = '#Und#'
</cfquery>



<cfquery datasource="Nba" name="GetHealth">
	Select FavHealth, UndHealth 
	from  FinalPicks
	where Fav = '#Fav#'
	and Gametime = '#mygametime#'
</cfquery>

<cfquery datasource="Nba" name="GetFavPcts">
	Select *
	from  NBAPcts
	where Team = '#Fav#'
</cfquery>

<cfquery datasource="Nba" name="GetUndPcts">
	Select *
	from  NBAPcts
	where Team = '#Und#'
</cfquery>



<cfset favtot = 0>
<cfset Undtot = 0>
<cfset Diftot = 0>
<cfset gamect = 0>
<cfset Favcov = 0>
<cfset Undcov = 0>
<cfset BetItCtFav = 0>
<cfset BetItCtUnd = 0>


	<cfset Favunder = false>
	<cfset FavOver  = false>

	<cfset Undunder = false>
	<cfset UndOver  = false>

	<!--- 
	* Field Goal PCT
	*
	 --->
	<!--- FAV FGPCT on offense: #GetFavPcts.ofgpct#<br>
	UND FGPCT on defense: #GetUndPcts.dfgpct#<br> --->

	<!--- For offensive stats a mark 50% or more means the offense goes OVER the opponents normal defensive avg --->
	<cfif GetFavPcts.ofgpct ge 50>
		<cfset Favover = true>
		<!--- FAV OVER is true <br> --->
	<cfelse>
		<cfset Favunder = true>
		<!--- FAV UNDER is true<br> --->
	</cfif>	
	
	<cfset FavPct = GetFavPcts.ofgpct>
	<cfif Favunder is true>
		<cfset FavPct = 100 - GetFavPcts.ofgpct>
	</cfif>


	<!--- Favpct = #Favpct#<br> --->
	<cfset ouFavFGPct     = FavPct>
	
	<cfset ouFavFGPctType = 'OVER'>
	<cfif FavUnder is true>
		<cfset ouFavFGPctType = 'UNDER'>
	</cfif>



	<!--- For defensive stats a mark 50% or more means the defense holds the opponent UNDER their normal avg --->
	<cfif GetUndPcts.dfgpct ge 50>
		<cfset Undunder = true>
		<!--- UND UNDER is true <br> --->
	<cfelse>	
		<cfset UndOver = true>
		<!--- UND OVER is true <br> --->
	</cfif>
	
	<cfset UndPct = GetUndPcts.dfgpct>
	<cfif Undunder is false>
		<cfset UndPct = 100 - GetUndPcts.dfgpct>
	</cfif>

	<!--- Undpct = #Undpct#<br> --->
	<cfset ouUnddFGPct     = UndPct>
	
	<cfset ouUnddFGPctType = 'OVER'>
	<cfif UndUnder is true>
		<cfset ouUnddFGPctType = 'UNDER'>
	</cfif>

	<!--- Combine the Off and Def to make a predicted OVER/UNDER --->
	

	<cfset FavPredPct = (FavPct + UndPct)/2>


	<!--- FavOver = #favover#<br>
	FavUnder = #favunder#<br>
	UndOver = #Undover#<br>
	Undnder = #Undunder#<br> --->

	<cfset GameSimFavFGPct  = FavPredPct >
	<cfif FavOver is true>
		<!--- This is an OVER sitiation for FGPCT<br> --->
		<cfset GameSimFavFGPctType = 'OVER' >
	<cfelse>
		<!--- This is an UNDER sitiation for FGPCT<br> --->
		<cfset GameSimFavFGPctType = 'UNDER' >
	</cfif>
	


	<!--- 
	* Field Goal Attempts
	*
	 --->

	<cfset Favunder = false>
	<cfset FavOver  = false>

	<cfset Undunder = false>
	<cfset UndOver  = false>


	<!--- For offensive stats a mark 50% or more means the offense goes OVER the opponents normal defensive avg --->
	<cfif GetFavPcts.ofga ge 50>
		<cfset Favover = true>

	<cfelse>
		<cfset Favunder = true>

	</cfif>	
	
	<cfset FavPct = GetFavPcts.ofga>
	<cfif Favunder is true>
		<cfset FavPct = 100 - GetFavPcts.ofga>
	</cfif>


	<cfset ouFavFGA     = FavPct>
	
	<cfset ouFavFGAType = 'OVER'>
	<cfif FavUnder is true>
		<cfset ouFavFGAType = 'UNDER'>
	</cfif>



	<cfset ouFavFGPct     = FavPct>
	
	<cfset ouFavFGPctType = 'OVER'>
	<cfif FavUnder is true>
		<cfset ouFavFGPctType = 'UNDER'>
	</cfif>



	<!--- For defensive stats a mark 50% or more means the defense holds the opponent UNDER their normal avg --->
	<cfif GetUndPcts.dfga ge 50>
		<cfset Undunder = true>
	
	<cfelse>	
		<cfset UndOver = true>
	
	</cfif>
	
	<cfset UndPct = GetUndPcts.dfga>
	<cfif Undunder is false>
		<cfset UndPct = 100 - GetUndPcts.dfga>
	</cfif>
	
	
	<cfset ouUnddFGA     = UndPct>
	
	<cfset ouUnddFGAType = 'OVER'>
	<cfif UndUnder is true>
		<cfset ouUnddFGAType = 'UNDER'>
	</cfif>

	

	<!--- Combine the Off and Def to make a predicted OVER/UNDER --->
	
	<cfset FavPredPct = (FavPct + UndPct)/2>

	<cfset GameSimFavFGA  = FavPredPct >
	<cfif FavOver is true>
		
		<cfset GameSimFavFGAType = 'OVER' >
	<cfelse>
		
		<cfset GameSimFavFGAType = 'UNDER' >
	</cfif>
	





	<!--- 
	* Free Throw Attempts
	*
	 --->

	<cfset Favunder = false>
	<cfset FavOver  = false>

	<cfset Undunder = false>
	<cfset UndOver  = false>

	<!--- For offensive stats a mark 50% or more means the offense goes OVER the opponents normal defensive avg --->
	<cfif GetFavPcts.ofta ge 50>
		<cfset Favover = true>

	<cfelse>
		<cfset Favunder = true>

	</cfif>	
	
	<cfset FavPct = GetFavPcts.ofta>
	<cfif Favunder is true>
		<cfset FavPct = 100 - GetFavPcts.ofta>
	</cfif>


	<cfset ouFavFTA     = FavPct>
	
	<cfset ouFavFTAType = 'OVER'>
	<cfif FavUnder is true>
		<cfset ouFAVFTAType = 'UNDER'>
	</cfif>



	<!--- For defensive stats a mark 50% or more means the defense holds the opponent UNDER their normal avg --->
	<cfif GetUndPcts.dfta ge 50>
		<cfset Undunder = true>
	
	<cfelse>	
		<cfset UndOver = true>
	
	</cfif>
	
	<cfset UndPct = GetUndPcts.dfta>
	<cfif Undunder is false>
		<cfset UndPct = 100 - GetUndPcts.dfta>
	</cfif>
	

	<cfset ouUnddFTA     = UndPct>
	
	<cfset ouUnddFTAType = 'OVER'>
	<cfif UndUnder is true>
		<cfset ouUnddFTAType = 'UNDER'>
	</cfif>



	<!--- Combine the Off and Def to make a predicted OVER/UNDER --->
	

	<cfset FavPredPct = (FavPct + UndPct)/2>

	<cfset GameSimFavFtA  = FavPredPct >
	<cfif FavOver is true>
		
		<cfset GameSimFavFtAType = 'OVER' >
	<cfelse>
		
		<cfset GameSimFavFtAType = 'UNDER' >
	</cfif>






	<!--- 
	* Three Point Attempts
	*
	 --->

	<cfset Favunder = false>
	<cfset FavOver  = false>

	<cfset Undunder = false>
	<cfset UndOver  = false>


	<!--- For offensive stats a mark 50% or more means the offense goes OVER the opponents normal defensive avg --->
	<cfif GetFavPcts.otpa ge 50>
		<cfset Favover = true>

	<cfelse>
		<cfset Favunder = true>

	</cfif>	
	
	<cfset FavPct = GetFavPcts.otpa>
	<cfif Favunder is true>
		<cfset FavPct = 100 - GetFavPcts.otpa>
	</cfif>


	<cfset ouFAVTpa     = FavPct>
	
	<cfset ouFavTpaType = 'OVER'>
	<cfif FavUnder is true>
		<cfset ouFavTPAType = 'UNDER'>
	</cfif>


	<!--- For defensive stats a mark 50% or more means the defense holds the opponent UNDER their normal avg --->
	<cfif GetUndPcts.dtpa ge 50>
		<cfset Undunder = true>
	
	<cfelse>	
		<cfset UndOver = true>
	
	</cfif>
	
	<cfset UndPct = GetUndPcts.dtpa>
	<cfif Undunder is false>
		<cfset UndPct = 100 - GetUndPcts.dtpa>
	</cfif>
	

	<cfset ouUnddTPA     = UndPct>
	
	<cfset ouUnddTPAType = 'OVER'>
	<cfif UndUnder is true>
		<cfset ouUnddTPAType = 'UNDER'>
	</cfif>


	<!--- Combine the Off and Def to make a predicted OVER/UNDER --->
	

	<cfset FavPredPct = (FavPct + UndPct)/2>

	<cfset GameSimFavTPA  = FavPredPct >
	<cfif FavOver is true>
		
		<cfset GameSimFavTPAType = 'OVER' >
	<cfelse>
		
		<cfset GameSimFavTPAType = 'UNDER' >
	</cfif>




















<!--- Underdog Stats --->
	<!--- 
	* Field Goal PCT
	*
	 --->
	<cfset Favunder = false>
	<cfset FavOver  = false>

	<cfset Undunder = false>
	<cfset UndOver  = false>


	<!--- For offensive stats a mark 50% or more means the offense goes OVER the opponents normal defensive avg --->
	<cfif GetUndPcts.ofgpct ge 50>
		<cfset Favover = true>

	<cfelse>
		<cfset Favunder = true>

	</cfif>	
	
	<cfset UndPct = GetUndPcts.ofgpct>
	<cfif Undunder is true>
		<cfset UndPct = 100 - GetUndPcts.ofgpct>
	</cfif>

	<cfset ouUndFGPct     = UndPct>
	
	<cfset ouUndFGPctType = 'OVER'>
	<cfif UndUnder is true>
		<cfset ouUndFGPctType = 'UNDER'>
	</cfif>



	<!--- For defensive stats a mark 50% or more means the defense holds the opponent UNDER their normal avg --->
	<cfif GetFavPcts.dfgpct ge 50>
		<cfset Favunder = true>
	
	<cfelse>	
		<cfset FavOver = true>
	
	</cfif>
	
	<cfset FavPct = GetFavPcts.dfgpct>
	<cfif Favunder is false>
		<cfset FavPct = 100 - GetFavPcts.dfgpct>
	</cfif>
	
	<cfset ouFavdFGPct     = FavPct>
	
	<cfset ouFavdFGPctType = 'OVER'>
	<cfif FavUnder is true>
		<cfset ouFavdFGPctType = 'UNDER'>
	</cfif>

	

	<!--- Combine the Off and Def to make a predicted OVER/UNDER --->
	

	<cfset UndPredPct = (FavPct + UndPct)/2>

	<cfset GameSimUndFGPct  = UndPredPct >
	<cfif UndOver is true>
		
		<cfset GameSimUndFGPCTType = 'OVER' >
	<cfelse>
		
		<cfset GameSimUndFGPCTType = 'UNDER' >
	</cfif>



	<!--- 
	* Field Goal Atts
	*
	 --->

	<cfset Favunder = false>
	<cfset FavOver  = false>

	<cfset Undunder = false>
	<cfset UndOver  = false>

	
	<!--- For offensive stats a mark 50% or more means the offense goes OVER the opponents normal defensive avg --->
	<cfif GetUndPcts.ofga ge 50>
		<cfset Undover = true>

	<cfelse>
		<cfset Undunder = true>

	</cfif>	
	
	<cfset UndPct = GetUndPcts.ofga>
	<cfif Undunder is true>
		<cfset UndPct = 100 - GetUndPcts.ofga>
	</cfif>


	<cfset ouUndFGA     = UndPct>
	
	<cfset ouUndFGAType = 'OVER'>
	<cfif UndUnder is true>
		<cfset ouUnddFGPctType = 'UNDER'>
	</cfif>



	<!--- For defensive stats a mark 50% or more means the defense holds the opponent UNDER their normal avg --->
	<cfif GetFavPcts.dfga ge 50>
		<cfset Favunder = true>
	
	<cfelse>	
		<cfset FavOver = true>
	
	</cfif>
	
	<cfset FavPct = GetFavPcts.dfga>
	<cfif Favunder is false>
		<cfset FavPct = 100 - GetFavPcts.dfga>
	</cfif>
	
	<cfset ouFavdFGA     = UndPct>
	
	<cfset ouFavdFGAType = 'OVER'>
	<cfif FavUnder is true>
		<cfset ouFavdFGAType = 'UNDER'>
	</cfif>


	<!--- Combine the Off and Def to make a predicted OVER/UNDER --->
	

	<cfset UndPredPct = (FavPct + UndPct)/2>

	<cfset GameSimUndFGA  = UndPredPct >
	<cfif UndOver is true>
		
		<cfset GameSimUndFGAType = 'OVER' >
	<cfelse>
		
		<cfset GameSimUndFGAType = 'UNDER' >
	</cfif>

	
	
	



	<!--- 
	* FTA
	*
	 --->

	<cfset Favunder = false>
	<cfset FavOver  = false>

	<cfset Undunder = false>
	<cfset UndOver  = false>


	<!--- For offensive stats a mark 50% or more means the offense goes OVER the opponents normal defensive avg --->
	<cfif GetUndPcts.ofta ge 50>
		<cfset Undover = true>

	<cfelse>
		<cfset Undunder = true>

	</cfif>	
	
	<cfset UndPct = GetUndPcts.ofta>
	<cfif Undunder is true>
		<cfset UndPct = 100 - GetUndPcts.ofta>
	</cfif>

	<cfset ouUndFTA     = UndPct>
	
	<cfset ouUndFTAType = 'OVER'>
	<cfif UndUnder is true>
		<cfset ouUndFTAType = 'UNDER'>
	</cfif>



	<!--- For defensive stats a mark 50% or more means the defense holds the opponent UNDER their normal avg --->
	<cfif GetFavPcts.dfta ge 50>
		<cfset Favunder = true>
	
	<cfelse>	
		<cfset FavOver = true>
	
	</cfif>
	
	<cfset FavPct = GetFavPcts.dfta>
	<cfif Favunder is false>
		<cfset FavPct = 100 - GetFavPcts.dfta>
	</cfif>
	
	<cfset ouFavdFTA     = FavPct>
	
	<cfset ouFAVdFTAType = 'OVER'>
	<cfif FavUnder is true>
		<cfset ouFavdFTAType = 'UNDER'>
	</cfif>


	<!--- Combine the Off and Def to make a predicted OVER/UNDER --->
	

	<cfset UndPredPct = (FavPct + UndPct)/2>

	<cfset GameSimUndFTA  = UndPredPct >
	<cfif UndOver is true>
		
		<cfset GameSimUndFTAType = 'OVER' >
	<cfelse>
		
		<cfset GameSimUndFTAType = 'UNDER' >
	</cfif>





	<!--- 
	* TPA
	*
	 --->

	<cfset Favunder = false>
	<cfset FavOver  = false>

	<cfset Undunder = false>
	<cfset UndOver  = false>

	<!--- For offensive stats a mark 50% or more means the offense goes OVER the opponents normal defensive avg --->
	<cfif GetUndPcts.otpa ge 50>
		<cfset Undover = true>

	<cfelse>
		<cfset Undunder = true>

	</cfif>	
	
	<cfset UndPct = GetUndPcts.otpa>
	<cfif Undunder is true>
		<cfset UndPct = 100 - GetUndPcts.otpa>
	</cfif>

	<cfset ouUndTPA     = UndPct>
	
	<cfset ouUndTPAType = 'OVER'>
	<cfif UndUnder is true>
		<cfset ouUndTPAType = 'UNDER'>
	</cfif>



	<!--- For defensive stats a mark 50% or more means the defense holds the opponent UNDER their normal avg --->
	<cfif GetFavPcts.dtpa ge 50>
		<cfset Favunder = true>
	
	<cfelse>	
		<cfset FavOver = true>
	
	</cfif>
	
	<cfset FavPct = GetFavPcts.dtpa>
	<cfif Favunder is false>
		<cfset FavPct = 100 - GetFavPcts.dtpa>
	</cfif>
	

	<cfset ouFavdTPA     = UndPct>
	
	<cfset ouFavdTPAType = 'OVER'>
	<cfif UndUnder is true>
		<cfset ouFavdTPAType = 'UNDER'>
	</cfif>


	<!--- Combine the Off and Def to make a predicted OVER/UNDER --->
	

	<cfset UndPredPct = (FavPct + UndPct)/2>

	<cfset GameSimUndTPA  = UndPredPct >
	<cfif UndOver is true>
		
		<cfset GameSimUndTPAType = 'OVER' >
	<cfelse>
		
		<cfset GameSimUndTPAType = 'UNDER' >
	</cfif>







<!--- #fav# vs #und#<br> --->
<!--- GamesimeFAVFGAType = #GamesimFAVFGAType#<br>
GamesimeFAVFGA     = #GamesimFAVFGA#<br>
GamesimeUNDFGAType = #GamesimUNDFGAType#<br>
GamesimeUNDFGA     = #GamesimUNDFGA#<br>
<p>
GamesimeFAVFGPctType = #GamesimFAVFGPctType#<br>
GamesimeFAVFGPct     = #GamesimFAVFGPct#<br>
GamesimeUNDFGPctType = #GamesimUNDFGPctType#<br>
GamesimeUNDFGPct     = #GamesimUNDFGPct#<br>
<p>
GamesimeFAVFTAType = #GamesimFAVFTAType#<br>
GamesimeFAVFTA     = #GamesimFAVFTA#<br>
GamesimeUNDFTAType = #GamesimUNDFTAType#<br>
GamesimeUNDFTA     = #GamesimUNDFTA#<br>
<p>
GamesimeFAVTPAType = #GamesimFAVTPAType#<br>
GamesimeFAVTPA     = #GamesimFAVTPA#<br>
GamesimeUNDTPAType = #GamesimUNDTPAType#<br>
GamesimeUNDTPA     = #GamesimUNDTPA#<br> --->
<!--- 
<hr>
ouFavoFGA = #ouFavFGA# - #ouFavFGAType#<br>
ouFavoTPA = #ouFavTPA# - #ouFavTPAType#<br>
ouFavoFTA = #ouFavFTA# - #ouFavFTAType#<br>

ouFavdFGA = #ouFavdFGA# - #ouFavdFGAType#<br>
ouFavdTPA = #ouFavdTPA# - #ouFavdTPAType#<br>
ouFavdFTA = #ouFavdFTA# - #ouFavdFTAType#<br>

ouUndoFGA = #ouUndFGA# - #ouUndFGAType#<br>
ouUndoTPA = #ouUndTPA# - #ouUndTPAType#<br>
ouUndoFTA = #ouUndFTA# - #ouUndFTAType#<br>

ouUnddFGA = #ouUnddFGA# - #ouUnddFGAType#<br>
ouUnddTPA = #ouUnddTPA# - #ouUndTPAType#<br>
ouUnddFTA = #ouUnddFTA# - #ouUnddFTAType#<br>
<hr>
 --->






<!--- 
ouFavoFGA = #ouFavFGA# - #ouFavFGAType#<br>
ouFavoTPA = #ouFavTPA# - #ouFavTPAType#<br>
ouFavoFTA = #ouFavFTA# - #ouFavFTAType#<br>

ouFavdFGA = #ouFavdFGA# - #ouFavdFGAType#<br>
ouFavdTPA = #ouFavdTPA# - #ouFavdTPAType#<br>
ouFavdFTA = #ouFavdFTA# - #ouFavdFTAType#<br>

ouUndoFGA = #ouUndFGA# - #ouUndFGAType#<br>
ouUndoTPA = #ouUndTPA# - #ouUndTPAType#<br>
ouUndoFTA = #ouUndFTA# - #ouUndFTAType#<br>

ouUnddFGA = #ouUnddFGA# - #ouUnddFGAType#<br>
ouUnddTPA = #ouUnddTPA# - #ouUndTPAType#<br>
ouUnddFTA = #ouUnddFTA# - #ouUnddFTAType#<br>
 --->


	<cfloop index="xx" from="1" to="1100">
	
	<!--- Create Gamesim Stat for Fav Def FGA --->
	<cfinvoke method="createSimStat" 
	component       = "NumericFunctions"	
	BaseStat        = #GetFavDef.MedFGA#
	StandardDevVal  = #GetFavDef.FGA#
	StatPct         = #ouFavdFGA#
	OverUnder       = '#ouFavFGAType#'	
	returnvariable  = "gsFavDefFGA"			
	>


	<!--- Create Gamesim Stat for Und Off FGA --->
	<cfinvoke method="createSimStat" 
	component       = "NumericFunctions"	
	BaseStat        = #GetUndOff.MedFGA#
	StandardDevVal  = #GetUndOff.FGA#	
	StatPct         = #ouUndFGA#
	OverUnder       = '#ouUndFGAType#'	
	returnvariable  = "gsUndOffFGA"			
	>

	<cfset UndFGA    = (gsFavDefFGA + gsUndOffFGA)/2>


	<!--- Create Gamesim Stat for Fav Def 2pt --->
	<cfinvoke method="createSimStat" 
	component       = "NumericFunctions"	
	BaseStat        = #GetFavDef.Medtwopt#
	StandardDevVal  = #GetFavDef.twopt#		
	StatPct         = #ouFavdFGPct#
	OverUnder       = '#ouFavdFGPctType#'	
	returnvariable  = "gsFavDef2pt"			
	>

	<!--- Create Gamesim Stat for Und Off 2pt --->
	<cfinvoke method="createSimStat" 
	component       = "NumericFunctions"	
	BaseStat        = #GetUndOff.Medtwopt#
	StandardDevVal  = #GetUndOff.twopt#		
	StatPct         = #ouUndFGPct#
	OverUnder       = '#ouUndFGPctType#'	
	returnvariable  = "gsUndOff2pt"			
	>

	<cfset Und2ptPct = (gsFavDef2pt + gsUndOff2pt)/2>


	<!--- Create Gamesim Stat for Fav Def 3pt --->
	<cfinvoke method="createSimStat" 
	component       = "NumericFunctions"	
	BaseStat        = #GetFavDef.Medthreept#
	StandardDevVal  = #GetFavDef.threept#		
	StatPct         = #ouFavdTPA#
	OverUnder       = '#ouFavdTPAType#'	
	returnvariable  = "gsFavDef3pt"			
	>

	<!--- Create Gamesim Stat for Und Off 3pt --->
	<cfinvoke method="createSimStat" 
	component       = "NumericFunctions"	
	BaseStat        = #GetUndOff.Medthreept#
	StandardDevVal  = #GetUndOff.threept#		
	StatPct         = #ouUndTPA#
	OverUnder       = '#ouUndTPAType#'	
	returnvariable  = "gsUndOff3pt"			
	>
	
	<cfset Und3ptPct = (gsFavDef3pt + gsUndOff3pt)/2>


	<!--- Create Gamesim Stat for Fav Def FTA --->
	<cfinvoke method="createSimStat" 
	component       = "NumericFunctions"	
	BaseStat        = #GetFavDef.MedFTA#
	StandardDevVal  = #GetFavDef.FTA#		
	StatPct         = #ouFavdFTA#
	OverUnder       = '#ouFavdFTAType#'	
	returnvariable  = "gsFavDefFTA"			
	>

	<!--- Create Gamesim Stat for Und Off FTA --->
	<cfinvoke method="createSimStat" 
	component       = "NumericFunctions"	
	BaseStat        = #GetUndOff.MedFTA#
	StandardDevVal  = #GetUndOff.FTA#
	StatPct         = #ouUNDFTA#
	OverUnder       = '#ouUndFTAType#'	
	returnvariable  = "gsUndOffFTA"			
	>

	<cfset UndFTA    = (gsFavDefFTA + gsUndOffFTA)/2>


	<!--- Create Gamesim Stat for Und Def FGA --->
	<cfinvoke method="createSimStat" 
	component       = "NumericFunctions"	
	BaseStat        = #GetUndDef.MedFGA#
	StandardDevVal  = #GetUndDef.FGA#		
	StatPct         = #ouUnddFGA#
	OverUnder       = '#ouUnddFGAType#'	
	returnvariable  = "gsUndDefFGA"			
	>

	<!--- Create Gamesim Stat for Fav Off FGA --->
	<cfinvoke method="createSimStat" 
	component       = "NumericFunctions"	
	BaseStat        = #GetFavOff.MedFGA#
	StandardDevVal  = #GetFavOff.FGA#
	StatPct         = #ouFavFGA#
	OverUnder       = '#ouFavFGAType#'	
	returnvariable  = "gsFavOffFGA"			
	>

	<cfset FavFGA    = (gsUndDefFGA + gsFavOffFGA)/2>


	<!--- Create Gamesim Stat for Und Def 2pt --->
	<cfinvoke method="createSimStat" 
	component       = "NumericFunctions"	
	BaseStat        = #GetUndDef.Medtwopt#
	StandardDevVal  = #GetUndDef.twopt#		
	StatPct         = #ouUnddFGPct#
	OverUnder       = '#ouUnddFGpctType#'	
	returnvariable  = "gsUndDef2pt"			
	>

	<!--- Create Gamesim Stat for Fav Off 2pt --->
	<cfinvoke method="createSimStat" 
	component       = "NumericFunctions"	
	BaseStat        = #GetFavOff.Medtwopt#
	StandardDevVal  = #GetFavOff.twopt#		
	StatPct         = #ouFavFGPct#
	OverUnder       = '#ouFavFGPCTType#'	
	returnvariable  = "gsFavOff2pt"			
	>

	<cfset Fav2ptPct = (gsUndDef2pt + gsFavOff2pt)/2>


	<!--- Create Gamesim Stat for Und Def 3pt --->
	<cfinvoke method="createSimStat" 
	component       = "NumericFunctions"	
	BaseStat        = #GetUndDef.Medthreept#
	StandardDevVal  = #GetUndDef.threept#
	StatPct         = #ouUnddTPA#
	OverUnder       = '#ouUnddTPAType#'	
	returnvariable  = "gsUndDef3pt"			
	>

	<!--- Create Gamesim Stat for Fav Off 3pt --->
	<cfinvoke method="createSimStat" 
	component       = "NumericFunctions"	
	BaseStat        = #GetFavOff.Medthreept#
	StandardDevVal  = #GetFavOff.threept#		
	StatPct         = #ouFavTPA#
	OverUnder       = '#ouFavTPAType#'	
	returnvariable  = "gsFavOff3pt"			
	>
	
	<cfset Fav3ptPct = (gsUndDef3pt + gsFavOff3pt)/2>


	<!--- Create Gamesim Stat for Und Def FTA --->
	<cfinvoke method="createSimStat" 
	component       = "NumericFunctions"	
	BaseStat        = #GetUndDef.MedFTA#
	StandardDevVal  = #GetUndDef.FTA#
	StatPct         = #ouUnddFTA#
	OverUnder       = '#ouUnddFTAType#'	
	returnvariable  = "gsUndDefFTA"			
	>

	<!--- Create Gamesim Stat for Fav Off FTA --->
	<cfinvoke method="createSimStat" 
	component       = "NumericFunctions"	
	BaseStat        = #GetFavOff.MedFTA#
	StandardDevVal  = #GetFavOff.FTA#
	StatPct         = #ouFavFTA#
	OverUnder       = '#ouFavFTAType#'	
	returnvariable  = "gsFavOffFTA"			
	>

	<cfset FavFTA    = (gsUndDefFTA + gsFavOffFTA)/2>

<cfset FavPred2pt = 2*(FavFGA*(Fav2ptPct/100))>
<cfset FavPred3pt = 3*(FavFGA*(Fav3ptPct/100))>
<cfset FavPredFT  = 1*(FavFTA*GetFTPct.fftpct)>
<cfset FavFinal = FavPred2pt + FavPred3pt + FavPredFT >

<cfset UndPred2pt = 2*(UndFGA*(Und2ptPct/100))>
<cfset UndPred3pt = 3*(UndFGA*(Und3ptPct/100))>
<cfset UndPredFT  = 1*(UndFTA*GetFtPct.Uftpct)>
<cfset UndFinal = UndPred2pt + UndPred3pt + UndPredFT >


<cfset favtot = favtot + FavFinal>
<cfset Undtot = Undtot + UndFinal>
<cfset Diftot = Diftot  + (FavFinal - UndFinal)>
<cfset ourspd = FavFinal - UndFinal>

<!--- FavFinal = #Favfinal#<br>
UndFinal = #Undfinal#<br> 
Our Spd = #ourspd#<br>
Vegas Spd = #spd#<br> --->
<cfif ourspd neq #spd#>

	<cfset gamect = gamect + 1>
	<cfif ourspd gt #spd#>
	
		<!--- Ourspd is bigger<br> --->
		<cfset FavCov = FavCov + 1>
		
		<cfif abs(Ourspd - #spd#) gt 4>
			<cfset BetitctFav = betitctFav + 1>
			<!--- Our spd is bigger than 4 points<br> --->
		</cfif>
		<!--- We like the Favorite<br> --->
	<cfelse>
	
		<cfif FavFinal lt UndFinal>
			<!--- UPSET!!! --->
			<cfset UndCov = UndCov + 1>
			<cfif abs(spd - Ourspd) gt 4>
				<!--- Our spd is bigger than 4 points<br> --->
				<cfset BetitctUnd = betitctUnd + 1>
			</cfif>
			<!--- We like the Underdog<br> --->
		<cfelse>
		
			<!--- Ourspd is LESS<br> --->
			<cfset UndCov = UndCov + 1>
			<cfif abs(spd - Ourspd) gt 5>
				<!--- Our spd is bigger than 4 points<br> --->
				<cfset BetitctUnd = betitctUnd + 1>
			</cfif>
			<!--- We like the Underdog<br> --->
		</cfif>	
	</cfif>
	
	

</cfif>
<!--- *********************<br>
Favcov = #FavCov#<br>
Undcov = #UndCov#<br>
*********************<br> --->

<!--- <hr>

#fav#: #FavFinal#<br>
#Und# #UndFinal#<br>
#favfinal - undfinal#....#spd#<br>
#favfinal + undfinal#<br>
<cfif abs(GetSpds.spd - (favfinal - undfinal)) ge 4>
****** Potential Play<br>
</cfif>

<cfif abs(GetSpds.spd - (favfinal - undfinal)) ge 6>
****** Super Potential Play<br>
</cfif>

<hr> --->

</cfloop>
<tr>
<td>
#fav#
</td>
<td>
#Numberformat(favtot/gamect,'999.99')#
</td>
<td>
#und#
</td>
<td>
#Numberformat(undtot/gamect,'999.99')#
</td>
<td>
#Numberformat(Diftot/gamect,'999.99')#
</td>

<td>
#spd#
</td>

<td>
#Numberformat((favtot/gamect + undtot/gamect),'99.9')#
</td>

<td>
#ou#
</td>

<cfif FavCov gt UndCov>
	<td>
	#fav#
	</td>	
	
	<td>
	#numberformat(100*(FavCov/Gamect),'999.99')#
	</td>	
	
	<td>
	#Numberformat(100*(BetitCtFav/Gamect),'999.99')#
	</td>		
	
	<cfif 100*(BetitCtFav/Gamect) ge 50>
	<td bgcolor="Green">
	Bet on #fav#
	</td>	
	<cfelse>
	<td>No Bet</td>
	</cfif>
<!--- 
Fav covers #100*(FavCov/Gamect)#<br>
Bet On It Pct #100*(BetitCtFav/Gamect)# --->
<cfelse>
	<!--- Und covers #100*(UndCov/Gamect)#<br>
	Bet On It Pct #100*(BetitCtUnd/Gamect)# --->
	<td>
	#und#
	</td>	
	
	<td>
	#Numberformat(100*(UndCov/Gamect),'999.99')#
	</td>	
	
	<td>
	#Numberformat(100*(BetitCtUnd/Gamect),'999.99')#
	</td>		
	
	<cfif 100*(BetitCtUnd/Gamect) ge 50>
	
	<td bgcolor="Green">
	Bet on #und#
	</td>	
	<cfelse>
	<td>No Bet</td>
	</cfif>
</cfif>
</tr>
<!--- After #gamect# sims:<br>
#fav#: #favtot/gamect#<br>
#und#: #undtot/gamect#<br>
Spd: #Diftot/gamect#<br>
Vegas Spd: #spd#<br>
Our Total: #(favtot/gamect + undtot/gamect)#<br>
Vegas Total #ou#<br>  

<cfif FavCov gt UndCov>
Fav covers #100*(FavCov/Gamect)#<br>
Bet On It Pct #100*(BetitCtFav/Gamect)#
<cfelse>
Und covers #100*(UndCov/Gamect)#<br>
Bet On It Pct #100*(BetitCtUnd/Gamect)#
</cfif>
<hr> --->

<cfset favpredsc = favtot/gamect >
<cfset undpredsc = undtot/gamect >

<!--- 
<cfquery datasource="NBA">
Insert into PredVsActual(Gametime,HA,Team,PredScore,Health) values ('#mygametime#','#ha#','#fav#',#favpredsc#,#GetHealth.FavHealth#)
</cfquery>

<cfquery datasource="NBA">
Insert into PredVsActual(Gametime,HA,Team,PredScore,Health) values ('#mygametime#','#undha#','#und#',#undpredsc#,#GetHealth.UndHealth#)
</cfquery>
 --->
</tr>
</cfoutput>
</table>
