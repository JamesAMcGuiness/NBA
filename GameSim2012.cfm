
<!--- Create the Standard Deviations For the stats --->
<cfinclude template="CreatePower2012.cfm"> 

<cfset betthreshold = 5>

<cfquery datasource="Nba" name="GetRunct">
	Select RunCt,Gametime
	from NBAGameTime
</cfquery>

<cfset myGametime = GetRunct.gametime>


<cfquery datasource="nba" name="Getspds">
Select *
from nbaschedule
where GameTime = '#mygametime#'
 </cfquery>

<cfoutput query="GetSpds">

	<cfset fav           = '#GetSpds.Fav#'> 
	<cfset und           = '#GetSpds.Und#'>
	<cfset ha            = '#GetSpds.ha#'>
	<cfset Client.spread = #GetSpds.spd#>
	<cfset myou          = #GetSpds.ou#>  
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



<cfset favtot = 0>
<cfset Undtot = 0>
<cfset Diftot = 0>
<cfset gamect = 0>
<cfset Favcov = 0>
<cfset Undcov = 0>
<cfset BetItCtFav = 0>
<cfset BetItCtUnd = 0>
<hr>

	<cfloop index="xx" from="1" to="1500">
	
	
	
	<!--- Create Gamesim Stat for Fav Def FGA --->
	<cfinvoke method="createSimStat" 
	component       = "NumericFunctions"	
	BaseStat        = #GetFavDef.MedFGA#
	StandardDevVal  = #GetFavDef.FGA#		
	returnvariable  = "gsFavDefFGA"			
	>


	<!--- Create Gamesim Stat for Und Off FGA --->
	<cfinvoke method="createSimStat" 
	component       = "NumericFunctions"	
	BaseStat        = #GetUndOff.MedFGA#
	StandardDevVal  = #GetUndOff.FGA#		
	returnvariable  = "gsUndOffFGA"			
	>

	<cfset UndFGA    = (gsFavDefFGA + gsUndOffFGA)/2>


	<!--- Create Gamesim Stat for Fav Def 2pt --->
	<cfinvoke method="createSimStat" 
	component       = "NumericFunctions"	
	BaseStat        = #GetFavDef.Medtwopt#
	StandardDevVal  = #GetFavDef.twopt#		
	returnvariable  = "gsFavDef2pt"			
	>

	<!--- Create Gamesim Stat for Und Off 2pt --->
	<cfinvoke method="createSimStat" 
	component       = "NumericFunctions"	
	BaseStat        = #GetUndOff.Medtwopt#
	StandardDevVal  = #GetUndOff.twopt#		
	returnvariable  = "gsUndOff2pt"			
	>

	<cfset Und2ptPct = (gsFavDef2pt + gsUndOff2pt)/2>


	<!--- Create Gamesim Stat for Fav Def 3pt --->
	<cfinvoke method="createSimStat" 
	component       = "NumericFunctions"	
	BaseStat        = #GetFavDef.Medthreept#
	StandardDevVal  = #GetFavDef.threept#		
	returnvariable  = "gsFavDef3pt"			
	>

	<!--- Create Gamesim Stat for Und Off 3pt --->
	<cfinvoke method="createSimStat" 
	component       = "NumericFunctions"	
	BaseStat        = #GetUndOff.Medthreept#
	StandardDevVal  = #GetUndOff.threept#		
	returnvariable  = "gsUndOff3pt"			
	>
	
	<cfset Und3ptPct = (gsFavDef3pt + gsUndOff3pt)/2>


	<!--- Create Gamesim Stat for Fav Def FTA --->
	<cfinvoke method="createSimStat" 
	component       = "NumericFunctions"	
	BaseStat        = #GetFavDef.MedFTA#
	StandardDevVal  = #GetFavDef.FTA#		
	returnvariable  = "gsFavDefFTA"			
	>

	<!--- Create Gamesim Stat for Und Off FTA --->
	<cfinvoke method="createSimStat" 
	component       = "NumericFunctions"	
	BaseStat        = #GetUndOff.MedFTA#
	StandardDevVal  = #GetUndOff.FTA#		
	returnvariable  = "gsUndOffFTA"			
	>

	<cfset UndFTA    = (gsFavDefFTA + gsUndOffFTA)/2>




	<!--- Create Gamesim Stat for Und Def FGA --->
	<cfinvoke method="createSimStat" 
	component       = "NumericFunctions"	
	BaseStat        = #GetUndDef.MedFGA#
	StandardDevVal  = #GetUndDef.FGA#		
	returnvariable  = "gsUndDefFGA"			
	>

	<!--- Create Gamesim Stat for Fav Off FGA --->
	<cfinvoke method="createSimStat" 
	component       = "NumericFunctions"	
	BaseStat        = #GetFavOff.MedFGA#
	StandardDevVal  = #GetFavOff.FGA#		
	returnvariable  = "gsFavOffFGA"			
	>

	<cfset FavFGA    = (gsUndDefFGA + gsFavOffFGA)/2>


	<!--- Create Gamesim Stat for Und Def 2pt --->
	<cfinvoke method="createSimStat" 
	component       = "NumericFunctions"	
	BaseStat        = #GetUndDef.Medtwopt#
	StandardDevVal  = #GetUndDef.twopt#		
	returnvariable  = "gsUndDef2pt"			
	>

	<!--- Create Gamesim Stat for Fav Off 2pt --->
	<cfinvoke method="createSimStat" 
	component       = "NumericFunctions"	
	BaseStat        = #GetFavOff.Medtwopt#
	StandardDevVal  = #GetFavOff.twopt#		
	returnvariable  = "gsFavOff2pt"			
	>

	<cfset Fav2ptPct = (gsUndDef2pt + gsFavOff2pt)/2>


	<!--- Create Gamesim Stat for Und Def 3pt --->
	<cfinvoke method="createSimStat" 
	component       = "NumericFunctions"	
	BaseStat        = #GetUndDef.Medthreept#
	StandardDevVal  = #GetUndDef.threept#		
	returnvariable  = "gsUndDef3pt"			
	>

	<!--- Create Gamesim Stat for Fav Off 3pt --->
	<cfinvoke method="createSimStat" 
	component       = "NumericFunctions"	
	BaseStat        = #GetFavOff.Medthreept#
	StandardDevVal  = #GetFavOff.threept#		
	returnvariable  = "gsFavOff3pt"			
	>
	
	<cfset Fav3ptPct = (gsUndDef3pt + gsFavOff3pt)/2>


	<!--- Create Gamesim Stat for Und Def FTA --->
	<cfinvoke method="createSimStat" 
	component       = "NumericFunctions"	
	BaseStat        = #GetUndDef.MedFTA#
	StandardDevVal  = #GetUndDef.FTA#		
	returnvariable  = "gsUndDefFTA"			
	>

	<!--- Create Gamesim Stat for Fav Off FTA --->
	<cfinvoke method="createSimStat" 
	component       = "NumericFunctions"	
	BaseStat        = #GetFavOff.MedFTA#
	StandardDevVal  = #GetFavOff.FTA#		
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
		
		<cfif abs(Ourspd - #spd#) gt betthreshold>
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
			<cfif abs(spd - Ourspd) gt 4>
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


After #gamect# sims:<br>
#fav#: #favtot/gamect#<br>
#und#: #undtot/gamect#<br>
Spd: #Diftot/gamect#<br>
Vegas Spd: #spd#<br>
Our Total: #(favtot/gamect + undtot/gamect)+5#<br>
Vegas Total #ou#<br>  

<cfif FavCov gt UndCov>
Fav covers #100*(FavCov/Gamect)#<br>
Bet On It Pct #100*(BetitCtFav/Gamect)#
<cfelse>
Und covers #100*(UndCov/Gamect)#<br>
Bet On It Pct #100*(BetitCtUnd/Gamect)#
</cfif>
<hr>

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

</cfoutput>
