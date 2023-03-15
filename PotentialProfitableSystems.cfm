<cftry>


<cfquery datasource="Nba" name="GetRunct">
	Select RunCt,Gametime
	from NBAGameTime
</cfquery>

<cfset mygametime="#GetRunct.Gametime#">



<p>
10-4 (75%)<br>
<cfquery datasource="NBA" name="GetGamesimAvgScore">
select distinct fpf.*
from finalpicks fpf
where fpf.PIPPick = fpf.und
and gametime >= '20141114'
and fpf.spd <= 5
and fpf.UndPlayedYest = 'N'
and fpf.gametime = '#mygametime#'
order by fpf.gametime desc
</cfquery>


<cfquery datasource="NBA" name="GetGamesimAvgScore">
select distinct fpf.*
from finalpicks fpf, PIP fp, PIP up 
where fpf.PIPPick = fpf.und
and fpf.gametime >= '20141114'
and fpf.spd <= 5
and fpf.UndPlayedYest = 'N'
and fpf.gametime = '#mygametime#'
and up.PIPRat > fp.PIPRat 
and fp.Team = fpf.Fav
and up.Team = fpf.Und
order by fpf.gametime desc
</cfquery>


<cfset w = 0>
<cfset l = 0>

<cfoutput query="GetGamesimAvgScore">
#gametime#..#spd#....#fav#/#und#,#Whocovered#....#favhealth#.....#undhealth#....#ha#... 

<cfquery datasource="NBA" name="AddPicks">
	Update FinalPicks
	Set SYS99 = '#und#'
	Where Fav = '#Fav#' 
	and GameTime = '#mygametime#'
</cfquery>

<cfif GetGamesimAvgScore.Undhealth gte GetGamesimAvgScore.favhealth>

<cfquery datasource="NBA" name="AddPicks">
	Update FinalPicks
	Set SYS98 = '#und#'
	Where Fav = '#Fav#' 
	and GameTime = '#mygametime#'
</cfquery>


</cfif>


<cfif '#whocovered#' neq 'PUSH'>
<cfif '#whocovered#' is '#und#'>
	WINNER!<br>
	<cfset w = w + 1>
<cfelse>
    LOSER <br>
	<cfset l = l + 1>
</cfif>	
</cfif>

</cfoutput>
<hr>
<cfoutput>
#w# - #l#
</cfoutput>


<cfquery datasource="Nba" name="GetRunct">
	Select Gametime
	from NBAGameTime
</cfquery>

<cfset GameTime = GetRunct.GameTime>


NBAPicks Power Total Pct=24+ or Pct -24+ Fav and Und Health BOTH -7 or better

<cfquery datasource="NBA" name="GetOU">
select  distinct
	p.pick,
	schd.fav,
	schd.und,
	schd.ou,
	p.pct,
	fp.FavPlayedYest,
	fp.UndPlayedYest,
	fp.FavHealth,
	fp.UndHealth,
	schd.gametime,
	0 as pts
from NBAPicks p, nbaschedule schd, finalpicks fp
where p.gametime = schd.gametime
 
and p.systemid = 'PowerTotals'
and (p.pct >=24 or p.pct <=-24)

and schd.gametime = '#mygametime#'
and schd.fav = p.fav
and fp.gametime = schd.gametime
and fp.fav = schd.fav

</cfquery>

<table border="1">
<tr>
<td>
Game Day
</td>	
	
<td>
FAV
</td>
<td>
UND
</td>
<td>
Line Total
</td>
<td>
Our Pick
</td>
<td>
Pts Actual
</td>
<td>
favplayedyest
</td>

<td>
undplayedyest
</td>

<td>
favhealth
</td>

<td>
undhealth
</td>

<td>
Rat
</td>

<td>
Result
</td>

<cfoutput query="GetOU">
<cfif #favHealth# gte -7 and #undhealth# gte -7>	

	


<tr>
<td>
#gametime#
</td>	
	
<td>
#fav#
</td>
<td>
#und#
</td>
<td>
#ou#
</td>
<td>
#pick#
</td>

<td>
#pts#
</td>

<td>
#favplayedyest#
</td>

<td>
#undplayedyest#
</td>

