 <cfset myUserCFC = createObject("component", "PSP2012.NFL.FORMS.User") />
<cfset myPBPCFC = createObject("component", "NBAPBP") />


<cfquery datasource="nba" name="GetDay">
Select Gametime 
from NBAGametime
</cfquery>



<cfset theday = GetDay.Gametime> 

<cfquery name="Games" datasource="nba">
Select distinct n.* 
from NbaSchedule n
where n.Gametime = '#theDay#'
and (Select Count(*) from NBAPicks where systemid='SYS24' and gametime = '#theday#' and n.fav = fav) < 9
</cfquery>

<cfoutput>
=======> #Games.recordcount#
</cfoutput>


<cfif Games.recordcount is 0>
	
<cfquery name="Games" datasource="nba">
Select distinct n.* 
from NbaSchedule n
where n.Gametime = '#theDay#'
</cfquery>

<table border="1" width="50%">
<tr>
<td>Fav</td>
<td>Spread</td>
<td>Und</td>
<td>Spread Pick</td>
<td>Rating</td>
<td>Total</td>
<td>Our Total</td>

</tr>	
<cfloop query="Games">	
	
<cfquery name="FavCoverCt" datasource="nba">
Select count(*) as ct
from NbaPicks
where Gametime = '#theDay#'
and systemid='SYS24'
and Sidewinner = '#Games.fav#'
group by fav,spd,und,sidewinner 
</cfquery>

<cfquery name="UndCoverCt" datasource="nba">
Select count(*) as ct
from NbaPicks
where Gametime = '#theDay#'
and systemid='SYS24'
and Sidewinner = '#Games.und#'
group by fav,spd,und,sidewinner 
</cfquery>


<cfif FavCoverCt.ct gt UndCoverCt.ct>
	<cfset mysidewinner = "#Games.fav#">
	<cfquery name="CoverCt" datasource="nba">
	Select Avg(PickRating) as pr, Avg(Favscore + UndScore) as pts
	from NbaPicks
	where Gametime = '#theDay#'	
	and systemid='SYS24'
	and Sidewinner = '#Games.fav#'
	group by fav,spd,und,sidewinner 
	</cfquery>
</cfif>

<cfif FavCoverCt.ct lte UndCoverCt.ct>
	<cfset mysidewinner = "#Games.und#">
	<cfquery name="CoverCt" datasource="nba">
	Select Avg(PickRating) as pr,Avg(Favscore + UndScore) as pts
	from NbaPicks
	where Gametime = '#theDay#'	
	and systemid='SYS24'
	and Sidewinner = '#Games.und#'
	group by fav,spd,und,sidewinner 
	</cfquery>
</cfif>
<cfoutput>

<tr>
<td>
#Games.fav#	
</td>
<td>
#Games.spd#	
</td>
<td>
#Games.und#	
</td>
<td>
	
	<cfif CoverCt.pr gte 3.5>
	<strong>Play On:#mysidewinner#</strong>		
	<cfelse>
	#mysidewinner#
	</cfif>
</td>

<td>
#Numberformat(CoverCt.pr,'999.99')#	
</td>

<td>
#Games.ou#	
</td>

<td>
#Numberformat(Coverct.pts,'999.9')#	
</td>

</tr>
</cfoutput>
</cfloop>
</table>

</cfif>

<cfloop query="Games">

	<cfset fav = Games.Fav>
	<cfset und = Games.und>
	<cfset spd = Games.spd >
	
	<cfif Games.ha is 'H'>
		
		<cfset thehometeam = fav>
		<cfset theawayteam = und>
		
	<cfelse>	
		<cfset thehometeam = und>
		<cfset theawayteam = fav>

	</cfif>	



<cfquery datasource="Nba" name="GetRunct">
	Select RunCt,Gametime
	from NBAGameTime
</cfquery>

<cfset yyyy = left(GetRunCt.gametime,4)>
<cfset mm   = mid(GetRunCt.gametime,5,2)>
<cfset dd   = right(GetRunCt.gametime,2)>
<cfset mydate = #Dateformat(DateAdd("d",0,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
<CFSET PriorDAY = #Dateformat(DateAdd("d",-1,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
<CFSET PriorDAYSTR = ToString(PriorDay)>

<cfset GameTime2 = mydate>
<cfset GameTime = ToString(GameTime2)>

<cfquery datasource="Nba" name="GetFavPlayedYest">
	Select *
	from NBASchedule
	where Gametime = '#PriorDaystr#'
	and (Fav = '#Games.fav#' or Und = '#Games.fav#')
</cfquery>

