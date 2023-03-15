<cfset myurl = 'https://www.basketball-reference.com/boxscores/pbp/201802150MIL.html'>


	<cfoutput>
	url = #myurl#<br>
	</cfoutput>




	<cfhttp url="#myurl#" method="GET">
	</cfhttp> 

<cfset mypage = #cfhttp.FileContent#>

<cfoutput>
#mypage#
</cfoutput>


<cfabort>


<cftry>

<cfset myUserCFC = createObject("component", "PSP2012.NFL.FORMS.User") />
<cfset myPBPCFC = createObject("component", "NBAPBP") />

<cfquery datasource="nba" name="GetDay">
Select Gametime 
from NBAGametime
</cfquery>
 

<cfset theday = '#GetDay.Gametime#'>
 
 
<!--- 
 <cfset theday = '20160312'>  
 --->



<!--- 
<cfquery datasource="nba" name="GetGames">
Select * 
from FinalPicks
where gametime='#theday#'
</cfquery>
 --->


<!--- 
<cfloop query="getgames">

<cfset theawayteam = '#Getgames.fav#'>
<cfset thehometeam = '#Getgames.und#'>


<cfquery datasource="nba" name="GetLeadChanges">
Select Sum(LeadChange) as lc
from NBADrivecharts
Where Team in('#theawayteam#','#thehometeam#')
and OffDef='O'
and gametime = '#theday#'
and result in ('2PTMADE','3PTMADE','2PTMISS','3PTMISS','FREETHROWMADE','FREETHROWMISSED')
</cfquery>

<!--- See what percent of the time Home team was in the lead --->
<cfquery datasource="nba" name="HGetTotPlays">
Select count(*) as totplays
from NBADrivecharts dch 
Where dch.Team = '#thehometeam#'
and dch.OffDef = 'O'
and dch.gametime = '#theday#'
and dch.result in ('2PTMADE','3PTMADE','2PTMISS','3PTMISS')
</cfquery>

<cfquery datasource="nba" name="AGetTotPlays">
Select count(*) as totplays
from NBADrivecharts dca 
Where dca.Team = '#theawayteam#'
and dca.OffDef = 'O'
and dca.gametime = '#theday#'
and dca.result in ('2PTMADE','3PTMADE','2PTMISS','3PTMISS')
</cfquery>

<cfset totplays = HGettotplays.totplays + aGettotplays.totplays>

<cfquery datasource="nba" name="aGetLeadPcts">
Select Sum(dca.Haslead)/#totplays# as hasleadpct
from NBADrivecharts dca 
Where dca.Team = '#theawayteam#'
and dca.OffDef = 'O'
and dca.gametime = '#theday#'
and dca.result in ('2PTMADE','3PTMADE','2PTMISS','3PTMISS')
</cfquery>

<cfquery datasource="nba" name="hGetLeadPcts">
Select Sum(dch.Haslead)/#totplays# as hasleadpct
from NBADrivecharts dch 
Where dch.Team = '#thehometeam#'
and dch.OffDef = 'O'
and dch.gametime = '#theday#'
and dch.result in ('2PTMADE','3PTMADE','2PTMISS','3PTMISS')
</cfquery>


<!--- See how may times HUGE leads a  --->
<cfquery datasource="nba" name="aUpBigPct">
Select Sum(dca.UpBig)/#totplays# as hasBIGleadpct
from NBADrivecharts dca 
Where dca.Team = '#theawayteam#'
and dca.OffDef = 'O'
and dca.gametime = '#theday#'
and dca.result in ('2PTMADE','3PTMADE','2PTMISS','3PTMISS')
</cfquery>

<cfquery datasource="nba" name="hUpBigPct">
Select Sum(dch.UpBig)/#totplays# as hasBIGleadpct
from NBADrivecharts dch 
Where dch.Team = '#thehometeam#'
and dch.OffDef = 'O'
and dch.gametime = '#theday#'
and dch.result in ('2PTMADE','3PTMADE','2PTMISS','3PTMISS')
</cfquery>


<!--- See how may times HUGE leads a  --->
<cfquery datasource="nba" name="aDownBigPct">
Select Sum(dca.DownBig)/#totplays# as downbig
from NBADrivecharts dca 
Where dca.Team = '#theawayteam#'
and dca.OffDef = 'O'
and dca.gametime = '#theday#'
and dca.result in ('2PTMADE','3PTMADE','2PTMISS','3PTMISS')
</cfquery>

<cfquery datasource="nba" name="hdownBigPct">
Select Sum(dch.DownBig)/#totplays# as downbig
from NBADrivecharts dch 
Where dch.Team = '#thehometeam#'
and dch.OffDef = 'O'
and dch.gametime = '#theday#'
and dch.result in ('2PTMADE','3PTMADE','2PTMISS','3PTMISS')
</cfquery>




