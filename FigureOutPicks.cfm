<cftry>

<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('In Figureoutpicks.cfm')
</cfquery>


<cfquery datasource="Nba" name="GetStatus">
	Update RunStatus 
	set Runflag = 'Y'
</cfquery>


<cfset mygametime = "">

<cfquery datasource="Nba" name="GetRunct">
	Select RunCt,Gametime
	from NBAGameTime
</cfquery>

<cfset mygametime = "#GetRunCt.gametime#">























	<cfquery datasource="NBA" name="GetIt">
			Select und 
			from FinalPicks
			Where FavHealthl7 <= -10
			and spd >= 4
		    and UndPlayedYest = 'N' 
			and GameTime = '#mygametime#'
	</cfquery>

<cfoutput query="getit">
<cfquery datasource="Nba" name="xGetit">
	Update FinalPicks
	Set Sys9 = '#Getit.und#'
	where Gametime = '#myGametime#'
	and und = '#Getit.Und#'
</cfquery>	
</cfoutput>	

 
<!-- For each game, see what team covers more times -->
<cfquery  name="GetGames" datasource="NBA">
Select * from NBASchedule where trim(gametime) = '#Trim(mygametime)#'
</cfquery>

<cfquery datasource="NBA" name="AddPicks">
Delete from NbaPicks where trim(gametime) = '#Trim(mygametime)#' and systemid='GameSimHAForAvgs'                             
</cfquery>


<!--- 
<cfquery datasource="NBA" name="DeleteOld">
Delete from FinalPicks where trim(gametime) = '#Trim(mygametime)#' 
</cfquery>
 --->



<cfoutput  query="GetGames">
	
	<!--- <cfquery datasource="NBA" name="AddPicks">
	Insert into FinalPicks
	(Fav,
	ha,
	spd,
	und,
	Gametime
	)
	values
	(
	'#Getgames.fav#',
	'#Getgames.ha#',
	#Getgames.spd#,
	'#Getgames.und#',
	'#mygametime#'
	)
	</cfquery> --->
	
	<cfset favwinct = 0>
	<cfset undwinct = 0>

	<cfset favRat = 0>
	<cfset undRat = 0>

	<cfset overwinct = 0>
	<cfset underwinct = 0>

	<cfset overRat = 0>
	<cfset underRat = 0>

	
	
	<cfquery datasource="NBA" name="GetFavPicks">
	Select Count(*) as Fwins,AVG(Rating) as FRat
	from NBAGameSim
	where Pick = '#fav#'
	and gametime = '#mygametime#'
	</cfquery>

	<cfquery datasource="NBA" name="GetUndPicks">
	Select Count(*) as Uwins,AVG(Rating) as URat
	from NBAGameSim
	where Pick = '#und#'
	and gametime = '#mygametime#'
	</cfquery>

	<cfif GetFavPicks.recordcount neq 0>
		<cfset favwinct = GetFavPicks.fwins>
		<cfset FavRat   = GetFavPicks.FRat>
	</cfif>
	
	<cfif GetUndPicks.recordcount neq 0>	
		<cfset undwinct = GetUndPicks.uwins>
		<cfset UndRat   = GetUndPicks.URat>
	</cfif>
	
	
	<cfset pctwonside = 0>
	<cfset pctwontot  = 0>
	
	<cfset ourpick = ''>
	<cfset ourrat  = 0>
	
	<cfif (favwinct + undwinct) lt 10>
		<cfset OurPick = 'Not enough games' >
	<cfelse>

		<cfif favwinct gt undwinct>
			<cfset ourpick = '#fav#'>
			<cfset ourrat  = #favrat#>
			<cfset FavWinPctOutOfTen = (favwinct/(favwinct + undwinct))*100>
			<cfset pctwonside = FavWinPctOutOfTen>
		<cfelse>
			<cfset ourpick = '#und#'>
			<cfset ourrat  = #undrat#>
			<cfset UndWinPctOutOfTen = (undwinct/(favwinct + undwinct))*100>
			<cfset pctwonside = UndWinPctOutOfTen>
		</cfif>
	</cfif>

	
	<cfquery datasource="NBA" name="GetOverPicks">
	Select count(*) as owins,AVG(ouRating) as ovRat
	from NBAGameSim
	where trim(ouPick) = 'O'
	and Fav = '#fav#'
	and gametime = '#mygametime#'
	</cfquery>
	
	<cfquery datasource="NBA" name="GetUndPicks">
	Select Count(*) as uwins,AVG(ouRating) as unRat
	from NBAGameSim
	where trim(ouPick) = 'U'
	and gametime = '#mygametime#'
	and Fav = '#fav#'
	</cfquery>
	
	<cfif GetOverPicks.recordcount neq 0>
		<cfset overwinct  = GetOverPicks.owins>
		<cfset OverRat    = GetOverPicks.ovRat>
	</cfif>
	
	<cfif GetUndPicks.recordcount neq 0>	
		<cfset underwinct = GetUndPicks.uwins>
		<cfset UnderRat   = GetUndPicks.UnRat>
	</cfif>

	<cfset ourtotrat  =0>
	<cfif overwinct gt underwinct>
		<cfset ourtotpick = 'O'>
		<cfset ourtotrat  = #overrat#>
		<cfset OverWinPctOutOfTen = (overwinct/(overwinct + underwinct))*100>
		<cfset pctwontot = OverWinPctOutOfTen>
		
	<cfelse>
		<cfset ourtotpick = 'U'>
		<cfset ourtotrat  = #underrat#>
		
		<cfset UnderWinPctOutOfTen = 0>
		<cfif overwinct + underwinct neq 0>
			<cfset UnderWinPctOutOfTen = (underwinct/(overwinct + underwinct))*100>
		</cfif>
		<cfset pctwontot = UnderWinPctOutOfTen>
	</cfif>

	<cfif ourtotrat is ''>
	
	<cfset ourtotrat = 0>
	</cfif>


	<cfif 1 is 2>
	<cfquery datasource="NBA" name="AddPicks">
	Insert into NBAPicks
	(GameTime,
	Fav,
	Ha,
	Spd,
	Und,
	Pick,
	Pct,
	Systemid,
	ou,
	oupick,
	oupct,
	pctwonside,
	pctwontot
	)
	values
	(
	'#mygametime#',
	'#fav#',
	'#ha#',
	#spd#,
	'#und#',
	'#ourpick#',
	#ourrat#,
	'GameSimHAForAvgs',
	#ou#,
	'#ourtotpick#',
	#ourtotrat#,
	#pctwonside#,
	#pctwontot#
	)
	</cfquery>
	</cfif>
		