<td>
#favhealth#
</td>

<td>
#undhealth#
</td>

<td>
#pct#
</td>
<cfset outcome = 'loser'>

<cfif #pts# is #ou#>
<cfset outcome = 'PUSH'>
</cfif>

<cfif '#pick#' is 'UNDER' and #pts# lt #ou#>
	<cfset outcome = 'WINNER!'>
</cfif>

<cfif '#pick#' is 'OVER' and #pts# gt #ou#>
	<cfset outcome = 'WINNER!'>
</cfif> 

<td>
#outcome#
</td>

</tr>
</cfif>
</cfoutput>


System
NBAPicks Power Total Pct=20+ or Pct -20+

<cfquery datasource="NBA" name="GetOU">
select  distinct
	p.pick,
	schd.fav,
	schd.und,
	schd.ou,
	p.pct,
	fp.FavPlayedYest,
	fp.UndPlayedYest,
	fp.FavHealth,
	fp.UndHealth,
	schd.gametime,
	0 as pts
from NBAPicks p, nbaschedule schd, finalpicks fp
where p.gametime = schd.gametime
 
and p.systemid = 'PowerTotals'
and (p.pct >=20 or p.pct <=-20)

and schd.gametime = '#mygametime#'
and schd.fav = p.fav
and fp.gametime = schd.gametime
and fp.fav = schd.fav

</cfquery>

<table border="1">
<tr>
<td>
Game Day
</td>	
	
<td>
FAV
</td>
<td>
UND
</td>
<td>
Line Total
</td>
<td>
Our Pick
</td>
<td>
Pts Actual
</td>
<td>
favplayedyest
</td>

<td>
undplayedyest
</td>

<td>
favhealth
</td>

<td>
undhealth
</td>

<td>
Rat
</td>

<td>
Result
</td>

<cfoutput query="GetOU">
<cfif 1 is 1>	


<tr>
<td>
#gametime#
</td>	
	
<td>
#fav#
</td>
<td>
#und#
</td>
<td>
#ou#
</td>
<td>
#pick#
</td>

<td>
#pts#
</td>

<td>
#favplayedyest#
</td>

<td>
#undplayedyest#
</td>

<td>
#favhealth#
</td>

<td>
#undhealth#
</td>

<td>
#pct#
</td>
<cfset outcome = 'loser'>

<cfif #pts# is #ou#>
<cfset outcome = 'PUSH'>
</cfif>

<cfif '#pick#' is 'UNDER' and #pts# lt #ou#>
	<cfset outcome = 'WINNER!'>
</cfif>

<cfif '#pick#' is 'OVER' and #pts# gt #ou#>
	<cfset outcome = 'WINNER!'>
</cfif> 

<td>
#outcome#
</td>

</tr>
</cfif>
</cfoutput>



NBAPicks Power Total Pct=20+ or Pct -20+ Fav and Und Health BOTH -6 or better
<cfquery datasource="NBA" name="GetOU">
select  distinct
	p.pick,
	schd.fav,
	schd.und,
	schd.ou,
	p.pct,
	fp.FavPlayedYest,
	fp.UndPlayedYest,
	fp.FavHealth,
	fp.UndHealth,
	schd.gametime,
	0 as pts
from NBAPicks p, nbaschedule schd, finalpicks fp
where p.gametime = schd.gametime
 
and p.systemid = 'PowerTotals'
and (p.pct >=20 or p.pct <=-20)

and schd.gametime = '#mygametime#'
and schd.fav = p.fav
and fp.gametime = schd.gametime
and fp.fav = schd.fav

</cfquery>

<table border="1">
<tr>
<td>
Game Day
</td>	
	
<td>
FAV
</td>
<td>
UND
</td>
<td>
Line Total
</td>
<td>
Our Pick
</td>
<td>
Pts Actual
</td>
<td>
favplayedyest
</td>

<td>
undplayedyest
</td>

<td>
favhealth
</td>

<td>
undhealth
</td>

<td>
Rat
</td>

<td>
Result
</td>