<cfquery datasource="Nba" name="GetUndPlayedYest">
	Select *
	from NBASchedule
	where Gametime = '#PriorDaystr#'
	and (Und = '#Games.Und#' or Fav = '#Games.Und#')
</cfquery>





<!--- Create the Drivechart Percents --->

<cfset FavDCOff  = myPBPCFC.getDriveInfo('O','#Fav#')>
<cfset UndDCOff  = myPBPCFC.getDriveInfo('O','#Und#')>

<cfset FavDCDef  = myPBPCFC.getDriveInfo('D','#Fav#')>
<cfset UndDCDef  = myPBPCFC.getDriveInfo('D','#Und#')>


<cfset FAVDC.turnoverpct = (FavDCOff.turnoverpct + UndDCDef.TurnoverPct)/2>
<cfset FAVDC.FTApct      = (FavDCOff.FTApct)>
<cfset FAVDC.Insidepct   = (FavDCOff.Insidepct)>
<cfset FAVDC.Outsidepct  = (FavDCOff.Outsidepct)>
<cfset FAVDC.Normalpct   = (FavDCOff.Normalpct)>
<cfset FAVDC.MakeInsidePct = (FavDCOff.MakeInsidePct + UndDCDef.MakeInsidePct)/2>
<cfset FAVDC.MakeNormalPct = (FavDCOff.MakeNormalPct + UndDCDef.MakeNormalPct)/2>
<cfset FAVDC.MakeOutsidePct = (FavDCOff.MakeOutsidePct + UndDCDef.MakeOutsidePct)/2>
<cfset FAVDC.Q1     = FavDCOff.Q1>
<cfset FAVDC.Q2     = FavDCOff.Q2>
<cfset FAVDC.Q3     = FavDCOff.Q3>
<cfset FAVDC.Q4     = FavDCOff.Q4>

<cfset UNDDC.turnoverpct = (UndDCOff.turnoverpct + FavDCDef.TurnoverPct)/2>
<cfset UNDDC.FTApct      = (UndDCOff.FTApct)>
<cfset UNDDC.Insidepct   = (UndDCOff.Insidepct)>
<cfset UNDDC.Outsidepct  = (UndDCOff.Outsidepct)>
<cfset UNDDC.Normalpct   = (UndDCOff.Normalpct)>
<cfset UNDDC.MakeInsidePct = (UndDCOff.MakeInsidePct + FavDCDef.MakeInsidePct)/2>
<cfset UNDDC.MakeNormalPct = (UndDCOff.MakeNormalPct + FavDCDef.MakeNormalPct)/2>
<cfset UNDDC.MakeOutsidePct = (UndDCOff.MakeOutsidePct + FavDCDef.MakeOutsidePct)/2>
<cfset UNDDC.Q1     = UndDCOff.Q1>
<cfset UNDDC.Q2     = UndDCOff.Q2>
<cfset UNDDC.Q3     = UndDCOff.Q3>
<cfset UNDDC.Q4     = UndDCOff.Q4>

<cfquery name="GetFavFTPct" datasource="nba">
	Select Avg(OFtPct) as ftpct
	from Nbadata
	where team     = '#fav#'
</cfquery>

<cfquery name="GetUndFTPct" datasource="nba">
	Select Avg(OFtPct) as ftpct
	from Nbadata
	where team     = '#Und#'
</cfquery>



<!--- Get count of all Possesions for both teams --->
<cfquery name="GetFavCt" datasource="nba">
	Select Avg(myct) as avgct
	from
	(
	Select count(*) as myct
	from NBADriveCharts
	where OffDef = 'O'
	and team     = '#fav#'
	and Result in ('BLOCKEDSHOT','2PTMISS','2PTMADE','3PTMISS','3PTMADE','TURNOVER','FREETHROWMADE','FREETHROWMISS')
	
	Group By GameTime
	)
</cfquery>


<!--- Get count of all Possesions for both teams --->
<cfquery name="GetFavDefCt" datasource="nba">
	Select Avg(myct) as avgct
	from
	(
	Select count(*) as myct
	from NBADriveCharts
	where OffDef = 'D'
	and team     = '#fav#'
	and Result in ('BLOCKEDSHOT','2PTMISS','2PTMADE','3PTMISS','3PTMADE','TURNOVER','FREETHROWMADE','FREETHROWMISS')
	
	Group By GameTime
	)
</cfquery>




<cfquery name="GetUndCt" datasource="nba">
	Select Avg(myct) as avgct
	from
	(
	Select count(*) as myct
	from NBADriveCharts
	where OffDef = 'O'
	and team     = '#und#'
	and Result in ('BLOCKEDSHOT','2PTMISS','2PTMADE','3PTMISS','3PTMADE','TURNOVER','FREETHROWMADE','FREETHROWMISS')
	
	Group By GameTime
	)
