<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

<cfset win = 0>
<cfset tm1 = 'powrecent'>
<cfset tm2 = 'gapha'>
<cfset tm2 = 'gapha'>

<cfquery datasource="nba" name="GetPicks">
Select distinct * from FinalPicks 
where gametime >= '20081201'
and whocovered <> 'PUSH'
and #tm1# <> ''
and #tm2# <> ''
order by gametime desc
</cfquery>

<cfset totscen = 0>
<cfoutput query="GetPicks">

<cfset str1 = 'GetPicks.' & '#tm1#'>
<cfset str2 = 'GetPicks.' & '#tm2#'>

***************************************<br>
'#evaluate(str1)#' vs '#evaluate(str2)#'<br>
****************************************<br>

<cfif Findnocase('#evaluate(str1)#','#evaluate(str2)#') gt 0 or Findnocase('#evaluate(str2)#','#evaluate(str1)#') gt 0 >

WHO COVERED: #Whocovered# - #tm1# vs #tm2#<br>
<cfset totscen = totscen + 1>

<cfif Findnocase('#Whocovered#','#evaluate(str1)#') gt 0>
	<cfset win = win + 1>
	WINNER!<br>
</cfif>

</cfif>

</cfoutput> 

<cfoutput>
Number of wins is #win# out of #totscen#
</cfoutput>




===============================================<br>
PredStatsFav<br>

<cfset win = 0>
<cfquery datasource="nba" name="GetPicks">
Select distinct * from FinalPicks 
where PredStatsFav <> ''
and gametime >= '20081201'
and whocovered <> 'PUSH'
and FavPlayedYest = 'N'
order by gametime desc
</cfquery>

<cfoutput query="GetPicks">
#WhoCovered# - #PredStatsFav# <br>

<cfif Findnocase('#Whocovered#','#PredStatsFav#') gt 0>
	<cfset win = win + 1>
	WINNER!<br>
</cfif>

</cfoutput> 

<cfoutput>
Number of wins is #win#
</cfoutput>



===============================================<br>
PredStatsUnd<br>

<cfset win = 0>
<cfquery datasource="nba" name="GetPicks">
Select distinct * from FinalPicks 
where PredStatsUnd <> ''
and gametime >= '20081201'
and whocovered <> 'PUSH'
and UndPlayedYest = 'N'
order by gametime desc
</cfquery>

<cfoutput query="GetPicks">
#WhoCovered# - #PredStatsUnd# <br>

<cfif Findnocase('#Whocovered#','#PredStatsUnd#') gt 0>
	<cfset win = win + 1>
	WINNER!<br>
</cfif>

</cfoutput> 

<cfoutput>
Number of wins is #win#
</cfoutput>



===============================================<br>
30ratfav<br>

<cfset win = 0>
<cfquery datasource="nba" name="GetPicks">
Select distinct * from FinalPicks 
where ThirtyRatFav <> ''
and gametime >= '20081201'
and whocovered <> 'PUSH'
and FavPlayedYest = 'N'
order by gametime desc
</cfquery>

<cfoutput query="GetPicks">
#WhoCovered# - #ThirtyRatFav# <br>

<cfif Findnocase('#Whocovered#','#ThirtyRatFav#') gt 0>
	<cfset win = win + 1>
	WINNER!<br>
</cfif>

</cfoutput> 

<cfoutput>
Number of wins is #win#
</cfoutput>






<cfquery datasource="nba" name="GetPicks">
Select distinct * from FinalPicks 
where WhoCovered not in ('','PUSH') 
and gametime >= '20081201'
order by gametime desc
</cfquery>

<cfset PowRecent_win = 0>
<cfset PowRecent_loss = 0>

<cfset commopp_Loss = 0> 
<cfset commopp_win = 0> 


<cfset HBlowout_Win = 0>
<cfset HBlowout_Loss = 0>
<cfset GameSimSide_Win = 0>
<cfset GameSimSide_Loss = 0>
<cfset GameSimSide60_Win = 0>
<cfset GameSimSide60_Loss = 0>

<cfset GAP_Win = 0>
<cfset GAPHA_Win = 0>

<cfset GAP_Loss = 0>
<cfset GAPHA_Loss = 0>

<cfset fgreb_win = 0>
<cfset fgreb_loss = 0>

<cfset PredStatsFav_win = 0>
<cfset PredStatsFav_loss = 0>