</cfoutput>

 
 
 


<cfquery  name="GetGames" datasource="NBA">
Select * from NBASchedule where trim(gametime) = '#mygametime#'
</cfquery>

<cfoutput  query="GetGames">


	<cfquery datasource="NBA" name="GetOverPicks">
	Select *
	from NBAGameSim
	where TotPoints >  #ou#
	and gametime = '#mygametime#'
	and fav = '#fav#'
	and oupick = 'O'
	</cfquery>

	<cfquery datasource="NBA" name="GetBigOverPicks">
	Select *
	from NBAGameSim
	where TotPoints > #ou#
	and gametime = '#mygametime#'
	and fav = '#fav#'
	and TotBigCov = 1
	and oupick = 'O'
	</cfquery>
	
	<cfquery datasource="NBA" name="GetUnderPicks">
	Select *
	from NBAGameSim
	where TotPoints <  #ou#
	and gametime = '#mygametime#'
	and fav = '#fav#'
	and oupick = 'U'
	</cfquery>

	<cfquery datasource="NBA" name="GetBigUnderPicks">
	Select *
	from NBAGameSim
	where TotPoints < #ou#
	and gametime = '#mygametime#'
	and fav = '#fav#'
	and TotBigCov = 1
	and oupick = 'O'
	</cfquery>

	<cfset totscenarios = GetOverPicks.recordcount + GetUnderPicks.recordcount >
	
	<cfif totscenarios neq 0>
	<cfset pctOver  = GetOverPicks.recordcount / totscenarios>
	<cfset pctUnder = GetUnderPicks.recordcount / totscenarios>
	
	<cfset pctBigOver  = #Numberformat((GetBigOverPicks.recordcount / totscenarios)*100,99.9)#>
	<cfset pctBigUnder = #Numberformat((GetBigUnderPicks.recordcount / totscenarios)*100,99.0)#>
	
	<cfset recPick  = 'N'>
	

	<cfif pctOver is 1 or pctUnder is 1>
		<cfset recPick  = 'Y'>
	</cfif> 
	
	<cfif pctBigOver neq 0 and pctBigUnder neq 0>
		<cfset recPick  = 'N'>
	</cfif>
	
	<cfset oudesc = 'PASS'>
	<cfif pctOver gt pctUnder>
		<cfset oudesc = 'OVER'>
		<cfset pctBig = pctBigOver>
	</cfif>
	<cfif pctOver lt pctUnder>
		<cfset oudesc = 'UNDER'>
		<cfset pctBig = pctBigUnder>
	</cfif>
	
	<cfif recPick is 'Y'>
			We like the #oudesc# #ou# in the #fav#/#und# game, with a big blowout chance of #pctBig# <br>

	<cfquery datasource="NBA" name="AddPicks">
	Insert into NBAPicks
	(GameTime,
	Fav,
	Ha,
	Spd,
	Und,
	Pick,
	Pct,
	Systemid,
	ou,
	oupick,
	oupct,
	pctwonside,
	pctwontot
	)
	values
	(
	'#mygametime#',
	'#fav#',
	'#ha#',
	#spd#,
	'#und#',
	'',
	0,
	'GameSimTotals',
	#ou#,
	'#oudesc#',
	#pctbig#,
	0,
	0
	)
	</cfquery>

	</cfif>
	</cfif>
	
