<cftry>

<cfquery datasource="nba" name="GetInfo">
Select *
from finalpicks
where FGreb = sixtypctimpstat 
and Gamesimavgscore = PIPPick
and Gamesimavgscore = FGReb 
and spd < 10
and FgReb = fav
and FavHealth >= -4
and Whocovered <> 'PUSH'
and gametime >= '20170101'
and UndHealth < -3
order by gametime desc
</cfquery>


<cfquery datasource="nba" name="GetInfo">
Select *
from finalpicks
where sixtypctimpstat = fav
and sixtypctimpstat = PipPick
and spd < 10
and FavHealth >= -4
and Whocovered <> 'PUSH'
and gametime >= '20120101'
and UndHealth < -3
order by gametime desc
</cfquery>

60% Imp Stat and PIP Pick<br>	

<hr>

<cfquery datasource="nba" name="GetInfo">
Select *
from finalpicks
where sixtypctimpstat = fav
and sixtypctimpstat = GameSimAvgScore
and FavHealth >= -4
and Whocovered <> 'PUSH'
and gametime >= '20120101'
and UndHealth < -3
and spd < 10
order by gametime desc
</cfquery>

60% Imp Stat Fav and GameSimAvgScore Pick<br>	


<cfquery datasource="nba" name="GetInfo">
Select *
from finalpicks
where PicksForFav >= 4
and FavHealth >= -4
and Whocovered <> 'PUSH'
and gametime >= '20120101'
and spd < 9
and UndHealth < -3
order by gametime desc
</cfquery>
FAV with 4 or more rating, may have played yest and spd lt 9<br>

<cfquery datasource="nba" name="Getday">
Select *
from nbaGametime
</cfquery>


<cfquery datasource="nba" name="GetInfo">
Select *
from finalpicks
where GameTime = '#GetDay.Gametime#'
</cfquery>



<cfset mygametime = '#GetDay.Gametime#'>

<cfloop query="GetInfo">

	<cfoutput>
	FAV:#GetInfo.fav#	<br>
	UND:#GetInfo.Und#
	<hr>
	</cfoutput>
<cfset myfav = Getinfo.fav>
<cfset myund = Getinfo.und>
<cfset HealthAdvFor = ''>
<cfset HealthAdvAmt = 0>
<cfset SpdLt10      = false>
<cfset SpdLt10plus  = false>

<cfif GetInfo.spd lt 10.5>
	<cfset SpdLt10plus  = true>
</cfif>


<cfif GetInfo.spd lt 10>
	<cfset SpdLt10      = true>
	<cfset SpdLt10plus  = true>
</cfif>

<cfif Getinfo.FavHealthL7 gt GetInfo.UndHealthL7>
	<cfset HealthAdvFor = 'FAV' >
	<cfset HealthAdvAmt = Getinfo.FavHealthl7 - GetInfo.UndHealthL7>
</cfif>

<cfif Getinfo.UndHealthl7 gt GetInfo.FavHealthl7>
	<cfset HealthAdvFor = 'UND' >
	<cfset HealthAdvAmt = Getinfo.UndHealthl7 - GetInfo.FavHealthl7>
</cfif>



<!--- Underdog Unanimous Picks 3+ picks --->
<cfif PicksForFav is 0 and PicksForUnd gte 3>
	<cfquery datasource="nba">
	Update FinalPicks
	Set Sys4 = '#myund#'
	Where gametime = '#mygametime#'
	and Fav = '#myfav#'
	</cfquery>
</cfif>

<!---  FGreb and sixtypctimpstat agree --->
<cfif Getinfo.FGREB is Getinfo.sixtypctimpstat and Getinfo.FGReb gt ''>
	<cfquery datasource="nba">
	Update FinalPicks
	Set Sys1 = '#Getinfo.FGREB#'
	Where gametime = '#mygametime#'
	and Fav = '#myfav#'
	</cfquery>
</cfif>