<cfoutput query="GetOU">
<cfif #favHealth# gte -6 and #undhealth# gte -6>	

	<!--- <cfquery datasource="NBA" name="AddPicks">
	Update FinalPicks
	Set SYS101 = '#Pick#'
	Where Fav = '#Fav#' 
	and GameTime = '#mygametime#'
	</cfquery> --->


<tr>
<td>
#gametime#
</td>	
	
<td>
#fav#
</td>
<td>
#und#
</td>
<td>
#ou#
</td>
<td>
#pick#
</td>

<td>
#pts#
</td>

<td>
#favplayedyest#
</td>

<td>
#undplayedyest#
</td>

<td>
#favhealth#
</td>

<td>
#undhealth#
</td>

<td>
#pct#
</td>
<cfset outcome = 'loser'>

<cfif #pts# is #ou#>
<cfset outcome = 'PUSH'>
</cfif>

<cfif '#pick#' is 'UNDER' and #pts# lt #ou#>
	<cfset outcome = 'WINNER!'>
</cfif>

<cfif '#pick#' is 'OVER' and #pts# gt #ou#>
	<cfset outcome = 'WINNER!'>
</cfif> 

<td>
#outcome#
</td>

</tr>
</cfif>
</cfoutput>





NBAPicks Power Total Pct=20+ or Pct -20+ Fav and Und Health BOTH -7 or better
<cfquery datasource="NBA" name="GetOU">
select  distinct
	p.pick,
	schd.fav,
	schd.und,
	schd.ou,
	p.pct,
	fp.FavPlayedYest,
	fp.UndPlayedYest,
	fp.FavHealth,
	fp.UndHealth,
	schd.gametime,
	0 as pts
from NBAPicks p, nbaschedule schd, finalpicks fp
where p.gametime = schd.gametime
 
and p.systemid = 'PowerTotals'
and (p.pct >=20 or p.pct <=-20)

and schd.gametime = '#mygametime#'
and schd.fav = p.fav
and fp.gametime = schd.gametime
and fp.fav = schd.fav

</cfquery>

<table border="1">
<tr>
<td>
Game Day
</td>	
	
<td>
FAV
</td>
<td>
UND
</td>
<td>
Line Total
</td>
<td>
Our Pick
</td>
<td>
Pts Actual
</td>
<td>
favplayedyest
</td>

<td>
undplayedyest
</td>

<td>
favhealth
</td>

<td>
undhealth
</td>

<td>
Rat
</td>

<td>
Result
</td>

<cfoutput query="GetOU">
<cfif #favHealth# gte -7 and #undhealth# gte -7>	

	<!--- <cfquery datasource="NBA" name="AddPicks">
	Update FinalPicks
	Set SYS102 = '#Pick#'
	Where Fav = '#Fav#' 
	and GameTime = '#mygametime#'
	</cfquery> --->


<tr>
<td>
#gametime#
</td>	
	
<td>
#fav#
</td>
<td>
#und#
</td>
<td>
#ou#
</td>
<td>
#pick#
</td>

<td>
#pts#
</td>

<td>
#favplayedyest#
</td>

<td>
#undplayedyest#
</td>

<td>
#favhealth#
</td>

<td>
#undhealth#
</td>

<td>
#pct#
</td>
<cfset outcome = 'loser'>

<cfif #pts# is #ou#>
<cfset outcome = 'PUSH'>
</cfif>

<cfif '#pick#' is 'UNDER' and #pts# lt #ou#>
	<cfset outcome = 'WINNER!'>
</cfif>

<cfif '#pick#' is 'OVER' and #pts# gt #ou#>
	<cfset outcome = 'WINNER!'>
</cfif> 

<td>
#outcome#
</td>

</tr>
</cfif>
</cfoutput>





<p>
10-4 (75%)<br>
<cfquery datasource="NBA" name="GetGamesimAvgScore">
select distinct fpf.*
from finalpicks fpf,  finalpicks fpu, GAP fgap, gap ugap
where fpf.fav = fgap.team
<!--- and fpf.whocovered <> 'PUSH' --->
and fpf.FavPlayedYest = 'N'
and fpu.und = ugap.Team
and fpf.gametime = fpu.gametime
and fpf.fav = fpu.fav
and fpf.gametime = '#mygametime#'
and ugap.team = fpu.und
and fpf.fav = fgap.team

