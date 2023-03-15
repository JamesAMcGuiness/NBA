<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>
	
<!--- <cfquery datasource="Nba" name="GetRunct">
	Delete from TeamHealth
</cfquery> --->
	
<cfset FavWeekWeary = 0 >
<cfset UndWeekWeary = 0 >	
<cfquery datasource="Nba" name="GetRunct">
	Select Gametime
	from NBAGameTime
</cfquery>



<cfset GameTime = GetRunct.GameTime>

<cfquery datasource="Nba" name="GetStatus">
	Select *
	from NBADataLoadStatus
	where gametime = '#GetRunCt.Gametime#'
	and StepName = 'TEAMHEALTH'
</cfquery>



<cfset Skipit = false>
<!---
<cfif GetStatus.recordcount neq 0 >
 <cfset Skipit = true>
</cfif> --->


<cfif skipit is false>


<cfquery datasource="Nba" name="GetRunct">
	Select RunCt,Gametime
	from NBAGameTime
</cfquery>

<cfset myfavstruc = structnew()>
<cfset myundstruc = structnew()>


<cfset yyyy     = left(GetRunCt.gametime,4)>
<cfset mm       = mid(GetRunCt.gametime,5,2)>
<cfset dd       = right(GetRunCt.gametime,2)>

 
<!--- <cfset yyyy     = '2013'>
<cfset mm       = '03'>
<cfset dd       = '03'>
<cfset gametime = '20130303'>  --->


<cfset mydate   = #Dateformat(DateAdd("d",0,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
<CFSET prevweek = #Dateformat(DateAdd("d",-7,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
<CFSET prevweekstr  = ToString(prevweek)>

<CFSET prevday      = #Dateformat(DateAdd("d",-1,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
<CFSET prevdaystr   = ToString(prevday)>

<CFSET twodaysago    = #Dateformat(DateAdd("d",-2,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
<CFSET twodaysagostr = ToString(twodaysago)>



<cfset FavWeekWeary = 0 >
<cfset UndWeekWeary = 0 >




<cfquery datasource="nba" name="Getspds">
Select *
from nbaschedule
where GameTime = '#gametime#'
</cfquery>


<cfquery datasource="nba" name="GetRestTeams">
Select Team
from nbaavgs
where team not in (Select Fav from nbaschedule where gametime = '#gametime#')
and team not in (Select und from nbaschedule where gametime = '#gametime#')
</cfquery>