</cfoutput>	




<cfquery  name="GetGames" datasource="NBA">
Select * from NBASchedule where trim(gametime) = '#mygametime#'
</cfquery>




<cfoutput  query="GetGames">


	<cfquery datasource="NBA" name="GetFavPicks">
	Select *
	from NBAGameSim
	where spddif >  #val(spd)#
	and gametime = '#mygametime#'
	and fav = '#fav#'
	and pick = '#fav#'
	</cfquery>

	<cfquery datasource="NBA" name="GetBigFavPicks">
	Select *
	from NBAGameSim
	where gametime = '#mygametime#'
	and fav = '#fav#'
	and SpdBigCov = 1
	and pick = '#fav#'
	</cfquery>
	
	<cfquery datasource="NBA" name="GetUndPicks">
	Select *
	from NBAGameSim
	where spddif <  #val(spd)#
	and gametime = '#mygametime#'
	and fav = '#fav#'
	and pick = '#und#'
	</cfquery>

	<cfquery datasource="NBA" name="GetBigUndPicks">
	Select *
	from NBAGameSim
	where gametime = '#mygametime#'
	and fav = '#fav#'
	and SpdBigCov = 1
	and pick = '#und#'
	</cfquery>

	<cfset totscenarios = GetFavPicks.recordcount + GetUndPicks.recordcount >
	
	<cfif totscenarios neq 0>
	<cfset pctFav = GetFavPicks.recordcount / totscenarios>
	<cfset pctUnd = GetUndPicks.recordcount / totscenarios>
	
	<cfset pctBigFav = #Numberformat((GetBigFavPicks.recordcount / totscenarios)*100,99.9)#>
	<cfset pctBigUnd = #Numberformat((GetBigUndPicks.recordcount / totscenarios)*100,99.0)#>
	
	<cfset recPick  = 'N'>
	

	<cfif pctFav is 1 or pctUnd is 1>
		<cfset recPick  = 'Y'>
	</cfif> 
	
	<cfif pctBigFav neq 0 and pctBigUnd neq 0>
		<cfset recPick  = 'N'>
	</cfif>
	
	<cfset oudesc = 'PASS'>
	<cfif pctFav gt pctUnd>
		<cfset oudesc = '#FAV#'>
		<cfset pctBig = pctBigFav>
	</cfif>
	<cfif pctFav lt pctUnd>
		<cfset oudesc = '#UND#'>
		<cfset pctBig = pctBigUnd>
	</cfif>
	
	<cfif recPick is 'Y'>
			We like the #oudesc# #spd# in the #fav#/#und# game, with a big blowout chance of #pctBig#%<br>

	<cfquery datasource="NBA" name="AddPicks">
	Insert into NBAPicks
	(GameTime,
	Fav,
	Ha,
	Spd,
	Und,
	Pick,
	Pct,
	Systemid,
	ou,
	oupick,
	oupct,
	pctwonside,
	pctwontot
	)
	values
	(
	'#mygametime#',
	'#fav#',
	'#ha#',
	#spd#,
	'#und#',
	'#oudesc#',
	#pctbig#,
	'GameSimSide',
	0,
	'',
	0,
	0,
	0
	)
	</cfquery>

	</cfif>
	</cfif>