<!--- Fav SixtypctImpStat agreeing with PIP and spd < 10 No health adv, hlth > -3 --->
<cfif Getinfo.PIPPick is Getinfo.sixtypctimpstat and Getinfo.PIPPick gt '' and spdlt10 is true and FavHealth gt -3>
	<cfquery datasource="nba">
	Update FinalPicks
	Set Sys8 = '#Getinfo.PIPPick#'
	Where gametime = '#mygametime#'
	and Fav = '#myfav#'
	</cfquery>
</cfif>

<!--- Favorite Unanimous Picks rating 3 or more spd < 10  HAdv >=1 --->
<cfif Getinfo.PicksForUnd is 0 and Getinfo.PicksForFav gte 3 and spdlt10 is true and HealthAdvFor is 'FAV' and HealthAdvAmt gte 1>
	<cfquery datasource="nba">
	Update FinalPicks
	Set Sys3 = '#myfav#'
	Where gametime = '#mygametime#'
	and Fav = '#myfav#'
	</cfquery>
</cfif>

<!--- Fav SixtypctImpStat spd < 10 No health ADV --->
<cfif Getinfo.sixtypctimpstat neq '' and spdlt10 is true and Getinfo.sixtypctimpstat is '#myfav#'>
	<cfquery datasource="nba">
	Update FinalPicks
	Set Sys5 = '#myfav#'
	Where gametime = '#mygametime#'
	and Fav = '#myfav#'
	</cfquery>
</cfif>

<cfif HealthAdvFor is 'FAV' and '#Getinfo.sixtypctimpstat#' is '#myfav#'>
<!--- Fav SixtypctImpStat spd < 10 and Health > -2 --->
<cfif Getinfo.sixtypctimpstat neq '' and spdlt10 is true and GetInfo.FavHealth gt -2>
	<cfquery datasource="nba">
	Update FinalPicks
	Set Sys6 = '#Getinfo.sixtypctimpstat#'
	Where gametime = '#mygametime#'
	and Fav = '#myfav#'
	</cfquery>
</cfif>
</cfif>
	
<!--- Fav SixtypctImpStat agreeing with PIP and spd < 10 No Health Adv --->	
<cfif Getinfo.PIPPick is Getinfo.sixtypctimpstat and Getinfo.sixtypctimpstat is '#myfav#'  and Getinfo.PIPPick gt '' and spdlt10 is true>
	<cfquery datasource="nba">
	Update FinalPicks
	Set Sys7 = '#myfav#'
	Where gametime = '#mygametime#'
	and Fav = '#myfav#'
	</cfquery>
</cfif>


<!--- GameSimAvgScore and sixtpctimpstat agree and health > -3 --->
<cfif Getinfo.sixtypctimpstat is '#Getinfo.fav#'>

<cfset checkit = '**' & '#Getinfo.sixtypctimpstat#'>
<cfif (Getinfo.GameSimAvgScore is Getinfo.sixtypctimpstat) or (Getinfo.GameSimAvgScore is '#checkit#') and Getinfo.GameSimAvgScore gt '' and Getinfo.FavHealth gt -3>
	<cfquery datasource="nba">
	Update FinalPicks
	Set Sys23 = '#Getinfo.fav#'
	Where gametime = '#mygametime#'
	and Fav = '#myfav#'
	</cfquery>
</cfif>
</cfif>

<!--- FAV with 4 or more rating, may have played yest and spd 10.5 or less --->
<cfif (Getinfo.PicksForFav ge 4 and SpdLt10plus is true)>
	<cfquery datasource="nba">
	Update FinalPicks
	Set Sys15 = '#Getinfo.fav#'
	Where gametime = '#mygametime#'
	and Fav = '#myfav#'
	</cfquery>
</cfif>


<!--- GameSimAvgScore --->
	<!--- <cfquery datasource="nba">
	Update FinalPicks
	Set Sys24 = '#Getinfo.GameSimAvgScore#'
	Where gametime = '#mygametime#'
	and Fav = '#myfav#'
	</cfquery> --->


<!--- FAV with 4 or more rating, may have played yest, opponent health <= -3 and spd 10.5 or less --->
<cfif (Getinfo.PicksForFav ge 4 and SpdLt10plus is true and Getinfo.UndHealth lte -3)>
	<cfquery datasource="nba">
	Update FinalPicks
	Set Sys16 = '#Getinfo.fav#'
	Where gametime = '#mygametime#'
	and Fav = '#myfav#'
	</cfquery>