and ugap.Rebounding = 'P' 
and ugap.fgpct      = 'P'
and fgap.Scoring    = 'G' 
and ugap.Scoring    = 'P' 
and fpf.favhealth > fpu.undhealth 
and fpf.ha = 'H'
order by fpf.gametime desc
</cfquery>

<!--- and fgap.fgpct <> 'P'
and fpf.ha = 'H'
and fpf.favhealth > fpu.undhealth  --->


<cfset w = 0>
<cfoutput query="GetGamesimAvgScore">
#gametime#..#spd#....#fav#/#und#,#Whocovered#....#favhealth#.....#undhealth#....#ha#<br> 

	<cfquery datasource="NBA" name="AddPicks">
	Update FinalPicks
	Set SYS40 = '#fav#'
	Where Fav = '#Fav#' 
	and GameTime = '#mygametime#'
	</cfquery>


<cfif '#whocovered#' is '#fav#'>
	WINNER!<br>
	<cfset w = w + 1>
</cfif>	
</cfoutput>
<hr>

<!--- <cfoutput>
#w/GetGamesimAvgScore.recordcount#<br>
#w# - #GetGamesimAvgScore.recordcount - w#
</cfoutput> --->
<p>
<p>
<p>





<p>


11-4 (73%)<br>
<cfquery datasource="NBA" name="GetGamesimAvgScore">
select distinct fpf.*
from finalpicks fpf, gap gf, finalpicks fpu, gap gu
where fpf.fav = gf.team
and gf.oPIP = 'G'
and fpu.und = gu.Team
and gu.dpip = 'P'
and fpf.gametime = fpu.gametime
and fpf.fav = fpu.fav
and gu.Rebounding = 'P'
<!--- and fpf.whocovered <> 'PUSH' --->
and fpf.FavPlayedYest = 'N'
and gu.fgpct <> 'G'
and fpf.gametime = '#mygametime#'
and fpf.favhealth >= fpu.undhealth 
and fpf.spd < 10
and fpf.ha = 'H' 
order by fpf.gametime desc
</cfquery>



<cfset w = 0>
<cfoutput query="GetGamesimAvgScore">
#gametime#..#spd#....#fav#/#und#,#Whocovered#....#favhealth#.....#undhealth#....#ha#<br> 

	<cfquery datasource="NBA" name="AddPicks">
	Update FinalPicks
	Set SYS41 = '#fav#'
	Where Fav = '#Fav#' 
	and GameTime = '#mygametime#'
	</cfquery>

<cfif '#whocovered#' is '#fav#'>
	WINNER!<br>
	<cfset w = w + 1>
</cfif>	
</cfoutput>


<!--- <cfoutput>
#w/GetGamesimAvgScore.recordcount#<br>
#w# - #GetGamesimAvgScore.recordcount - w#
</cfoutput> --->
<p>
<p>
<p>
<hr>

18-9 (67%)<br>
<cfquery datasource="NBA" name="GetGamesimAvgScore">
select distinct fpf.*
from finalpicks fpf, gap gf, finalpicks fpu, gap gu
where fpf.fav = gf.team
and gf.oPIP = 'G'
and fpu.und = gu.Team
and gu.dpip = 'P'
and fpf.gametime = fpu.gametime
and fpf.fav = fpu.fav
and gu.Rebounding = 'P'
<!--- and fpf.whocovered <> 'PUSH' --->
and fpf.FavPlayedYest = 'N'
and gu.fgpct <> 'G'
and fpf.gametime = '#mygametime#'
and fpf.favhealth >= fpu.undhealth 
and fpf.spd < 10
order by fpf.gametime desc
</cfquery>

<p>
<p>
<p>



<cfset w = 0>
<cfoutput query="GetGamesimAvgScore">
#gametime#..#spd#....#fav#/#und#,#Whocovered#....#favhealth#.....#undhealth#....#ha#<br> 
	<cfquery datasource="NBA" name="AddPicks">
	Update FinalPicks
	Set SYS42 = '#fav#'
	Where Fav = '#Fav#' 
	and GameTime = '#mygametime#'
	</cfquery>