</cfoutput>	

<cfif 1 is 1>


<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('In Figureoutpicks.cfm about to call GAP.cfm')
</cfquery>

<cfinclude template="GAP.cfm">


<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('In Figureoutpicks.cfm BACK from call to GAP.cfm')
</cfquery>

<cfinclude template="CreateStndDev.cfm">
<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('1-CreateStndDev.cfm')
</cfquery>


<cfinclude template="CreatePowerMinutesLatestForm.cfm">
<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('2-CreatePowerMinutesLatestForm.cfm')
</cfquery>


<cfinclude template="CommonOpponentSys.cfm">
<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('3-CommonOpponentSys.cfm')
</cfquery>


<cfinclude template="GAPha.cfm"> 
<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('4-GAPha.cfm')
</cfquery>

<cfinclude template="TeamHealth2.cfm">

<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('5-TeamHealth2.cfm')
</cfquery>



<cfif 1 is 2>
<cfinclude template="CreatePowerMinutes.cfm">
</cfif>

<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('In Figureoutpicks.cfm about to call PowerRatingPicks.cfm')
</cfquery>


<cfquery datasource="NBA" name="GetGAP">
Select * from NBAPicks where SystemId = 'GAP' and GameTime = '#mygametime#'
</cfquery>

<cfoutput query="GetGAP">

	<cfset mypick = '#GetGap.Pick#'>
	<cfif #Pct# ge 4.5>
			<cfset mypick = '**#GetGap.Pick#'>
	</cfif>

	<cfquery datasource="NBA" name="AddPicks">
	Update FinalPicks
	Set GAP = '#mypick#'
	Where Fav = '#GetGap.Fav#' 
	and GameTime = '#mygametime#'
	</cfquery>
	
</cfoutput>


<cfquery datasource="NBA" name="GetPowerTotals">
Select * from NBAPicks where abs(Pct) >= 15 and SystemId = 'PowerTools' and GameTime = '#mygametime#'
</cfquery>

<cfoutput query="GetPowerTotals">
	<cfquery datasource="NBA" name="AddPicks">
	Update FinalPicks
	Set PowScore15Plus = '#GetPowerTotals.Pick#'
	Where Fav = '#GetPowerTotals.Fav#' 
	and GameTime = '#mygametime#'
	</cfquery>
</cfoutput>



<cfquery datasource="NBA" name="GetGameSim">
Select * from NBAPicks where SystemId = 'GameSimHAForAvgs' and GameTime = '#mygametime#'
</cfquery>


<cfoutput query="GetGameSim">
	<cfset temp = '#GetGameSim.Pick#'>
	<cfif GetGameSim.pct ge 60 >
		<cfset temp = '**#GetGameSim.Pick#'>
	</cfif>

	<cfquery datasource="NBA" name="AddPicks">
	Update FinalPicks
	Set GamesimSide = '#temp#'
	Where Fav = '#GetGameSim.Fav#' 
	and GameTime = '#mygametime#'
	</cfquery>

</cfoutput>

<cfquery datasource="NBA" name="GetGamesimAvgScore">
select n.gametime,n.Fav,n.Und,n.spd as VegasSpd,Avg(n.Favscore) as Favscore1,Avg(n.Undscore) as undscore1,Avg(n.Favscore) - Avg(n.UndScore) as Ourspd,abs(n.spd-(Avg(n.Favscore) - Avg(n.UndScore))) as diff 
from nbagamesim n
where n.gametime='#mygametime#'
group by n.fav,n.und,n.spd,n.gametime
</cfquery>

<cfoutput query="GetGameSimAvgScore">
	<cfset ourpick = ''>

		<cfif ourspd lt 0>
			<cfset ourpick = '#und#'>
		
		<cfelse> 
			<cfif ourspd gt vegasspd>
				<cfset ourpick = '#fav#'>
			<cfelse>
				<cfset ourpick = '#und#'>
			</cfif>	
				
		</cfif>
	
		<cfif #diff# ge 7.5>
			<cfset ourpick = '**' & '#ourpick#'>
		</cfif>
		
		<cfquery datasource="NBA" name="AddPicks">
		Update FinalPicks
		Set GamesimAvgScore = '#ourPick#'
		Where Fav = '#GetGameSimAvgScore.Fav#' 
		and GameTime = '#mygametime#'
		</cfquery>
	
