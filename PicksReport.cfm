<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<!--- <cfscript>
Writeoutput('<cfif Session.IsLoggedIn is "N"><cfinclude template="Login.cfm"></cfif>');
</cfscript>
 --->
<cfset myyear  = Year(now())>
<cfset mymonth = Numberformat(Month(now()),'00')>
<cfset myday   = Numberformat(Day(now()),'00')>

<cfset mydate = myyear & mymonth & myday>

<body>

<cfquery datasource="Nba" name="GetRunct">
	Select RunCt,Gametime
	from NBAGameTime
</cfquery>

<cfset Session.Gametime = '#GetRunct.gametime#'>

<!--- 
<cfset Session.Gametime = '20160126'>
 --->


<cfquery datasource="nba" name="Addit">
	Select * from NBAPicks
	where SystemId = 'GameSimHAForAvgs'
	and Gametime = '#Session.Gametime#'
</cfquery>




<cfoutput>
<div align="center"><h2>NBA Game Simulator Picks for: #Left(Session.Gametime,4)#-#mid(Session.Gametime,5,2)#-#Right(Session.Gametime,2)#</h2></div>
<br>
<div align="center" >**Highly Recommended Play<br>
* Recommended Play</div>
</cfoutput>
<table align='center' width="70%" border="1">
<tr>
<td>
Favorite
</td>
<td>
H/A
</td>
<td>
Spread
</td>
<td>
Underdog
</td>
<td>
Our SIDE Pick
</td>
<td>
% Confident
</td>
<td>
TOTAL
</td>
<td>
Our TOTAL Pick
</td>
<td>
% Confident
</td>
</tr>
<cfoutput query="Addit">
<tr>
<td>
#Fav#
</td>
<td>
#HA#
</td>
<td>
#Spd#
</td>
<td>
#Und#
</td>

<cfset totdesc = "">
<cfif trim('#oupick#') is 'O'>
	<cfset totdesc = 'OVER'>
<cfelse>
	<cfset totdesc = 'UNDER'>
</cfif>

<cfif pct ge 60><b><i><td bgcolor="Yellow">*<cfelse><td></cfif>#Pick#
</td>

<cfif pct ge 60><b><i><td bgcolor="Yellow"><cfelse><td></cfif>#pct#%
</td>

<td>
#ou#
</td>

<cfif oupct ge 60><b><i><td bgcolor="Yellow">*<cfelse><td></cfif>#totdesc#
</td>

<cfif oupct ge 60><b><i><td bgcolor="Yellow">*<cfelse><td></cfif>#numberformat(oupct,'99.99')#%
</td>
</tr>
</cfoutput>


<cfoutput query="Addit">
<cfif Trim(Addit.oupick) is 'U'>
	<cfset oudesc = 'UNDER'>
<cfelse>
	<cfset oudesc = 'OVER'>
</cfif>

<cfset useit = '+'>
<cfif '#trim(pick)#' is '#Trim(Fav)#'>
	<cfset useit = '-'>
</cfif>

<cfif ha is 'H'>
Game: #und# at #fav#
<cfelse>
Game: #fav# at #und#
</cfif>
<br>
Pick: <cfif Addit.pct ge 60><b><i>**</cfif>#Pick# #useit##spd# (Confidence = #pct#%) <cfif Addit.pct ge 60></i></b>
		<cfquery datasource="Nba" name="GetDefEff">
			UPDATE FinalPicks
				Set SYS30 = '#pick#'
			Where gametime = '#Session.GameTime#'
			and (Fav = '#addit.Fav#')
		</cfquery> 
		
	</cfif><br>
Pick: <cfif Addit.oupct ge 60><b><i>*</cfif>#oudesc# #ou# (Confidence = #numberformat(oupct,'99.99')#% <cfif Addit.oupct ge 60></i></b></cfif>
<hr>


<cfquery datasource="Nba" name="GetDefEff">
			UPDATE FinalPicks
				Set SYS0 = '#pick#'
			Where gametime = '#Session.GameTime#'
			and (Fav = '#addit.Fav#')
</cfquery>


</cfoutput>

<!--- <cfscript>
Writeoutput('<tr><td align="center" colspan="9"><div align="center"><a href="../temp/index.cfm">Home</a></div></td></tr>');
</cfscript> --->

</table>

<cfset mygametime = '#Session.Gametime#'>

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
			We like the #oudesc# #ou# in the #fav#/#und# game, with a big blowout chance of #pctBig#%<br>
	</cfif>
	</cfif>

</cfoutput>	

<cfset mygametime = '#Session.Gametime#'>

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
		<cfset oudesc = 'FAVORITE'>
		<cfset pctBig = pctBigFav>
	</cfif>
	<cfif pctFav lt pctUnd>
		<cfset oudesc = 'UNDERDOG'>
		<cfset pctBig = pctBigUnd>
	</cfif>
	
	<cfif recPick is 'Y'>
			We like the #oudesc# #spd# in the #fav#/#und# game, with a big blowout chance of #pctBig#%<br>
	</cfif>
	</cfif>

</cfoutput>	






</body>
</html>