<cfoutput query="getspds">
	<cfset awayct = 0>
	<cfset favteam = "#Getspds.Fav#">
	<cfset undteam = "#Getspds.und#">
	<cfset fplayyest = 'N'>
	<cfset uplayyest = 'N'>
	
	<cfquery datasource="nba" name="GetFavTeamHealth">
	Select *
	from teamhealth
	where team in ('#favteam#')
	</cfquery>

	<cfquery datasource="nba" name="GetUndTeamHealth">
	Select *
	from teamhealth
	where team in ('#undteam#')
	</cfquery>


	<cfquery datasource="nba" name="GetitFavPrevDay">
	Select *
	from nbaschedule
	where GameTime = '#prevdaystr#'
	and (fav='#favteam#' or und='#favteam#')
	</cfquery>

	

	<cfif GetFavTeamHealth.recordcount gt 0 >
		<cfset FavWeekWeary = GetFavTeamHealth.TeamHealth>
	<cfelse>
		<cfset FavWeekWeary = 0>
	</cfif>
		
	<cfset PlayedYesterday = 'N'>
	<cfset PlayedYesterdayAway = 'N'>
	<cfset updateedit = false>




	<cfif GetItFavPrevDay.Recordcount is 1>
		<cfset PlayedYesterday = 'Y'>
		
		<!--- Fav was away yesterday --->
		<cfif (GetItFavPrevDay.Ha is 'A' and GetItFavPrevDay.fav is '#FavTeam#') or (GetItFavPrevDay.Ha is 'H' and GetItFavPrevDay.fav neq '#favTeam#')> 

			<cfset FavWeekWeary = Favweekweary -2>
			<cfset PlayedYesterdayAway = 'Y'>
			<cfset updateedit = true>
		</cfif>	
		
		<!--- Fav was home yesterday --->
		<cfif (GetItFavPrevDay.Ha is 'H' and GetItFavPrevDay.fav is '#FavTeam#') or (GetItFavPrevDay.Ha is 'A' and GetItFavPrevDay.fav neq '#favTeam#')>
			<cfset FavWeekWeary = Favweekweary -1>
			<cfset PlayedYesterdayAway = 'Y'>
			<cfset updateedit = true>
		</cfif>	
		
	<cfelse>
	

		<cfset FavWeekWeary = Favweekweary + 2>

	
		<cfset updateedit = true>
	</cfif>

	
	<cfset fplayyest = PlayedYesterday>



	<cfquery datasource="nba" name="GetitUndPrevDay">
	Select *
	from nbaschedule
	where GameTime = '#prevdaystr#'
	and (und='#undteam#' or fav='#undteam#')
	</cfquery>




	<cfset UndWeekWeary = GetUndTeamHealth.TeamHealth>
	
	<cfif UndWeekWeary is ''>
		<cfset UndWeekWeary = 0>
    </cfif>
	
	<cfset  updateedit = false>
	<cfset PlayedYesterday = 'N'>
	<cfset PlayedYesterdayAway = 'N'>



	<cfif GetItUndPrevDay.Recordcount is 1>
		<cfset PlayedYesterday = 'Y'>

		<!--- Und was home yesterday --->
		<cfif (GetItUndPrevDay.Ha is 'A' and GetItUndPrevDay.und is '#UndTeam#') or (GetItUndPrevDay.Ha is 'H' and GetItUndPrevDay.und neq '#UndTeam#')>
			<cfset UndWeekWeary = Undweekweary -1>
			<cfset PlayedYesterdayAway = 'Y'>
			<cfset updateedit = true>
		</cfif>	
		
		<!--- Und was away yesterday --->
		<cfif (GetItUndPrevDay.Ha is 'H' and GetItUndPrevDay.und is '#UndTeam#') or (GetItUndPrevDay.Ha is 'A' and GetItUndPrevDay.und neq '#UndTeam#')>
			<cfset UndWeekWeary = Undweekweary -2>
			<cfset PlayedYesterdayAway = 'Y'>
			<cfset updateedit = true>
		</cfif>	

	<cfelse>
			<cfset UndWeekWeary = Undweekweary + 2>
			<cfset updateedit = true>
	</cfif>
	
	
	<cfset uplayyest = PlayedYesterday>
	
	<cfif FavWeekWeary gt 0>
		<cfset FavWeekWeary = 0>
	</cfif>

	<cfif UndWeekWeary gt 0>
		<cfset UndWeekWeary = 0>
	</cfif>
	