<cfoutput query="GetPicks">

	<cfset WhoCovered2 = '**' & '#WhoCovered#'>
	<cfset WhoCovered1 = '*' & '#WhoCovered#'>

	
	<cfif GetPicks.HBlowoutScoring neq ''>
		Checking #gametime# - #GetPicks.HBlowoutScoring# is '#GetPicks.WhoCovered#'<br>
		<cfif GetPicks.HBlowoutScoring is '#GetPicks.WhoCovered#'>
			<cfset HBlowout_Win = HBlowout_Win + 1> 
		<cfelse>
			<cfset HBlowout_Loss = HBlowout_Loss + 1> 
		</cfif>
	</cfif>

	
	<cfif GetPicks.GameSimSide neq '' and findnocase('Not',GetPicks.GameSimSide) is 0>
		Checking #gametime# - #GetPicks.GameSimSide# is #WhoCovered# or '#GetPicks.GameSimSide#' is '#WhoCovered2#' <br>
		<cfif ('#trim(GetPicks.GameSimSide)#' is '#trim(WhoCovered)#') or ('#trim(GetPicks.GameSimSide)#' is '#trim(WhoCovered2)#') >
			true!<br>
			<cfset GameSimSide_Win = GameSimSide_Win + 1> 
		<cfelse>
			<cfset GameSimSide_Loss = GameSimSide_Loss + 1> 
		</cfif>
	<cfelse>
	Skipping................Checking #gametime# - #GetPicks.GameSimSide# is #WhoCovered# or '#GetPicks.GameSimSide#' is '#WhoCovered2#' <br>
	</cfif>
	
	<cfif FindNoCase('#WhoCovered#','#GetPicks.GameSimSide#') gt 0 and findnocase('Not',GetPicks.GameSimSide) is 0>>
		Checking #gametime# - #GetPicks.GameSimSide# is #WhoCovered# or '#GetPicks.GameSimSide#' is '#WhoCovered2#' <br>
		<cfif '#trim(GetPicks.GameSimSide)#' is '#trim(WhoCovered2)#' >
			true!<br>
			<cfset GameSimSide60_Win = GameSimSide60_Win + 1> 
		<cfelse>
			<cfset GameSimSide60_Loss = GameSimSide60_Loss + 1> 
		</cfif>
	</cfif>

	<cfif '#GetPicks.FGREB#' neq ''>
		Checking #gametime# - #GetPicks.GameSimSide# is #WhoCovered# or '#GetPicks.GameSimSide#' is '#WhoCovered2#' <br>
		<cfif '#trim(GetPicks.FGREB)#' is '#trim(WhoCovered)#' >
			true!<br>
			<cfset fgreb_Win = fgreb_Win + 1> 
		<cfelse>
			<cfset fgreb_Loss = fgreb_Loss + 1> 
		</cfif>
	</cfif>
	
	
	
	<hr>
	<hr>
	
	
	
	<cfif '#GetPicks.PredStatsFav#' neq ''>
		=================================>Checking #gametime# - '#trim(GetPicks.PredStatsFav)#' is '#trim(WhoCovered1)#' <br>
		<cfif '#trim(GetPicks.PredStatsFav)#' is '#trim(WhoCovered1)#' >
			true!<br>
			<cfset PredStatsFav_Win = PredStatsFav_Win + 1> 
		<cfelse>
			<cfset PredStatsFav_Loss = PredStatsFav_Loss + 1> 
		</cfif>
	</cfif>

	<cfif '#GetPicks.GAP#' neq ''>
		<cfif '#trim(GetPicks.GAP)#' is '#trim(WhoCovered)#' or '#trim(GetPicks.GAP)#' is '#trim(WhoCovered2)#'  >
			<cfset GAP_Win = GAP_Win + 1> 
		<cfelse>
			<cfset GAP_Loss = GAP_Loss + 1> 
		</cfif>
	</cfif>

	<cfif '#GetPicks.GAPHA#' neq ''>
		<cfif '#trim(GetPicks.GAPHA)#' is '#trim(WhoCovered)#'  or '#trim(GetPicks.GAPHA)#' is '#trim(WhoCovered2)#'  >
			<cfset GAPHA_Win = GAP_Win + 1> 
		<cfelse>
			<cfset GAPHA_Loss = GAP_Loss + 1> 
		</cfif>
	</cfif>
	

	<cfif '#GetPicks.CommonOpp#' neq ''>
		<cfif '#trim(GetPicks.CommonOpp)#' is '#trim(WhoCovered)#'  or '#trim(GetPicks.CommonOpp)#' is '#trim(WhoCovered2)#'  >
			<cfset commopp_Win = commopp_Win + 1> 
		<cfelse>
			<cfset commopp_Loss = commopp_Loss + 1> 
		</cfif>
	</cfif>

	<cfif '#GetPicks.PowRecent#' neq ''>
		<cfif '#trim(GetPicks.PowRecent)#' is '#trim(WhoCovered)#'  or '#trim(GetPicks.PowRecent)#' is '#trim(WhoCovered2)#'  >
			<cfset PowRecent_Win = PowRecent_Win + 1> 
		<cfelse>
			<cfset PowRecent_Loss = PowRecent_Loss + 1> 
		</cfif>
	</cfif>

	
	
</cfoutput>

<cfoutput>
HBlow: Total Wins #HBlowout_Win#<br>
HBlow: Total Losses #HBlowout_Loss#<br>
<hr>
GameSimSide: Total Wins #GameSimSide_Win#<br>
GameSimSide: Total Losses #GameSimSide_Loss#<br>
<hr>
GameSimSide60: Total Wins #GameSimSide60_Win#<br>
GameSimSide60: Total Losses #GameSimSide60_Loss#<br>
<hr>
fgreb: Total Wins #fgreb_Win#<br>
fgreb: Total Losses #fgreb_Loss#<br>

<hr>
FavStatsPred: Total Wins #PredStatsFav_Win#<br>
FavStats: Total Losses #PredStatsFav_Loss#<br>

<hr>
GAP: Total Wins #GAP_Win#<br>
GAP: Total Losses #GAP_Loss#<br>
<hr>

GAPHA: Total Wins #GAPHA_Win#<br>
GAPHA: Total Losses #GAPHA_Loss#<br>
<hr>

Commopp: Total Wins #commopp_Win#<br>
Commopp: Total Losses #commopp_Loss#<br>
<hr>

PowRecent: Total Wins #powrecent_Win#<br>
PowRecent: Total Losses #powrecent_Loss#<br>
<hr>


</cfoutput>


</body>
</html>