</cfoutput>


<cfquery  name="GetGames" datasource="NBA">
Select * from NBASchedule where trim(gametime) = '#mygametime#'
</cfquery>


<cfoutput  query="GetGames">


	<cfquery datasource="NBA" name="Check">
	Select * 
	from GAP gf, FinalPicks fp, GAP gu
	where gf.Team = '#Getgames.fav#' 
	and gf.Scoring = 'G' 
	and gu.Team = '#Getgames.und#' 
	and gu.scoring = 'P'
	and fp.gametime = '#mygametime#'
	and fp.fav = gf.team
	and fp.FavPlayedYest = 'N'
	</cfquery>
	
	<cfif Check.Recordcount neq 0>
	
		<cfif '#Getgames.ha#' is 'H'>
			<cfquery datasource="NBA" name="AddPicks">
			Update FinalPicks
			Set HBlowoutScoring = '#Getgames.fav#'
			Where Fav = '#Getgames.Fav#' 
			and GameTime = '#mygametime#'
			</cfquery>

			
			<cfquery datasource="NBA" name="Checkreb">
			Select * 
			from GAP gf, FinalPicks fp, GAP gu
			where gf.Team = '#Getgames.fav#' 
			and gf.Scoring = 'G' 
			and gf.Rebounding = 'G'
			and gu.Team = '#Getgames.und#' 
			and gu.scoring = 'P'
			and (gu.rebounding = 'P' or gu.rebounding = 'A') 
			and fp.gametime = '#mygametime#'
			and fp.fav = gf.team
			and fp.FavPlayedYest = 'N'
			</cfquery>

			<cfif CheckReb.recordcount neq 0>
			<cfquery datasource="NBA" name="AddPicks">
			Update FinalPicks
			Set HBlowScorReb = '#Getgames.fav#'
			Where Fav = '#Getgames.Fav#' 
			and GameTime = '#mygametime#'
			</cfquery>
			</cfif>

		<cfelse>
			<cfquery datasource="NBA" name="AddPicks">
			Update FinalPicks
			Set ABlowoutScoring = '#Getgames.fav#'
			Where Fav = '#GetGames.Fav#' 
			and GameTime = '#mygametime#'
			</cfquery>


			<cfquery datasource="NBA" name="Checkreb">
			Select * 
			from GAP gf, FinalPicks fp, GAP gu
			where gf.Team = '#Getgames.fav#' 
			and gf.Scoring = 'G' 
			and gf.Rebounding = 'G'
			and gu.Team = '#Getgames.und#' 
			and gu.scoring = 'P'
			and (gu.rebounding = 'P' or gu.rebounding = 'A') 
			and fp.gametime = '#mygametime#'
			and fp.fav = gf.team
			and fp.FavPlayedYest = 'N'
			</cfquery>

			<cfif CheckReb.recordcount neq 0>
			<cfquery datasource="NBA" name="AddPicks">
			Update FinalPicks
			Set ABlowScorReb = '#Getgames.fav#'
			Where Fav = '#Getgames.Fav#' 
			and GameTime = '#mygametime#'
			</cfquery>
			</cfif>


		
		</cfif>
	</cfif>
</cfoutput>	





<cfinclude template="SuperSystem.cfm">
<cfinclude template="jimtemp4.cfm">
<cfinclude template="CreateBigWinStats.cfm">

<!-- This looks promising... For UNDER plays -->
<cfquery datasource="nba" name="Getinfo">
Select * from PreGameProb
where ffgpct < -59 and ufgpct < -59 
and (ftpm < 0 or utpm < 0)
and GameTime = '#mygametime#'
order by gametime desc
</cfquery> 


<cfoutput query="Getinfo">
	<cfquery datasource="NBA" name="AddPicks">
			Update FinalPicks
			Set PreGameUnder = 'UNDER'
			Where Fav = '#GetInfo.Fav#' 
			and GameTime = '#mygametime#'
	</cfquery>
</cfoutput>