</cfquery>


<!--- Get count of all Possesions for both teams --->
<cfquery name="GetUndDefCt" datasource="nba">
	Select Avg(myct) as avgct
	from
	(
	Select count(*) as myct
	from NBADriveCharts
	where OffDef = 'D'
	and team     = '#und#'
	and Result in ('BLOCKEDSHOT','2PTMISS','2PTMADE','3PTMISS','3PTMADE','TURNOVER','FREETHROWMADE','FREETHROWMISS')
	
	Group By GameTime
	)
</cfquery>



<!--- 
<cfoutput>
#GetUndCt.avgct#
</cfoutput>

<cfdump var="#FavDC#">
<cfdump var="#UndDC#">
 --->


<!--- Start Game Simulation --->

<cfset FavTotPoss = (GetFavCt.avgct + GetUndDefct.avgct)/2>
<cfset UndTotPoss = (GetUndCt.avgct + GetFavDefct.avgct)/2>
<cfset scr = 0>
<cfset FavPredScr = 0>
<cfset UndPredScr = 0>

<cfloop index="xx" from="1" to="2">
	
	<cfif xx is 1>
		<cfset PossFor    = '#fav#'>
	<cfelse>
		<cfset PossFor    = '#und#'>
	</cfif>
	
	<cfif PossFor is '#fav#'>
		<cfset TotPoss = FavTotPoss>
	<cfelse>
		<cfset TotPoss = UndTotPoss>
	</cfif>


<cfloop index="i" from="1" to="200" >

	<cfset Posct = 0>
	<cfset FavTotPts = 0>
	<cfset UndTotPts = 0>

	<cfset done    = false>

<cfloop condition="done is false">
<!--- 

	<cfoutput>Fav Tot Pos = #FavTotPoss#</cfoutput>
 --->

<!--- Create a random number  --->
<cfset rn = myPBPCFC.getRandomNum(1,100)>
<cfset rn = myPBPCFC.getRandomNum(1,100)>

<cfset TurnoverRge = FavDC.TurnoverPct>
<cfset FTARge      = TurnoverRge + FavDC.TurnoverPct>

<!--- 
<cfdump var="#TurnoverRge#">
<cfdump var="#FTARge#">
 --->

<cfset Play = ''>
<!--- Check Playfor Turnover --->
<cfif rn lte FavDC.TurnoverPct >
	<cfset Play='TURNOVER'>
	
</cfif>


<!--- 
<cfoutput>
rn was #rn#<br>
</cfoutput>
 --->

<!--- Check Playfor Turnover --->
<cfif Play neq 'TURNOVER'>

	<!--- See if play was a FreeThrow --->
	<cfif rn gt  FAVDC.TurnoverPct and rn lte FAVDC.FTAPct>
		<cfset Play = 'FTA'>
		
		<cfif xx is 1>
		<cfoutput>
		<cfif rn gte 1 and rn lte #GetFavFTPct.ftpct#>
			<cfset FavTotPts = FavTotPts + 1>
		</cfif>
		</cfoutput>
		
		<cfelse>
		
		<cfoutput>
		<cfif rn gte 1 and rn lte #GetUndFTPct.ftpct#>
			<cfset FavTotPts = FavTotPts + 1>
		</cfif>
		</cfoutput>
		
		</cfif>
		
	</cfif>
	
	
</cfif>

<!--- If Not a Turnover or FTA.... See what type of shot was taken --->
<cfset ShotRange = ''>