</cfif>


<!--- GameSimAvgScore and sixtpctimpstat agree --->
<cfset checkit = '**' & '#Getinfo.sixtypctimpstat#'>
<cfif (Getinfo.GameSimAvgScore is Getinfo.sixtypctimpstat) or (Getinfo.GameSimAvgScore is '#checkit#') and Getinfo.GameSimAvgScore gt ''>
	<cfquery datasource="nba">
	Update FinalPicks
	Set Sys25 = '#Getinfo.fav#'
	Where gametime = '#mygametime#'
	and Fav = '#myfav#'
	</cfquery>
</cfif>



<cfif Len(Getinfo.GAPHA) > 3>
<cfquery datasource="nba">
	Update FinalPicks
	Set Sys29 = '#right(Getinfo.GAPHA,3)#'
	Where gametime = '#mygametime#'
	and Fav = '#myfav#'
	
</cfquery>
</cfif>
<!--- UND with 4 or more rating, may have played yest --->
<cfif (Getinfo.PicksForUnd ge 4)>
	<cfquery datasource="nba">
	Update FinalPicks
	Set Sys17 = '#Getinfo.und#'
	Where gametime = '#mygametime#'
	and Fav = '#myfav#'
	</cfquery>
</cfif>

<!--- Und with ImportStat Predicted win on FGPCT, not played yesterday and spd ge 5 --->
<cfif Getinfo.UndPlayedYest is 'N' and Getinfo.spd gte 5>
<cfquery name="GetIS" datasource="nba">
Select Und from ImportantStatPreds
where gametime = '#mygametime#'
and FgPctAdv = '#myund#'
</cfquery>

<cfif GetIS.recordcount gt 0>
	<cfquery datasource="nba">
	Update FinalPicks
	Set Sys20 = '#Getinfo.und#'
	Where gametime = '#mygametime#'
	and Fav = '#myfav#'
	</cfquery>
</cfif>
</cfif>


<!--- Und SixtypctImpStat No Helath Advantage and playing HOME getting 3.5 or more --->
<cfif Getinfo.sixtypctimpstat is '#Getinfo.und#' and GetInfo.ha is 'A' and GetInfo.spd gte 3.5>
	<cfquery datasource="nba">
	Update FinalPicks
	Set Sys10 = '#myund#'
	Where gametime = '#mygametime#'
	and Fav = '#myfav#'
	</cfquery>
</cfif>

<!--- Und SixtypctImpStat No Helath Advantage and playing HOME getting 3.5 or more --->
<cfif Len(Getinfo.Gamesimavgscore) gt 3>
	<cfquery datasource="nba">
	Update FinalPicks
	Set Sys30 = '#Right(Getinfo.GamesimAvgScore,3)#'
	Where gametime = '#mygametime#'
	and Fav = '#myfav#'
	</cfquery>
</cfif>

	<cfquery datasource="nba">
	Update FinalPicks
	Set Sys0 = GameSimAvgScore
	Where gametime = '#mygametime#'
	and Fav = '#myfav#'
	</cfquery>

	<cfif right(GameSimAvgScore,3) is '#myfav#'>

		<cfquery datasource="nba">
		Update FinalPicks
		Set Sys101 = '#myund#'
		Where gametime = '#mygametime#'
		and Fav = '#myfav#'
		</cfquery>

	</cfif>


	<cfif right(GameSimAvgScore,3) is '#myund#'>

		<cfquery datasource="nba">
		Update FinalPicks
		Set Sys101 = '#myfav#'
		Where gametime = '#mygametime#'
		and Fav = '#myfav#'
		</cfquery>

	</cfif>



    <cfif FavHealth lte -3 and UndHealth is 0>
		<cfquery datasource="nba">
		Update FinalPicks
		Set Sys13 = '#myund#'
		Where gametime = '#mygametime#'
		and Fav = '#myfav#'
		</cfquery>
	</cfif>

    <cfif UndHealth lte -3 and FavHealth is 0>
		<cfquery datasource="nba">
		Update FinalPicks
		Set Sys13 = '#myfav#'
		Where gametime = '#mygametime#'
		and Fav = '#myfav#'
		</cfquery>
	</cfif>

	<!--- Play against favorite if conseqrdct > 4 and is HOME --->