<br>
<cfoutput>

Total Plays: #HGettotplays.totplays + aGettotplays.totplays#<br>
<hr>
#thehometeam# was in the lead #hGetLeadPcts.hasleadpct#<br>
#theawayteam# was in the lead #aGetLeadPcts.hasleadpct#<br>
<hr>
#thehometeam# was UP BIG #hUpBigPct.hasBIGleadpct#<br>
#theawayteam# was UP BIG #aUpBigPct.hasBIGleadpct#<br>
<hr>
#thehometeam# was DOWN BIG #hDownBigPct.downbig#<br>
#theawayteam# was DOWN BIG #aDownBigPct.downbig#<br>

<hr>
Total Lead Changes: #GetLeadChanges.lc#<br>
</cfoutput>

<p>
<p>
<p>

<cfquery datasource="nba" name="upd2">
Update TeamSituation
Set LastLeadChanges = #GetLeadChanges.lc#,
InLeadPct = #100*hGetLeadPcts.hasleadpct#,
UpBigPct  = #100*hUpBigPct.hasBIGleadpct#,
DownBigPct = #100*hDownBigPct.downbig#,
LastTotalPlays = #HGettotplays.totplays#
Where Team = '#thehometeam#'
and gametime = '#theday#'
</cfquery>

<cfquery datasource="nba" name="upd1">
Update TeamSituation
Set LastLeadChanges = #GetLeadChanges.lc#,
InLeadPct = #100*aGetLeadPcts.hasleadpct#,
UpBigPct  = #100*aUpBigPct.hasBIGleadpct#,
DownBigPct = #100*aDownBigPct.downbig#,
LastTotalPlays = #aGettotplays.totplays#
Where Team = '#theawayteam#'
and gametime = '#theday#'
</cfquery>


</cfloop>

<cfabort>
 --->

<!--- 
<cfquery datasource="nba" name="GetLeadChanges">
Select Sum(LeadChange)/4 as lc
from NBADrivecharts
Where Team in('DET','SAC')
</cfquery>

<cfoutput>
The total number of lead changes was: #GetLeadChanges.lc#
</cfoutput>
 --->



<cfquery datasource="nba" name="Del">
Delete from Debug
</cfquery>

 
<!--- <cfset theday = '20140311'> --->

<!--- <cfquery datasource="nba" name="Del">
Delete from NBADriveCharts where gametime = '#theday#'
</cfquery> --->

<!--- <cfset theday = '20141211'> --->
<cfset done = false>

<cfquery name="Games" datasource="nba">
Select distinct * 
from NbaSchedule 
where Gametime = '#theday#'
and fav not in (Select team from NBADrivecharts where gametime = '#theday#')
</cfquery>

 <cfloop query="Games"> 

	<cfif done is true>
	
		<cfabort>
	</cfif>
	
 

	<cfset myfav = '#Games.Fav#'>
	<cfset myund = '#Games.und#'>
	<cfset aps   = 0>
	<cfset hps   = 0>
	
<!--- 
	<cfset myfav = 'PHI'>
	<cfset myund = 'TOR'>
 --->


 

	<cfif Games.ha is 'H'>

		
		<cfset thehometeam = myfav>
		<cfset theawayteam = myund>
		<cfset urlhometeam = thehometeam>
		<cfset urlawayteam = theawayteam>
		
 
	<cfelse>	
		<cfset thehometeam = myund>
		<cfset theawayteam = myfav>
		<cfset urlhometeam = thehometeam>
		<cfset urlawayteam = theawayteam>

	</cfif>	

	
	<cfquery name="Games" datasource="nba">
	DELETE from NBADriveCharts
	where Gametime = '#theDay#'
	and (team ='#myfav#' or team = '#myund#')
	</cfquery>
		
	<!--- Get the page that has the Play By Play Data --->
	
<cfset myurl = 'http://www.nba.com/games/#theday#/#theawayteam##thehometeam#/gameinfo.html'>


	<cfoutput>
	url = #myurl#<br>
	</cfoutput>




	<cfhttp url="#myurl#" method="GET">
	</cfhttp> 

<cfset mypage = #cfhttp.FileContent#>