<!--- 
	<cfquery datasource="nba" name="upd2">
	Update Blowout
	Set FHealth = #FavweekWeary + favawayweary#,
	    UHealth = #UndweekWeary + Undawayweary#,
		FplayedYest = '#fplayyest#',
		UplayedYest = '#uplayyest#'
	Where gametime = '#gametime#'
	and Fav = '#FavTeam#'
	</cfquery>

	
	#Favteam#...#FavweekWeary + favawayweary#<br>
	#Undteam#...#UndweekWeary + Undawayweary#<br>
 --->

	<cfif GetFavTeamHealth.recordcount neq 0>

	<hr>
	<!--- <cfquery datasource="nba" name="upd2">
	Update TeamHealth
	Set TeamHealth = #FavweekWeary# 
	Where Team = '#FavTeam#'
	</cfquery> --->
	
	<cfelse>
	
		<!--- <cfquery datasource="nba" name="upd2">
			Insert into TeamHealth(Team,TeamHealth) values ('#FavTeam#',#FavweekWeary#)
		</cfquery> --->
	
	</cfif>
	
	<!--- <cfif GetFavTeamHealth.recordcount neq 0>
		<cfquery datasource="nba" name="upd2">
		Update TeamHealth
		Set TeamHealth = #UndweekWeary# 
		Where Team = '#UndTeam#'
		</cfquery>

	<cfelse>
		<cfquery datasource="nba" name="upd2">
			Insert into TeamHealth(Team,TeamHealth) values ('#UndTeam#',#UndweekWeary#)
		</cfquery>
	
	</cfif> --->


<cfquery datasource="nba" name="upd">
	insert into FinalPicks(Gametime,Fav,spd,Und,ha,favPlayedYest,UndPlayedYest,FavHealth,UndHealth)
	values('#gametime#','#FavTeam#','#Getspds.spd#','#undteam#','#Getspds.ha#','#fplayyest#','#uplayyest#',#FavWeekWeary#,#UndWeekWeary#)
</cfquery>

</cfoutput>




<cfoutput query="GetRestTeams">

	*****************************************************************************************
	<br>
	

	<cfset awayct = 0>
	<cfset favteam = "#GetRestTeams.Team#">
	
	<cfset fplayyest = 'N'>
	
	
	<cfquery datasource="nba" name="GetFavTeamHealth">
	Select *
	from teamhealth
	where team in ('#favteam#')
	</cfquery>

	<cfquery datasource="nba" name="GetitFavPrevDay">
	Select *
	from nbaschedule
	where GameTime = '#prevdaystr#'
	and (fav='#favteam#' or und='#favteam#')
	</cfquery>

	<cfset FavWeekWeary = GetFavTeamHealth.TeamHealth>

	<cfif FavWeekWeary is ''>
		<cfset FavWeekWeary = 0>
    </cfif>


	<cfset PlayedYesterday = 'N'>
	<cfset PlayedYesterdayAway = 'N'>
	<cfset updateedit = false>

	<cfif GetItFavPrevDay.Recordcount is 1>
		<cfset PlayedYesterday = 'Y'>
		
		<!--- Team was away yesterday --->
		<cfif (GetItFavPrevDay.Ha is 'A' and GetItFavPrevDay.fav is '#FavTeam#') or (GetItFavPrevDay.Ha is 'H' and GetItFavPrevDay.fav neq '#FavTeam#') >
			<cfset FavWeekWeary = Favweekweary -2>
			<cfset PlayedYesterdayAway = 'Y'>
			<cfset updateedit = true>
		</cfif>	
		
		<!--- Team was home yesterday --->
		<cfif (GetItFavPrevDay.Ha is 'H' and GetItFavPrevDay.fav is '#FavTeam#') or (GetItFavPrevDay.Ha is 'A' and GetItFavPrevDay.fav neq '#FavTeam#') >
			<cfset FavWeekWeary = Favweekweary -1>
			<cfset PlayedYesterdayAway = 'Y'>
			<cfset updateedit = true>
		</cfif>	
				
	<cfelse>
		<cfset FavWeekWeary = Favweekweary + 3>
	</cfif>

	

	<cfset fplayyest = PlayedYesterday>
	
	<cfif FavWeekWeary gt 0>
		<cfset FavWeekWeary = 0>
	</cfif>

	<!--- <cfquery datasource="nba" name="upd22222">
	Update TeamHealth
	Set TeamHealth = #FavweekWeary# 
	Where Team = '#FavTeam#'
	</cfquery> --->

</cfoutput>

<cfquery datasource="Nba" name="GetStatus">
	Insert into NBADataLoadStatus (gametime,StepName)
	values('#GetRunCt.Gametime#','TEAMHEALTH')
</cfquery>
</cfif>
</body>
</html>