<cfif Getinfo.FavConseqRdCt gt 4 and GetInfo.ha is 'H'>
	<cfquery datasource="nba">
	Update FinalPicks
	Set Sys31 = '#myund#'
	Where gametime = '#mygametime#'
	and Fav = '#myfav#'
	</cfquery>
</cfif> 

<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('UpdateSysx1.cfm')
</cfquery>

<cfif 1 is 1>	

<cfinclude template="createSPOTRatings.cfm">	
	
<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('UpdateSysx2.cfm')
</cfquery>	
	
<cfquery datasource="nba" name="GetFInfo">
Select *
from GameEffort
where GameTime = '#GetDay.Gametime#'
and Team = '#myfav#'
</cfquery>

<!--- Play against favorite if conseqgoodct >= 3  --->
<cfif GetFinfo.ConseqGood gte 3>
	<cfquery datasource="nba">
	Update FinalPicks
	Set Sys53 = '#myund#'
	Where gametime = '#mygametime#'
	and Fav = '#myfav#'
	</cfquery>
</cfif> 



<cfquery datasource="nba" name="GetUInfo">
Select *
from GameEffort
where GameTime = '#GetDay.Gametime#'
and Team = '#myund#'
</cfquery>

<!--- Play against underdog if conseqgoodct >= 3 --->
<cfif GetUinfo.ConseqGood gte 3>
	<cfquery datasource="nba">
	Update FinalPicks
	Set Sys53 = '#myfav#'
	Where gametime = '#mygametime#'
	and Fav = '#myfav#'
	</cfquery>
</cfif> 







<!--- Play favorite if conseqbadct >= 2 and TotalEffLast2 lte -30 --->
<cfif Getfinfo.ConseqBad gte 2 and GetFInfo.TotEffl2 lte -30>
	<cfquery datasource="nba">
	Update FinalPicks
	Set Sys57 = '#myfav#'
	Where gametime = '#mygametime#'
	and Fav = '#myfav#'
	</cfquery>
</cfif> 


<!--- Play underdog if conseqbadct >= 2 and TotalEffLast2 lte -30 --->
<cfif GetUinfo.ConseqBad gte 2 and GetUInfo.TotEffl2 lte -30>
	<cfquery datasource="nba">
	Update FinalPicks
	Set Sys57 = '#myund#'
	Where gametime = '#mygametime#'
	and Fav = '#myfav#'
	</cfquery>
</cfif> 

</cfif>

<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('UpdateSysx3.cfm')
</cfquery>

<cfquery datasource="nba">
	Update FinalPicks
	Set Sys52 = ''
	Where gametime = '#mygametime#'
	and Fav = '#myfav#'
</cfquery>

<cfif Getinfo.FavHealthL7 lt -3 AND GetInfo.UndHealthL7 is -2 AND GetInfo.spd gte 3>
	<cfquery datasource="nba">
	Update FinalPicks
	Set Sys52 = '#myund#'
	Where gametime = '#mygametime#'
	and Fav = '#myfav#'
	</cfquery>
</cfif> 



</cfloop>
	
	
	
	
<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('UpdateSysx4.cfm')
</cfquery>
	
	
<cfinclude template="PotentialProfitableSystems.cfm">	
<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('PotentialProfitableSystems.cfm')
</cfquery>



<cfinclude template="LastSevenHealth.cfm">

<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('LastSevenHealth.cfm')
</cfquery>

<cfinclude template="ShowPicksWithSituation.cfm">

<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('Ran ShowPicksWithSituation.cfm')
</cfquery>


<cfcatch type="any">

	<cfoutput>
	#cfcatch.Detail#
	</cfoutput>
	
    <cfif 1 is 1>
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.Detail#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:UpdateSYSx.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>
 </cfif>
</cfcatch>

</cftry>


	