<cfif '#whocovered#' is '#fav#'>
	WINNER!<br>
	<cfset w = w + 1>
</cfif>	
</cfoutput>

<!--- 
<cfoutput>
#w/GetGamesimAvgScore.recordcount#<br>
#w# - #GetGamesimAvgScore.recordcount - w#
</cfoutput> --->

<p>
<p>
<p>
<hr>


21-13 (62%) <br>
<cfquery datasource="NBA" name="GetGamesimAvgScore">
select distinct fpf.*
from finalpicks fpf, gap gf, finalpicks fpu, gap gu
where fpf.fav = gf.team
and gf.oPIP               = 'G'
and fpu.und = gu.Team
and gu.dpip               = 'P'
and fpf.gametime = fpu.gametime
and fpf.fav = fpu.fav
and gu.Rebounding         = 'P'
<!--- and fpf.whocovered <> 'PUSH' --->
and fpf.FavPlayedYest     = 'N'
and gu.fgpct             <> 'G'
and fpf.gametime           = '#mygametime#'
and fpf.favhealth        >= fpu.undhealth 
order by fpf.gametime desc
</cfquery>



<cfset w = 0>
<cfoutput query="GetGamesimAvgScore">
#gametime#..#spd#....#fav#/#und#,#Whocovered#....#favhealth#.....#undhealth#....#ha#<br> 
	<cfquery datasource="NBA" name="AddPicks">
	Update FinalPicks
	Set SYS43 = '#fav#'
	Where Fav = '#Fav#' 
	and GameTime = '#mygametime#'
	</cfquery>

<cfif '#whocovered#' is '#fav#'>
	WINNER!<br>
	<cfset w = w + 1>
</cfif>	
</cfoutput>


<!--- <cfoutput>
#w/GetGamesimAvgScore.recordcount#<br>
#w# - #GetGamesimAvgScore.recordcount - w#
</cfoutput> --->

<p>
</p>


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
and i.gametime >= '#mygametime#'
and i.PIPAdv   = s.und
and i.RebAdv   = s.und
and i.FGPCTAdv = s.und
and whocovered <> 'PUSH'
and s.spd > 0
order by s.gametime desc
</cfquery>

<cfoutput query="GetGames">
<cfquery datasource="NBA" name="upd">
Update FinalPicks 
Set SYS80 = '#und#'
where Gametime = '#mygametime#'
and Und = '#GetGames.Und#'
and spd >= 5.5
</cfquery>
</cfoutput>


<cfquery datasource="NBA" name="GetGames">
Select fp.und 
from finalpicks fp
where fp.gametime = '#mygametime#'
and fp.FavHealthL7  < -7
and fp.UndHealthL7  > fp.FavHealthL7
and fp.spd >= 4
</cfquery>

<p>
SYS35....................
<cfdump var="#GetGames#">
<p>


<cfoutput query="GetGames">
#gametime#....#und#<br>

<cfquery datasource="NBA" name="upd">
Update FinalPicks 
Set SYS35 = '#GetGames.und#'
where Gametime = '#mygametime#'
and Und = '#GetGames.Und#'
</cfquery>

</cfoutput>


<cfquery datasource="NBA" name="GetGames">
Select fp.und 
from finalpicks fp
where fp.gametime = '#mygametime#'
and fp.FavLatestCovCt = 3
and fp.UndLatestCovCt < 2
</cfquery>


<cfoutput query="GetGames">
#gametime#....#und#<br>

<cfquery datasource="NBA" name="upd">
Update FinalPicks 
Set SYS32 = '#GetGames.und#'
where Gametime = '#mygametime#'
and Und = '#GetGames.Und#'
</cfquery>

</cfoutput>



<hr>
<cfinclude template="TopUnderdogPlays.cfm">
<p>
<cfinclude template="TopFavoritePlays.cfm">

<cfquery datasource="Nba" name="UPDATE">
	Insert into NBADataLoadStatus
	(
	ProgramName
	)
	values
	(
	'Did PotentialProfitableSystems.cfm'
	)
</cfquery>


<cfcatch type="any">
  
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.Detail#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:PotentialProfitableSystems.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>

</cfcatch>

</cftry>