<cfif Play is ''>
	<cfset InsideRge     = round(favDC.InsidePct)>
	<cfset OutsideRge    = round(InsideRge + FavDC.OutsidePct)>
	<cfset NormalRge     = OutsideRge + 1>

	
	<cfif rn gte 1 and rn lte InsideRge>
		<cfset ShotRange = 'INSIDE'>
	<cfelseif rn gt InsideRge and rn lte OutsideRge>
		<cfset ShotRange = 'OUTSIDE'>
	<cfelse>
		<cfset ShotRange = 'NORMAL'>
	</cfif>

	<!--- <cfdump var="#InsideRge#">
	<cfdump var="#OutsideRge#">
	<cfdump var="#NormalRge#"> --->
	
	<!--- <cfoutput>
	The Shot Range was #ShotRange#
	</cfoutput> --->
	
	<!--- See if shot was made or missed --->
	<!--- Create a random number  --->
	<cfset rn = myPBPCFC.getRandomNum(1,100)>
	<cfset rn = myPBPCFC.getRandomNum(1,100)>

	<cfif PossFor is '#fav#'>
	<cfoutput>
	<cfset checkPct = evaluate('FavDC.Make#ShotRange#Pct')>
	</cfoutput>
	
	<cfelse>
	<cfoutput>
	<cfset checkPct = evaluate('UndDC.Make#ShotRange#Pct')>
	</cfoutput>
	</cfif>	
	
	
	
	
	<cfset ShotMade = 'N'>
	<cfif rn lte checkpct>
		<cfset ShotMade = 'Y'>
	</cfif>	
	
	<cfif ShotMade is 'Y'>
		<cfoutput>
		<cfswitch expression="#Shotrange#">
			<cfcase value='INSIDE'>
				<cfset FavTotPts = FavTotPts + 2>
				<!--- Inside Shot Made<br> --->
			</cfcase>
			
			<cfcase value='NORMAL'>
				<cfset  FavTotPts = FavTotPts + 2>
				<!--- Normal Shot Made<br> --->
			</cfcase>
			
			<cfcase value='OUTSIDE'>
				<cfset  FavTotPts = FavTotPts + 3>
				<!--- Outside Shot made <br> --->
			</cfcase>
			
		</cfswitch>
		</cfoutput>
	<cfelse>
		<!--- Shot missed!<br> --->
	</cfif>
	
</cfif>

<cfset PosCt = PosCt + 1 >
<!--- 
<cfoutput>
	The Play was #Play#<br>
</cfoutput>
 --->

<!--- 
<cfoutput>
<cfset FAVPosCt = FavPosCt + 1 >	
Tot Points so far is: #favTotPts#<br>
</cfoutput>
 --->

<cfif PosCt ge TotPoss>
	<cfset done = true>
</cfif>	

</cfloop>
<!--- 
<cfoutput>
Total Points were: #FavTotPts#
</cfoutput>
 --->
 
<cfset scr = scr + FavTotPts>

<!--- Add 2 more points for the Favorite --->
<cfif xx is 1>
	<cfset scr = scr + 2>
</cfif>


<!--- <cfoutput>
scr = #scr#<br>
</cfoutput> --->
</cfloop>

<cfset final = (scr/200) - 8>

<cfset StoreForFav = false>
<cfset StoreForUnd = false>

<cfif Possfor is thehometeam>
	<cfset final = final + 2.5>
</cfif>	
	
<cfif Possfor is '#fav#' >	
	<cfset Final = final + 1.25>
	<cfif GetUndPlayedYest.recordcount neq 0>
		<cfset Final = final + 2.5>
	</cfif>
		
	<cfset StoreForFav = true>
	<cfset FavPredScr = final>
</cfif>	


<cfif Possfor is '#und#' >	
	<cfif GetFavPlayedYest.recordcount neq 0>
		<cfset Final = final + 2.5>
	</cfif>

	<cfset StoreForUnd = true>
	<cfset UndPredScr = final>
</cfif>	

	
<cfoutput>
#PossFor# Predicted Score = #final#<br>
</cfoutput>

<cfset scr       = 0>
<cfset FavTotPts = 0>
<cfset myrat     = 0>
<cfset mySideWinner = 'PASS'>

<cfif FavPredScr gt 0 and UndPredScr gt 0>
	<cfif (FavPredScr - UndPredscr) gt #spd#>
		<cfset mySideWinner = '#fav#'>
		<cfset myrat = ((FavPredScr - UndPredscr) - spd) >	
	</cfif>	
		
	<cfif (FavPredScr - UndPredscr) lt #spd#>
		<cfset mySideWinner = '#und#'>
		<cfset myrat = (spd - (FavPredScr - UndPredscr)) >	
	</cfif>	
		
	<cfif (UndPredscr gte FavPredScr)>
		<cfset mySideWinner = '#und#'>
		<cfset myrat = ((UndPredScr - FavPredscr) + spd) >	
	</cfif>	
		
	<cfquery name="GetPick" datasource="nba">
		Insert into NBAPicks(Fav,spd,Und,FavScore,UndScore,SideWinner,PickRating,SystemId,gametime)
		values ('#fav#',#spd#,'#und#',#favPredscr#,#undPredscr#,'#mySideWinner#',#myrat#,'SYS24','#theday#')
	</cfquery>
	
</cfif>


</cfloop>

<cfabort>
</cfloop>
<!--- 
<cfoutput query="Games">

		
	<!--- Get the page that has the Play By Play Data --->
	<cfset myurl = 'http://www.nba.com/games/#theday#/#theawayteam##thehometeam#/gameinfo.html'>
 --->