<!-- Promising for UNDERS... Start AFTER November 18 -->
<cfquery datasource="nba" name="Getinfo2">
Select * from PredictedStats
where (favfg + undfg < 85)
and (favtpm + undtpm < 10)
and (favfg + undfg <> 0)
and GameTime = '#mygametime#'
order by gametime desc
</cfquery> 


<cfoutput query="Getinfo2">
	<cfquery datasource="NBA" name="AddPicks">
			Update FinalPicks
			Set PredStatsUnder = 'UNDER'
			Where Fav = '#GetInfo2.Fav#' 
			and GameTime = '#mygametime#'
	</cfquery>
</cfoutput>


<!-- Promising for UNDERS... Start AFTER November 18 -->
<cfquery datasource="nba" name="Getinfo3">
Select * from NBAPICKS
where SYSTEMID = 'GameSimTotals'
and GameTime = '#mygametime#'
</cfquery> 


<cfoutput query="Getinfo3">
	<cfquery datasource="NBA" name="AddPicks">
			Update FinalPicks
			Set GameSimOU = '#getInfo3.oupick#'
			Where Fav = '#GetInfo3.Fav#' 
			and GameTime = '#mygametime#'
	</cfquery>
</cfoutput>

<!-- Promising for UNDERS... Start AFTER November 18 -->
<cfquery datasource="nba" name="Getinfo4">
Select * from NBAPICKS
where SYSTEMID = 'GameSimHAForAvgs'
and oupct >= 60
and GameTime = '#mygametime#'
</cfquery> 


<cfoutput query="Getinfo4">
	<cfquery datasource="NBA" name="AddPicks">
			Update FinalPicks
			Set GameSimOU60 = '#getInfo4.oupick#'
			Where Fav = '#GetInfo4.Fav#' 
			and GameTime = '#mygametime#'
	</cfquery>
</cfoutput>


<!-- This looks promising... Also no play if they played night previous -->
<cfquery datasource="nba" name="Getinfo5">
Select * from PredictedStats
where favfg - undfg >= 4.82 
and favreb - undreb >= 4.35
and val(spd) <= 12 and val(spd) <> 0
order by gametime desc
</cfquery> 


<cfoutput query="Getinfo5">

	<cfquery datasource="NBA" name="AddPicks">
			Update FinalPicks
			Set FgReb = '#getInfo5.fav#'
			Where Fav = '#GetInfo5.Fav#' 
			and GameTime = '#mygametime#'
	</cfquery>
</cfoutput>


<cfquery datasource="nba" name="Getinfo65">
Select * from PredictedStats
where Undscore >= favscore
and (val(spd) - val(ourspd) >= 4)
and gametime = '#mygametime#'
order by gametime desc
</cfquery> 

<cfoutput query="Getinfo65">
		checking '4#GetInfo65.Fav#' #favscore#,#undscore# <br>
	<cfquery datasource="NBA" name="AddPicks">
			Update FinalPicks
			Set PredStatsUnd = '*#getInfo65.und#'
			Where Fav = '#GetInfo65.Fav#' 
			and GameTime = '#mygametime#'
	</cfquery>
</cfoutput>

<cfquery datasource="nba" name="Getinfo55">
Select * from PredictedStats
where favscore >= Undscore
and (val(ourspd) - val(spd) >= 4)
and gametime='#mygametime#'
order by gametime desc
</cfquery> 

<cfoutput query="Getinfo55">
		checking '4#GetInfo55.Fav#',#favscore#,#undscore#<br>
	<cfquery datasource="NBA" name="AddPicks">
			Update FinalPicks
			Set PredStatsFav = '*#getInfo55.fav#'
			Where Fav = '#GetInfo55.Fav#' 
			and GameTime = '#mygametime#'
	</cfquery>
</cfoutput>



<cfquery datasource="nba" name="getinfo">
Select * from ImportantStatPreds i
where i.gametime = '#mygametime#'
and i.CoversPct >= 60
</cfquery>

<cfoutput query="getinfo">
	<cfquery datasource="NBA" name="AddPicks">
			Update FinalPicks
			Set SixtyPctImpStat = '#getInfo.whocovers#'
			Where Fav = '#Getinfo.Fav#' 
			and GameTime = '#mygametime#'
	</cfquery>
</cfoutput>	




	<cfquery datasource="NBA" name="GetIt">
			Select und 
			from FinalPicks
			Where FavHealthl7 <= -10
			and spd >= 4
		    and UndPlayedYest = 'N' 
			and GameTime = '#mygametime#'
	</cfquery>