<!--- <cfquery datasource="nba">
Insert into debug(Debug_info,insertdate) values ('GetQtrs',#now()#)
</cfquery> --->

<cfset lookfor ='<td colspan="3" class="nbaGIPbPTblHdr"><a name="Q'>
<cfset mystr = myUserCFC.parseString('#mypage#',1,'<td colspan="2" class="nbaGIPbPTmTle">','</td')>
<cfset myarry   = ListToArray(mystr)>
<cfset qtr      = myarry[1]>
<cfset firstqtr = val(myarry[2])>

<cfset mystr = myUserCFC.parseString('#mypage#',#firstqtr#,'<td colspan="2" class="nbaGIPbPTmTle">','</td')>
<cfset myarry   = ListToArray(mystr)>
<cfset qtr      = myarry[1]>
<cfset secondqtr = val(myarry[2])>

<cfset mystr = myUserCFC.parseString('#mypage#',#secondqtr#,'<td colspan="2" class="nbaGIPbPTmTle">','</td')>
<cfset myarry   = ListToArray(mystr)>
<cfset qtr      = myarry[1]>
<cfset thirdqtr = val(myarry[2])>

<cfset mystr = myUserCFC.parseString('#mypage#',#thirdqtr#,'<td colspan="2" class="nbaGIPbPTmTle">','</td')>
<cfset myarry   = ListToArray(mystr)>
<cfset qtr      = myarry[1]>
<cfset fourthqtr = val(myarry[2])>

 											   						
<cfset mypage = replace('#mypage#','<td class="nbaGIPbPLftScore">','<td class="nbaGIPbPLft">','ALL')>
<cfset mypage = replace('#mypage#','<td class="nbaGIPbPMidScore">','<td class="nbaGIPbPMid">','ALL')>
<cfset mypage = replace('#mypage#','<td class="nbaGIPbPRgtScore">','<td class="nbaGIPbPRgt">','ALL')>
<cfset mypage = replace('#mypage#',',',' ','ALL')>
<cfset mypage = replace('#mypage#','-',' ','ALL')>

<!--- 
<cfoutput>#mypage#</cfoutput>
<cfabort>
 --->

<!--- 
<cfquery datasource="nba">
Insert into debug(Debug_info,insertdate) values ('EndGetQtrs',#now()#)
</cfquery>
 --->



<cfset aPosCt      = 0>
<cfset hPosCt      = 0>


<cfset nextstartingpos = 1>


<!--- ********************************Get Home and Away Team******************************************* --->
<!--- ************************************************************************************************* --->
<!--- ************************************************************************************************* --->
<!--- 
<cfquery datasource="nba">
Insert into debug(Debug_info,insertdate) values ('StartGetTeams',#now()#)
</cfquery>
 --->

<cfset mystr = myUserCFC.parseString('#mypage#',#nextstartingpos#,'<td colspan="2" class="nbaGIPbPTmTle">','</td')>

<cfset myarry          = ListToArray(mystr)>
<cfset theval          = myarry[1]>
<cfset nextstartingpos = val(myarry[2])>
<cfset fnd = Findnocase('(','#theval#')>
<cfset theawayteam = mid('#theval#',1,fnd - 1)>

<cfset mystr = myUserCFC.parseString('#mypage#',#nextstartingpos#,'<td class="nbaGIPbPTmTle">','</td')>
<cfset myarry2          = ListToArray(mystr)>
<cfset nextstartingpos = val(myarry2[2])>
<cfset theval          = trim(myarry2[1])>
<cfset fnd = Findnocase('(','#theval#')>
<cfset thehometeam = mid('#theval#',1,fnd - 1)>

<cfoutput>
Before #theawayteam#<br>
Before #thehometeam#<br>
</cfoutput>

<cfset temp1 = replace(thehometeam,'(','',"ALL")>
<cfset temp2 = replace(theawayteam,'(','',"ALL")>


<cfoutput>
temp1 #temp1#<br>
temp2 #temp2#<br>
</cfoutput>


<cfset thehometeam = myPBPCFC.getTeam('#trim(temp1)#')>
<cfset theawayteam = myPBPCFC.getTeam('#trim(temp2)#')>

<cfoutput>
#theawayteam#<br>
#thehometeam#
</cfoutput>





<!--- ********************************End Get Home and Away Team******************************************* --->
<!--- ************************************************************************************************* --->
<!--- ************************************************************************************************* --->
<cfset OffOffReb   = ''>
<cfset OffDefReb   = ''>
<cfset OffTurnover = ''>
<cfset OffOppMade  = ''>
<cfset OffFreethrow = ''>
<cfset OffFoul      = 'Y'>
<cfset loopct = 0>
<cfset mylist = '2PTMADE,2PTMISS,3PTMADE,3PTMISS'>
<cfset nextstartingpos = firstqtr>
<cfset LastQtr = 0>
<cfset awayhaslead = 0>
	<cfset homehaslead = 0>
<cfset PrevLead = ''>
<cfloop condition="not done">
	
	<cfset loopct = loopct + 1>
	<!--- <cfquery datasource="nba">
	Insert into debug(Debug_info,insertdate) values ('Loopct is #loopct#',#now()#)
	</cfquery> --->

	<cfset hupbig   = 0>
	<cfset adownbig = 0>
	<cfset aupbig   = 0>
	<cfset hdownbig = 0>
	<cfset LeadChange = 0>
	
	
	<cfif isdefined("playStruc")>
	<cfif Listfind('#mylist#','#playStruc.ShotDesc#') gt 0>
		<cfset OffOffReb   = ''>
		<cfset OffDefReb   = ''>
		<cfset OffTurnover = ''>
		<cfset OffOppMade  = ''>
		<cfset OffFreethrow = ''>
		<cfset OffFoul      = ''>

	</cfif>
	</cfif>
<!--- ********************************Get the AwayPlay, The time of play, and Home Play**************** --->
<!--- ************************************************************************************************* --->
<!--- ************************************************************************************************* --->


<!--- 
<cfquery datasource="nba">
Insert into debug(Debug_info,insertdate) values ('StartGetPlay',#now()#)
</cfquery>
 --->
	
<cfset mystr = myUserCFC.parseString('#mypage#',#nextstartingpos#,'<td class="nbaGIPbPLft">','</td')>

<cfset myarry2          = ListToArray(mystr)>
<cfset nextstartingpos  = val(myarry2[2])>
<cfset awayInfo         = myarry2[1]>
<!--- 

<cfoutput>
Checking nextstartingpos for nbaGIPbPLft is #nextstartingpos#...is it 0?<br>
</cfoutput>
 --->

<cfif nextstartingpos is 0>	
	<cfset done = true>
	<cfabort>
</cfif>

<cfset mystr = myUserCFC.parseString('#mypage#',#nextstartingpos#,'<td class="nbaGIPbPMid">','</td')>
<cfset myarry2          = ListToArray(mystr)>
<cfset nextstartingpos  = val(myarry2[2])>
<cfset timeInfo         = myarry2[1]>

<!--- 
<cfoutput>
Checking nextstartingpos for nbaGIPbPMid is #nextstartingpos#...is it 0?<br>
</cfoutput>
 --->

<cfif nextstartingpos is 0>	
	<cfset done = true>
	<cfabort>
</cfif>



<cfset mystr = myUserCFC.parseString('#mypage#',#nextstartingpos#,'<td class="nbaGIPbPRgt">','</td')>
<cfset myarry2          = ListToArray(mystr)>
<!--- <cfdump var="#myarry2#"> --->
<cfset nextstartingpos  = val(myarry2[2])>
<cfset homeInfo         = myarry2[1]>


<!--- 
<cfoutput>
Checking nextstartingpos for nbaGIPbPRgt is #nextstartingpos#...is it 0?<br>
</cfoutput>
 --->



<cfif nextstartingpos is 0>	
	<cfset done = true>
	<cfabort>
</cfif>

<!--- 
<cfoutput>
********Checking nextstartingpos #nextstartingpos#...vs #fourthqtr# and awayinfo is #awayinfo#<br>
</cfoutput>
 --->

<cfset qtr = 1>
<cfif nextstartingpos gte fourthqtr>
	<cfset qtr = 4>
<cfelseif nextstartingpos gte thirdqtr>
	<cfset qtr = 3>
<cfelseif nextstartingpos gte secondqtr>
	<cfset qtr = 2>
<cfelse>	
	<cfset qtr = 1>
</cfif>	


<cfif qtr lt LastQtr>
	<cfabort>
<cfelse>
	<cfset LastQtr = qtr>
</cfif>

<!--- See which team has Possession --->
<cfif Len(awayinfo) gt len(homeinfo)>
	<cfset PlayFor = '#theawayteam#'>
	<cfset playStruc = myPBPCFC.checkPlay('#awayinfo#')>
<cfelse>
	<cfset PlayFor = '#thehometeam#'>
	<cfset playStruc = myPBPCFC.checkPlay('#homeinfo#')>
</cfif>


<!---
<cfoutput> 
============> #awayinfo#<br>
============> #homeinfo#<br>
============> The Shot Desc was #playStruc.ShotDesc#<br> 
</cfoutput>
--->
<!--- 
<cfquery datasource="nba">
Insert into debug(Debug_info,insertdate) values ('EndGetPlay - Play was #playStruc.ShotDesc#',#now()#)
</cfquery>
 --->


<!--- See what type of play it was... --->
<cfswitch expression="#playStruc.ShotDesc#">
	
	<cfcase value="REBOUND">
		
		<cfif playfor is priorPlayFor>
			<cfset OFFOffREB = 'Y'>
			<cfset OffDEFREB = ''>
			<cfset OffTurnover = ''>
			<cfset OffFreethrow = ''>
			<cfset OffFoul      = ''>

			<!--- Ofensive Reb<br> --->
		<cfelse>
		<!--- Defensive Reb<br> --->
			<cfset OffDEFREB = 'Y'>
			<cfset OffOffREB = ''>
			<cfset OffTurnover = ''>
			<cfset OffFreethrow = ''>
			<cfset OffFoul      = ''>

		</cfif>
	</cfcase>

	<cfcase value="TURNOVER">
		<cfset OffTurnover = 'Y'>
		<cfset OffDEFREB   = ''>
		<cfset OffOffREB   = ''>
		<cfset OffFreethrow = ''>
		<cfset OffFoul      = ''>
	</cfcase>

	<cfcase value="2PTMADE">
		<cfset OffOppMade = 'Y'>
		<cfset OffTurnover = ''>
		<cfset OffDEFREB   = ''>
		<cfset OffOffREB   = ''>
		<cfset OffFreethrow = ''>
		<cfset OffFoul      = ''>
	</cfcase>

	<cfcase value="2PTMISS">
		
	</cfcase>

	<cfcase value="3PTMADE">
		<cfset OffOppMade = 'Y'>
		<cfset OffTurnover = ''>
		<cfset OffDEFREB   = ''>
		<cfset OffOffREB   = ''>
		<cfset OffFreethrow = ''>
		<cfset OffFoul      = ''>

	</cfcase>

	<cfcase value="3PTMISS">
	</cfcase>

	<cfcase value="TIMEOUT">
	</cfcase>

	<cfcase value="FREETHROW">
		<cfset OffFreethrow = 'Y'>
		<cfset OffOppMade = ''>
		<cfset OffTurnover = ''>
		<cfset OffDEFREB   = ''>
		<cfset OffOffREB   = ''>
		<cfset OffFoul      = ''>

	</cfcase>

	<cfcase value="FOULSHOOTING">
	</cfcase>

	<cfcase value="FOULPERSONAL">
		<cfset OffFreethrow = ''>
		<cfset OffOppMade   = ''>
		<cfset OffTurnover  = ''>
		<cfset OffDEFREB    = ''>
		<cfset OffOffREB    = ''>
		<cfset OffFoul      = 'Y'>
	</cfcase>

	<cfcase value="FOULOFFENSIVE">
		<cfset OffFreethrow = ''>
		<cfset OffOppMade   = ''>
		<cfset OffTurnover  = ''>
		<cfset OffDEFREB    = ''>
		<cfset OffOffREB    = ''>
		<cfset OffFoul      = 'Y'>
	</cfcase>

	<cfcase value="TECHNICAL">
		<cfset OffFreethrow = ''>
		<cfset OffOppMade   = ''>
		<cfset OffTurnover  = ''>
		<cfset OffDEFREB    = ''>
		<cfset OffOffREB    = ''>
		<cfset OffFoul      = ''>
	</cfcase>

	<cfcase value="DOUBLETECH">
		<cfset OffFreethrow = ''>
		<cfset OffOppMade   = ''>
		<cfset OffTurnover  = ''>
		<cfset OffDEFREB    = ''>
		<cfset OffOffREB    = ''>
		<cfset OffFoul      = ''>
	</cfcase>

</cfswitch>

<!--- 
<cfquery datasource="nba">
Insert into debug(Debug_info,insertdate) values ('End Case',#now()#)
</cfquery>
 --->


<cfset playstruc.OffOppMade     = '#OffOppMade#'>
<cfset playstruc.OffTurnover    = '#OffTurnover#'>
<cfset playstruc.OffOffReb      = '#OffOffReb#'>
<cfset playstruc.OffDefReb      = '#OffDefReb#'>
<cfset playstruc.OffFreethrow   = '#OffFreeThrow#'>
<cfset playstruc.OffFoul        = '#OffFoul#'>
<cfset playstruc.Qtr            = #qtr#>

<cfset insideShot=''>
<cfif playStruc.Shottype is 'INSIDE'>
	<cfset insideShot='Y'>
</cfif>

<cfset outsideShot=''>
<cfif playStruc.Shottype is 'OUTSIDE'>
	<cfset outsideShot='Y'>
</cfif>

<!--- 
<cfquery datasource="nba">
Insert into debug(Debug_info,insertdate) values ('End Set Struct vals',#now()#)
</cfquery>
 --->

<!--- 
'#mid(timeinfo,1,5)#',
 --->


<cfif playfor is '#theawayteam#'>


<cfswitch expression="#playStruc.ShotDesc#">
	<cfcase value = '3PTMADE'> 
		<cfset aps = aps + 3>
	</cfcase>
	
	<cfcase value = '2PTMADE'> 
		<cfset aps = aps + 2>
	</cfcase>
	
	<cfcase value = 'FREETHROWMADE'> 
		<cfset aps = aps + 1>
	</cfcase>
</cfswitch>	

<cfif (Hps - aps) gte 10 >
	<cfset hupbig   = 1>
	<cfset adownbig = 1>
</cfif>

<cfif (aps - hps) gte 10 >
	<cfset aupbig = 1>
	<cfset hdownbig = 1>
	
</cfif>

<cfset InLead = 'TIE'>
<cfif aps gt hps>
	<cfoutput>
	away in lead #aps# vs #hps#<br>
	</cfoutput>
	<cfset InLead = '#theawayteam#' >
</cfif>

<cfif hps gt aps>
	<cfoutput>
	home in the lead<br>
	</cfoutput>
	<cfset InLead = '#thehometeam#' >
</cfif>

<cfif Inlead neq 'TIE'>
	<cfoutput>
	prevlead was #prevlead#<br>
	</cfoutput>
	<cfif InLead neq PrevLead>
		<cfset LeadChange = 1>
		LEAD CHANGE....<br>
	</cfif>

</cfif>

<cfset PrevLead = InLead>

prevlead now <cfoutput>#prevlead#</cfoutput>
<p>

<cfif inlead is '#theawayteam#'>
	<cfset awayhaslead = 1>
	<cfset homehaslead = 0>
</cfif>


<cfif inlead is '#thehometeam#'>
	<cfset awayhaslead = 0>
	<cfset homehaslead = 1>
</cfif>


<cfquery datasource="nba">
Insert into NBADriveCharts
(Gametime,
HasLead,
Score,
UpBig,
DownBig,
Team,
Opp,
PlayType,
Result,
EasyShot,
PlayFor,
OffDef,
TimeOfPlay,
OffOffReb,
OffDefReb,
OffTurnover,
OffFreeThrow,
OffOppMade,
OffFoul,
InsideShot,
OutsideShot,
Qtr,
LeadChange
)
values
(
'#theday#',
#awayhaslead#,
#aps#,
#aupbig#,
#adownbig#,
'#theawayteam#',
'#thehometeam#',
'#playStruc.ShotType#',
'#playStruc.ShotDesc#',
'',
'#playfor#',
'O',
'#mid(timeinfo,1,5)#',
'#playStruc.OffOffReb#',
'#playStruc.OffDefReb#',
'#playStruc.OffTurnover#',
'#playStruc.OffFreeThrow#',
'#playStruc.OffOppMade#',
'#playStruc.OffFoul#',
'#insideShot#',
'#outsideShot#',
#qtr#,
#LeadChange#
)

</cfquery>
 
<cfquery datasource="nba">
Insert into NBADriveCharts
(Gametime,
Score,
UpBig,
DownBig,
Team,
Opp,
PlayType,
Result,
EasyShot,
PlayFor,
OffDef,
TimeOfPlay,
OffOffReb,
OffDefReb,
OffTurnover,
OffFreeThrow,
OffOppMade,
OffFoul,
InsideShot,
OutsideShot,
Qtr,
LeadChange
)
values
(
'#theday#',
#hps#,
#hupbig#,
#hdownbig#,
'#thehometeam#',
'#theawayteam#',
'#playStruc.ShotType#',
'#playStruc.ShotDesc#',
'',
'#playfor#',
'D',
'#mid(timeinfo,1,5)#',
'#playStruc.OffOffReb#',
'#playStruc.OffDefReb#',
'#playStruc.OffTurnover#',
'#playStruc.OffFreeThrow#',
'#playStruc.OffOppMade#',
'#playStruc.OffFoul#',
'#insideShot#',
'#outsideShot#',
#qtr#,
#LeadChange#
)

</cfquery>

<cfelse>

<cfswitch expression="#playStruc.ShotDesc#">
	<cfcase value = '3PTMADE'> 
		<cfset hps = hps + 3>
	</cfcase>
	
	<cfcase value = '2PTMADE'> 
		<cfset hps = hps + 2>
	</cfcase>
	
	<cfcase value = 'FREETHROWMADE'> 
		<cfset hps = hps + 1>
	</cfcase>
</cfswitch>	


<cfif (Hps - aps) gte 10 >
	<cfset hupbig   = 1>
	<cfset adownbig = 1>
</cfif>

<cfif (aps - hps) gte 10 >
	<cfset aupbig = 1>
	<cfset hdownbig = 1>
</cfif>

<cfset InLead = 'TIE'>
<cfif aps gt hps>
	<cfoutput>
	away in lead #aps# vs #hps#<br>
	</cfoutput>
	<cfset InLead = '#theawayteam#' >
</cfif>

<cfif hps gt aps>
	<cfoutput>
	home in the lead #hps# vs #aps#<br>
	</cfoutput>
	<cfset InLead = '#thehometeam#' >
</cfif>

<cfif Inlead neq 'TIE'>
	<cfoutput>
	prevlead was #prevlead#<br>
	</cfoutput>
	<cfif InLead neq PrevLead>
		LEAD CHANGE....<br>
		<cfset LeadChange = 1>
	</cfif>

</cfif>

<cfset PrevLead = InLead>

prevlead now <cfoutput>#prevlead#</cfoutput>
<p>


<cfif inlead is '#theawayteam#'>
	<cfset awayhaslead = 1>
	<cfset homehaslead = 0>
</cfif>


<cfif inlead is '#thehometeam#'>
	<cfset awayhaslead = 0>
	<cfset homehaslead = 1>
</cfif>


<cfquery datasource="nba">
Insert into NBADriveCharts
(Gametime,
HasLead,
Team,
Score,
UpBig,
DownBig,
Opp,
PlayType,
Result,
EasyShot,
PlayFor,
OffDef,
TimeOfPlay,
OffOffReb,
OffDefReb,
OffTurnover,
OffFreeThrow,
OffOppMade,
OffFoul,
InsideShot,
OutsideShot,
Qtr,
LeadChange
)
values
(
'#theday#',
#homehaslead#,
'#thehometeam#',
#hps#,
#hupbig#,
#hdownbig#,
'#theawayteam#',
'#playStruc.ShotType#',
'#playStruc.ShotDesc#',
'',
'#playfor#',
'O',
'#mid(timeinfo,1,5)#',
'#playStruc.OffOffReb#',
'#playStruc.OffDefReb#',
'#playStruc.OffTurnover#',
'#playStruc.OffFreeThrow#',
'#playStruc.OffOppMade#',
'#playStruc.OffFoul#',
'#insideShot#',
'#outsideShot#',
#qtr#,
#LeadChange#
)

</cfquery>
 
<cfquery datasource="nba">
Insert into NBADriveCharts
(Gametime,
Team,
Score,
UpBig,
DownBig,
Opp,
PlayType,
Result,
EasyShot,
PlayFor,
OffDef,
TimeOfPlay,
OffOffReb,
OffDefReb,
OffTurnover,
OffFreeThrow,
OffOppMade,
OffFoul,
InsideShot,
OutsideShot,
Qtr,
LeadChange
)
values
(
'#theday#',
'#theawayteam#',
#aps#,
#aupbig#,
#adownbig#,
'#thehometeam#',
'#playStruc.ShotType#',
'#playStruc.ShotDesc#',
'',
'#playfor#',
'D',
'#mid(timeinfo,1,5)#',
'#playStruc.OffOffReb#',
'#playStruc.OffDefReb#',
'#playStruc.OffTurnover#',
'#playStruc.OffFreeThrow#',
'#playStruc.OffOppMade#',
'#playStruc.OffFoul#',
'#insideShot#',
'#outsideShot#',
#qtr#,
#LeadChange#
)

</cfquery>

</cfif>
 
<!--- 
<cfquery datasource="nba">
Insert into debug(Debug_info,insertdate) values ('3',#now()#)
</cfquery>
 --->


<!--- <cfoutput>
#awayinfo#<br>
time is #timeinfo#<br>
#homeinfo#<br>
Play For: #playfor#<br>
<cfdump var="#playStruc#">
</cfoutput> --->

<cfset priorPlayFor = playfor>


</cfloop>	
---------------------------------------------------------------<br>
<cfquery datasource="nba" name="GetLeadChanges">
Select Sum(LeadChange) as lc
from NBADrivecharts
Where Team in('#theawayteam#','#thehometeam#')
and OffDef='O'
and gametime = '#theday#'
and result in ('2PTMADE','3PTMADE','2PTMISS','3PTMISS','FREETHROWMADE','FREETHROWMISSED')
</cfquery>

<!--- See what percent of the time Home team was in the lead --->
<cfquery datasource="nba" name="HGetTotPlays">
Select count(*) as totplays
from NBADrivecharts dch 
Where dch.Team = '#thehometeam#'
and dch.OffDef = 'O'
and dch.gametime = '#theday#'
and dch.result in ('2PTMADE','3PTMADE','2PTMISS','3PTMISS')
</cfquery>

<cfquery datasource="nba" name="AGetTotPlays">
Select count(*) as totplays
from NBADrivecharts dca 
Where dca.Team = '#theawayteam#'
and dca.OffDef = 'O'
and dca.gametime = '#theday#'
and dca.result in ('2PTMADE','3PTMADE','2PTMISS','3PTMISS')
</cfquery>

<cfset totplays = HGettotplays.totplays + aGettotplays.totplays>

<cfquery datasource="nba" name="aGetLeadPcts">
Select Sum(dca.Haslead)/#totplays# as hasleadpct
from NBADrivecharts dca 
Where dca.Team = '#theawayteam#'
and dca.OffDef = 'O'
and dca.gametime = '#theday#'
and dca.result in ('2PTMADE','3PTMADE','2PTMISS','3PTMISS')
</cfquery>

<cfquery datasource="nba" name="hGetLeadPcts">
Select Sum(dch.Haslead)/#totplays# as hasleadpct
from NBADrivecharts dch 
Where dch.Team = '#thehometeam#'
and dch.OffDef = 'O'
and dch.gametime = '#theday#'
and dch.result in ('2PTMADE','3PTMADE','2PTMISS','3PTMISS')
</cfquery>


<!--- See how may times HUGE leads a  --->
<cfquery datasource="nba" name="aUpBigPct">
Select Sum(dca.UpBig)/#totplays# as hasBIGleadpct
from NBADrivecharts dca 
Where dca.Team = '#theawayteam#'
and dca.OffDef = 'O'
and dca.gametime = '#theday#'
and dca.result in ('2PTMADE','3PTMADE','2PTMISS','3PTMISS')
</cfquery>

<cfquery datasource="nba" name="hUpBigPct">
Select Sum(dch.UpBig)/#totplays# as hasBIGleadpct
from NBADrivecharts dch 
Where dch.Team = '#thehometeam#'
and dch.OffDef = 'O'
and dch.gametime = '#theday#'
and dch.result in ('2PTMADE','3PTMADE','2PTMISS','3PTMISS')
</cfquery>


<!--- See how may times HUGE leads a  --->
<cfquery datasource="nba" name="aDownBigPct">
Select Sum(dca.DownBig)/#totplays# as downbig
from NBADrivecharts dca 
Where dca.Team = '#theawayteam#'
and dca.OffDef = 'O'
and dca.gametime = '#theday#'
and dca.result in ('2PTMADE','3PTMADE','2PTMISS','3PTMISS')
</cfquery>

<cfquery datasource="nba" name="hdownBigPct">
Select Sum(dch.DownBig)/#totplays# as downbig
from NBADrivecharts dch 
Where dch.Team = '#thehometeam#'
and dch.OffDef = 'O'
and dch.gametime = '#theday#'
and dch.result in ('2PTMADE','3PTMADE','2PTMISS','3PTMISS')
</cfquery>




<br>
<cfoutput>

Total Plays: #HGettotplays.totplays + aGettotplays.totplays#<br>
<hr>
#thehometeam# was in the lead #hGetLeadPcts.hasleadpct#<br>
#theawayteam# was in the lead #aGetLeadPcts.hasleadpct#<br>
<hr>
#thehometeam# was UP BIG #hUpBigPct.hasBIGleadpct#<br>
#theawayteam# was UP BIG #aUpBigPct.hasBIGleadpct#<br>
<hr>
#thehometeam# was DOWN BIG #hDownBigPct.downbig#<br>
#theawayteam# was DOWN BIG #aDownBigPct.downbig#<br>

<hr>
Total Lead Changes: #GetLeadChanges.lc#<br>
</cfoutput>

<p>
<p>
<p>

<cfquery datasource="nba" name="upd2">
Update TeamSituation
Set LastLeadChanges = #GetLeadChanges.lc#,
InLeadPct = #100*hGetLeadPcts.hasleadpct#,
UpBigPct  = #100*hUpBigPct.hasBIGleadpct#,
DownBigPct = #100*hDownBigPct.downbig#,
LastTotalPlays = #HGettotplays.totplays#
Where Team = '#thehometeam#'
and gametime = '#theday#'
</cfquery>

<cfquery datasource="nba" name="upd1">
Update TeamSituation
Set LastLeadChanges = #GetLeadChanges.lc#,
InLeadPct = #100*aGetLeadPcts.hasleadpct#,
UpBigPct  = #100*aUpBigPct.hasBIGleadpct#,
DownBigPct = #100*aDownBigPct.downbig#,
LastTotalPlays = #aGettotplays.totplays#
Where Team = '#theawayteam#'
and gametime = '#theday#'
</cfquery>

<cfabort>

</cfloop>



<cfcatch type="any">
  
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.tagcontext[1].line#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error LoadPBPNBAData.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>

</cfcatch>

</cftry>



