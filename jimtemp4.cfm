<cftry>

<cfquery datasource="Nba" name="GetRunct">
	Select RunCt,Gametime
	from NBAGameTime
</cfquery>

<cfset mygametime = "#GetRunCt.gametime#">

<cfquery  name="GetGames" datasource="NBA">
Select * from NBASchedule where trim(gametime) = '#mygametime#'
</cfquery>

<cfloop query="GetGames">
	
	<cfset myfav = GetGames.fav>
	<cfset myund = GetGames.und>
	
	<cfquery datasource="nba" name="GetStats">
	Select * from ImportantStatPreds where fav = '#myfav#' and gametime = '#mygametime#' 
	</cfquery>

	<cfoutput query="GetStats">
	
	<cfset FavPts = 0> 
	<cfif (FGpctAdv is TPMAdv) and (RebAdv is FgPctAdv) and (FTMAdv is fgpctAdv) and Fgpctadv is '#myfav#'>
		<cfset FavPts = 10> 
	</cfif>

	<cfset UndPts = 0> 
	<cfif (fgpctAdv is TPMAdv) and (RebAdv is FgPctAdv) and (FTMAdv is fgpctAdv) and Fgpctadv is '#myund#'>
		<cfset UndPts = 10> 
	</cfif>
	
	<cfif fgpctAdv is '#myfav#' and fgpct60>
		<cfset FavPts = Favpts + 5>
	</cfif>
	
	<cfif tpmAdv is '#myfav#' and tpm60>
		<cfset FavPts = Favpts + 4>
	</cfif>

	<cfif rebAdv is '#myfav#' and reb60>
		<cfset FavPts = Favpts + 3>
	</cfif>

	<cfif ftmAdv is '#myfav#' and ftm60>
		<cfset FavPts = Favpts + 2>
	</cfif>
	
	<cfif toAdv is '#myfav#' and to60>
		<cfset FavPts = Favpts + 1>
	</cfif>


	<cfif fgpctAdv is '#myund#' and fgpct60>
		<cfset UndPts = Undpts + 5>
	</cfif>
	
	<cfif tpmAdv is '#myund#' and tpm60>
		<cfset UndPts = Undpts + 4>
	</cfif>

	<cfif rebAdv is '#myund#' and reb60>
		<cfset UndPts = Undpts + 3>
	</cfif>

	<cfif ftmAdv is '#myund#' and ftm60>
		<cfset UndPts = Undpts + 2>
	</cfif>
	
	<cfif toAdv is '#myund#' and to60>
		<cfset UndPts = Undpts + 1>
	</cfif>
	



	<cfif fgpctAdv is '#myfav#' and fgpctbig ge 60>
		<cfset FavPts = Favpts + 5>
	</cfif>
	
	<cfif tpmAdv is '#myfav#' and tpmbig ge 60>
		<cfset FavPts = Favpts + 4>
	</cfif>

	<cfif rebAdv is '#myfav#' and rebbig ge 60>
		<cfset FavPts = Favpts + 3>
	</cfif>

	<cfif ftmAdv is '#myfav#' and ftmbig ge 60>
		<cfset FavPts = Favpts + 2>
	</cfif>
	
	<cfif toAdv is '#myfav#' and tobig ge 60>
		<cfset FavPts = Favpts + 1>
	</cfif>


	<cfif fgpctAdv is '#myund#' and fgpctbig ge 60>
		<cfset UndPts = Undpts + 5>
	</cfif>
	
	<cfif tpmAdv is '#myund#' and tpmbig ge 60>
		<cfset UndPts = Undpts + 4>
	</cfif>

	<cfif rebAdv is '#myund#' and rebbig ge 60>
		<cfset UndPts = Undpts + 3>
	</cfif>

	<cfif ftmAdv is '#myund#' and ftmbig ge 60>
		<cfset UndPts = Undpts + 2>
	</cfif>
	
	<cfif toAdv is '#myund#' and tobig ge 60>
		<cfset UndPts = Undpts + 1>
	</cfif>
	

	<cfquery datasource="NBA" name="AddPicks">
	Update FinalPicks
		Set FavImpStatPts = #favpts#,
			UndImpStatPts = #undpts#
			Where Fav = '#myFav#' 
			and GameTime = '#mygametime#'
	</cfquery>

	<cfif FavPts ge 30>
	<cfquery datasource="NBA" name="AddPicks">
	Update FinalPicks
		Set ThirtyRatFav = '#myfav#'
		Where Fav = '#myFav#' 
		and GameTime = '#mygametime#'
	</cfquery>
	</cfif>


	<cfif FavPts lt UndPts>
	<cfquery datasource="NBA" name="AddPicks">
	Update FinalPicks
		Set UndRatBetter = '#myund#'
		Where Fav = '#myFav#' 
		and GameTime = '#mygametime#'
	</cfquery>
	</cfif>

	
	</cfoutput>
	
</cfloop>

<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('Ran jimtemp4.cfm')
</cfquery>


<cfcatch type="any">
  
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.Detail#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:jimtemp4.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>

</cfcatch>

</cftry>