<cfoutput query="getit">
<cfquery datasource="Nba" name="xGetit">
	Update FinalPicks
	Set Sys9 = '#Getit.und#'
	where Gametime = '#Gametime#'
	and Fav = '#Getit.Und#'
</cfquery>	
</cfoutput>	


<cfquery datasource="Nba" name="GetRunct">
	Update NBAGametime 
	Set RunCt=0
</cfquery>



<cfquery datasource="Nba" name="GetRunct">
	Select Gametime
	from NBAGameTime
</cfquery>

<cfset GameTime = GetRunct.GameTime>

<cfset yyyy = left(GetRunCt.gametime,4)>
<cfset mm   = mid(GetRunCt.gametime,5,2)>
<cfset dd   = right(GetRunCt.gametime,2)>
<cfset mydate = #Dateformat(DateAdd("d",0,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
<CFSET NEXTDAY = #Dateformat(DateAdd("d",1,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
<CFSET NEXTDAYSTR = ToString(NEXTDAY)>


<cfinclude template="FigureFinalPicks.cfm">
Did FigureFinalPicks.cfm <br>

<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('FOP: Ran FigureFinalPicks.cfm')
</cfquery>


<cfinclude template="SYS60.cfm">
Did SYS50s.cfm <br>

<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('From FOP: SYS60.cfm was run')
</cfquery>

<!---
<cfinclude template="SYS50s.cfm">
Did SYS50s.cfm <br>
--->

<cfinclude template="NBATotals.cfm">

<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('FOP: NBATotal.cfm was run')
</cfquery>

<cfinclude template="UpdateConseqRoadCt.cfm">

<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('FOP: UpdateConseqRoadCt.cfm was run')
</cfquery>


<cfinclude template="TestPIPGames.cfm">

<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('FOP: TestPIPGames.cfm was run')
</cfquery>

<cfinclude template="PregameSituations.cfm">

<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('FOP: PregameSituations.cfm was run')
</cfquery>


<cfinclude template="UpdateFinalPicksHealth.cfm">

<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('FOP: UpdateFinalPicksHealth.cfm was run')
</cfquery>


<cfquery datasource="Nba" name="GetStatus">
	Update RunStatus 
	set Runflag = 'N',
	runstatus='DONE'
</cfquery>



<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('In Did PowerRatingPicks.cfm')
</cfquery>

<cfinclude template="CreateTeamScoringProfiles.cfm">

<cfinclude template="PowerRatingPicks.cfm">

<cfinclude template="PotentialProfitableSystems.cfm">
<cfinclude template="ShowPower.cfm">





<cfquery datasource="Nba" name="GetFavsPlaying">
	Select Gametime, Fav, HA, spd, Und, WhoCovered, UndHealthl7, FavHealthL7
	from FinalPicks
	where 1 = 1
	and FavConseqRdCt >= 4
	and HA = 'H'
	and Gametime = '#mygametime#'
	and spd >= 3
</cfquery>


<cfoutput query="GetFavsPlaying">

	<cfquery datasource="Nba" name="Updit">
		Update FinalPicks
		SET SYS69 = '#Und#'
		where Gametime = '#myGametime#'
		and fav = '#GetFavsPlaying.fav#'
	</cfquery>

</cfoutput>



<cfquery datasource="Nba" name="GetFavsPlaying">
	Select Gametime, Fav, HA, spd, Und, WhoCovered, UndHealthl7, FavHealthL7
	from FinalPicks
	where Gametime = '#myGametime#'
	and UndConseqRdCt >= 4
	and HA = 'H'
	and spd < 8
</cfquery>


<cfoutput query="GetFavsPlaying">
	

	<cfquery datasource="Nba" name="Updit">
		Update FinalPicks
		SET SYS70 = '#fav#'
		where Gametime = '#myGametime#'
		and fav = '#GetFavsPlaying.fav#'
	</cfquery>

</cfoutput>






<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('BINGO!!!! - Congrats..FOP: AllPicksHaveBeenMadeSuccessfully.')
</cfquery>

</cfif>


<cfcatch type="any">
  <cfoutput>
  #cfcatch.Detail#
  </cfoutput>
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.Detail#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:FigureOutPicks.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>

</cfcatch>

</cftry>



