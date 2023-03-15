<cfcomponent displayname="Function for PSP User" output="false" >


<cffunction name="LastSevenHealth" output="Yes" access="remote" >

	<cfargument name="GameTime"  type="String" required="no" default=""  />
	<cfargument name="Team"      type="String" required="yes"  />
	<cfargument name="Opp"       type="String" required="yes"  />
	<cfargument name="TeamOrOpp" type="String" required="yes"  />

<cfset yyyy        = left(gametime,4)>
<cfset mm          = mid(gametime,5,2)>
<cfset dd          = right(gametime,2)>

<cfquery datasource="Nba" name="Getit">
	Select Distinct Team
	from NBAData
	where Team in (Select fav from NBAschedule where gametime = '#arguments.gametime#')
		or Team in (Select Und from Nbaschedule where gametime = '#arguments.gametime#')
</cfquery>

<cfset gametime = arguments.gametime>

<cfloop query="Getit">

	<cfoutput>
    Checking this : #Getit.Team#<br>  
	</cfoutput>

	<!--- For each Team  --->
	<cfset done      = false>
	<cfset daysback  = -7>
	
	
	<cfset mydate      = #Dateformat(DateAdd("d",0,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
	<CFSET DAYcheck    = #Dateformat(DateAdd("d",#daysback#,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
	<CFSET DAYcheckSTR = ToString(DAYCheck)>
	
	<!-- Get total games played in the last 7 days -->
	<cfquery datasource="Nba" name="GamesPlayed">
		Select *
		from NBASchedule
		where (GameTime >= '#DAYcheckSTR#' and GameTime < '#gametime#'
		and (Fav = '#Getit.Team#' or Und = '#GetIt.Team#') 
		)
		order by gametime desc
	</cfquery>
	
	
	<cfset GamesPlayedInWeek = GamesPlayed.RecordCount>
	
	<cfoutput>
	The games played in week were: #GamesPlayedInWeek#<br>
	</cfoutput>
	
	<cfset Hlth = -1*GamesPlayedInWeek>
	
	<!-- See how many times they played conseq nights -->
	<cfset GametimePrevVal = ''>
	<cfset ConseqCt = 0>
	<cfloop query="GamesPlayed">
		<cfif GameTimePrevVal neq ''>
		
			<cfoutput>
			Comparing #Gametime[currentrow]# with #GameTimePrevVal# <br>
			</cfoutput>	
				
			<cfif Datediff("d",Gametime[currentrow],GameTimePrevVal) is 1>
				<cfset ConseqCt = ConseqCt + 1>
			</cfif>
		
		</cfif>
		<cfset GameTimePrevVal = Gametime[currentrow]>
	</cfloop>
	
			<cfoutput>
			Conseq night count: #ConseqCt# <br>
			</cfoutput>	
	
	
	
	<cfset Hlth = Hlth + (-1*ConseqCt)>
		
	<!-- See how many games played AWAY -->
	<cfquery datasource="Nba" name="GamesAwayPlayed">
		Select *
		from NBASchedule
		where (GameTime >= '#DAYcheckSTR#' and GameTime < '#gametime#'
		and(  ( Fav = '#Getit.Team#' and Ha = 'A') or ( Und = '#GetIt.Team#' and ha = 'H')) 
		)
		order by gametime desc
	</cfquery>

	<cfset AwayGamesPlayedInWeek = GamesAwayPlayed.RecordCount>

			<cfoutput>
			Away Games Played: #AwayGamesPlayedInWeek# <br>
			</cfoutput>	
	

	<cfif AwayGamesPlayedInWeek gt 1 >
	<cfset Hlth = Hlth + (-1*AwayGamesPlayedInWeek)>

	<!-- See how many times they played conseq Away nights -->
	<cfset AwayCt = 0>
	<cfset TwoConseqAwayCt = 0>
	<cfset ThreeConseqAwayCt = 0>
	<cfset FourConseqAwayCt = 0>
	
	<cfloop query="GamesPlayed">
		
		<cfif (HA is 'H' and Fav is '#GetIt.Team#') or (HA is 'A' and Und is '#GetIt.Team#')>
			<cfset AwayCt = AwayCt + 1>
			
			<cfif AwayCt is 2>
				<cfset TwoConseqAwayCt = 1>
			</cfif>
			
			<cfif AwayCt is 3>
				<cfset ThreeConseqAwayCt = 1>
			</cfif>
			
			<cfif AwayCt is 4>
				<cfset FourConseqAwayCt = 1>
			</cfif>
			
		<cfelse>
			<cfif AwayCt neq 0>
				<cfset AwayCt = AwayCt - 1>
			</cfif>
		</cfif>

	</cfloop>

	<cfif AwayCt is 4>
		Played 4 conseq Away games<br>
		<cfset Hlth = Hlth - 4>
	<cfelseif AwayCt is 3>
		Played 3 conseq Away games<br>
		<cfset Hlth = Hlth - 3>
	<cfelseif AwayCt is 2>
		Played 2 conseq Away games<br>
		<cfset Hlth = Hlth - 2>
	</cfif>

	</cfif>


	<CFSET DAYcheck    = #Dateformat(DateAdd("d",-1,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>	
	<CFSET DAYcheckSTR = ToString(DAYCheck)>	

	<!-- See if team played yesterday -->
	<cfquery datasource="Nba" name="PlayedYest">
		Select *
		from NBASchedule
		where( GameTime = '#DAYcheckSTR#'
		and( (Fav = '#Getit.Team#' or Und = '#GetIt.Team#'))
		) 
	</cfquery>

	<cfset TeamPlayedAwayYest = false>
	<cfoutput query="PlayedYest">	
		
		Team played Yesterday!<br>
		<cfset Hlth = Hlth - 1>
		<!-- See if team played Away or Home yesterday -->
		<cfif (HA is 'A' and Fav is '#GetIt.Team#') or (HA is 'H' and Und is '#GetIt.Team#')> 
			<cfset TeamPlayedAwayYest = true>
			<cfset Hlth = Hlth - 1>
			Team played Yesterday and was AWAY!<br>
		</cfif>
	</cfoutput>
	
	<cfset TeamIsAwayToday = false>
	<!-- See if team is AWAY today -->
	<cfquery datasource="Nba" name="TodaysGameAway">
		Select *
		from NBASchedule
		where( GameTime = '#Gametime#'
		and( (Fav = '#Getit.Team#' and ha = 'A') or  (Und = '#GetIt.Team#' and ha = 'H'))
		)  
	</cfquery>
	
	<cfif TodaysGameAway.recordcount gt 0 and TeamPlayedAwayYest is true>
		<cfset TeamIsAwayToday = true>
		<cfset Hlth = Hlth - 1>
		Team is AWAY today!<br>
	</cfif>
	<cfoutput>
	The health for #Getit.team# is #hlth#<p>
	</cfoutput>
	
	<cfif arguments.TeamOrOpp is 'TEAM'>
	
		<cfquery datasource="Nba" name="GetDefEff">
					UPDATE Pace
					Set HealthTeam  = #hlth#
					Where Team = '#arguments.Team#'
					and gametime = '#arguments.Gametime#'
		</cfquery>
	
	<cfelse>
	
				<cfquery datasource="Nba" name="GetDefEff">
					UPDATE Pace
					Set HealthOpp  = #hlth#
					Where Team = '#arguments.Team#'
					and gametime = '#arguments.Gametime#'
				</cfquery>
	
	</cfif>
	
	
	<cfset Hlth = 0>
	
	
	<cfif TeamPlayedAwayYest is true >
		<cfif TeamIsAwayToday is true >
			**********************************************************************<br>
			POTENTIAL PLAY AGAINST.....<cfoutput>#Getit.team#.....Health is #hlth#</cfoutput><br>
			**********************************************************************<br>
		</cfif>
	</cfif>
	
	
</cfloop>	

</cffunction>

<cffunction name="createPaceAndEfficiency" output="Yes" access="remote" returntype="Numeric">

	<cfargument name="GameTime" type="String" required="no" default=""  />
	<cfargument name="Team"     type="String" required="yes"  />
	<cfargument name="Opp"      type="String" required="yes"  />
	<cfargument name="HA"       type="String" required="no"  />

	<cfquery name="AddPace" datasource="nba">
	DELETE from PACE	
	WHERE GAMETIME='#arguments.gametime#'
	AND (Team='#arguments.Team#' or Team='#arguments.Opp#')
	</cfquery>

	<cfquery name="GetTeamStats" datasource="nba">
	Select ps, ofgm, ofta, oTurnovers, oReb, (OFGA + ofta) AS pace
	from NBAData
	where TEAM   = '#arguments.Team#'
	<cfif arguments.gametime gt ''>
	and Gametime = '#arguments.gametime#'
	</cfif>
	</cfquery>

	<cfquery name="GetOppStats" datasource="nba">
	Select ps, ofgm, ofta, oTurnovers, oReb, (OFGA + ofta) AS pace
	from NBAData
	where TEAM   = '#arguments.opp#'
	<cfif arguments.gametime gt ''>
	and Gametime = '#arguments.gametime#'
	</cfif>
	</cfquery>


	<cfset TeamPossessions = #GetOppStats.oFGM# + ((#GetOppStats.oFTA#/2)*.94) + #GetOppStats.oTurnovers# + #GetTeamStats.oReb#> 
	<cfset OppPossessions  = GetTeamStats.oFGM + ((GetTeamStats.oFTA/2)*.94) + GetTeamStats.oTurnovers + GetOppStats.oReb> 
	<cfset GamePace = GetTeamStats.Pace + GetOppStats.Pace>


	<cfset TeamEff = GetTeamStats.PS / TeamPossessions>
	<cfset OppEff = GetOppstats.PS  / OppPossessions>

	


	<cfquery name="AddPace" datasource="nba">
	INSERT INTO PACE	
	(GAMETIME, TEAM, HA, OPP, OFFEFF, DEFEFF, PACE, TEAMPOSSESSIONS)
	VALUES('#arguments.gametime#','#arguments.Team#','#arguments.HA#','#arguments.Opp#',#TeamEff#,#oppEff#,#gamePace#,#TeamPossessions#)
	</cfquery>

	<cfset TheHa = 'H'>
	<cfif '#arguments.HA#' is 'H'>
		<cfset TheHa = 'A'>
	</cfif>

	<cfquery name="AddPace" datasource="nba">
	INSERT INTO PACE	
	(GAMETIME, TEAM, HA, OPP, OFFEFF, DEFEFF, PACE, OPPPOSSESSIONS)
	VALUES('#arguments.gametime#','#arguments.opp#','#theha#','#arguments.Team#',#OppEff#,#TeamEff#,#gamePace#,#OppPossessions#)
	</cfquery>
 <!--- 

	<cfset dum = LastSevenHealth('#arguments.Gametime#','#arguments.Team#','#arguments.opp#','TEAM')>
	<cfset dum = LastSevenHealth('#arguments.Gametime#','#arguments.Opp#','#arguments.Team#','OPP')>
 --->

	<cfreturn 0>


</cffunction>




<cffunction name="getOpportunity" output="Yes" access="remote" returntype="Numeric">
	<cfargument name="GameTime" type="String" required="no" default=""  />
	<cfargument name="Team"     type="String" required="yes"  />
	<cfargument name="OffDef"   type="String" required="yes"  />


	<cfquery name="GetInfo" datasource="nba">
	Select *
	from NBADriveCharts
	where OffDef = '#arguments.OffDef#'
	and team     = '#arguments.Team#'
	and (Result in ('2PTMISS','2PTMADE','3PTMISS','3PTMADE','FREETHROWMADE','FREETHROWMISS')
	
		or (Result in ('REBOUND') AND OffOffReb='Y') 	

	    )	

	<!--- and OffOffReb <> 'Y' --->
	<cfif arguments.gametime gt ''>
	and Gametime = '#arguments.gametime#'
	</cfif>
	
	</cfquery>

	<cfreturn #GetInfo.Recordcount#>

</cffunction>


<cffunction name="createPBPPercents" output="Yes" access="remote" returntype="void">
	<cfargument name="GameTime" type="String" required="no" default=""  />
	<cfargument name="Team" type="String" required="yes"  />


<cfif arguments.Gametime gt ''>
	<cfquery datasource="nba" name="Addit">
	Delete from PBPPercents
	where Gametime = '#arguments.Gametime#'
	and Team = '#arguments.Team#'
	</cfquery>
</cfif>


<cfset myPBPCFC = createObject("component", "NBAPBP") />


<cfquery name="GetTeams" datasource="nba">
	Select *
	from NBASchedule
	where Gametime = '#gametime#'
	and (Fav = '#arguments.team#' or Und = '#arguments.team#')
</cfquery>




<cfloop query="GetTeams">
	<cfset FavOpp    = myPBPCFC.getOpportunity('#arguments.Gametime#','#arguments.Team#','O')>
	<cfset FavDCOff  = myPBPCFC.getDriveInfo('O','#arguments.Team#','#arguments.Gametime#')>

	<cfquery datasource="nba" name="Addit">
	Insert into PBPPercents(Team,OffDef,turnoverPct,ftaPct,InsidePct,OutsidePct,
	MadeInsidePct,MadeNormalPct,MadeOutsidePct,Gametime,Opportunity)
	values('#arguments.Team#','O',#FavDCOff.turnoverPct#,#FavDCOff.ftaPct#
	,#FavDCOff.InsidePct#,#FavDCOff.OutsidePct#,#FavDCOff.MakeInsidePct#,#FavDCOff.MakeNormalPct#,#FavDCOff.MakeOutsidePct#,'#arguments.Gametime#',#FavOpp#
	)
	</cfquery>

	<cfset FavOpp    = myPBPCFC.getOpportunity('#arguments.Gametime#','#arguments.Team#','D')>
	<cfset UndDCOff  = myPBPCFC.getDriveInfo('D','#arguments.Team#','#arguments.Gametime#')>

	<cfquery datasource="nba" name="Addit">
	Insert into PBPPercents(Team,OffDef,turnoverPct,ftaPct,InsidePct,OutsidePct,
	MadeInsidePct,MadeNormalPct,MadeOutsidePct,Gametime,Opportunity)
	values('#arguments.Team#','D',#undDCOff.turnoverPct#,#undDCOff.ftaPct#
	,#undDCOff.InsidePct#,#undDCOff.OutsidePct#,#undDCOff.MakeInsidePct#,#undDCOff.MakeNormalPct#,#undDCOff.MakeOutsidePct#,'#arguments.gametime#',#favOpp#
	)
	</cfquery>

</cfloop>
</cffunction>


<cffunction name="getRandomNum" output="Yes" access="remote" returntype="Numeric">
    <cfargument name="lo"        type="Numeric" required="yes"  />
	<cfargument name="hi"        type="Numeric" required="yes"  />

	<cfscript>
	 	Application.objRandom = CreateObject("Component", "Random");
 		Application.objRandom.setBounds(#lo#,#hi#);
	</cfscript>

	<!--- Create a random number from lo to hi--->
	<cfset rn = Application.objRandom.next() >
	
	<cfreturn #rn#>
	
</cffunction>



<cffunction name="getRebInfo" access="remote" returntype="struct"> 
	<cfargument name="OffDef" type="String" required="yes"  />
	<cfargument name="Team"   type="String" required="yes"  />

	<cfquery name="GetInfo" datasource="nba">
	Select *
	from NBADriveCharts
	where OffDef = '#arguments.OffDef#'
	and team     = '#arguments.Team#'
	and Result in ('2PTMISS','2PTMADE','3PTMISS','3PTMADE','TURNOVER','FREETHROWMADE','FREETHROWMISS','UNKNOWN')
	and OffOffReb = 'Y'
	</cfquery>

<cfset miss2pt = 0>
<cfset made2pt = 0>
<cfset turn    = 0>
<cfset in      = 0>
<cfset out     = 0>
<cfset made3pt = 0>
<cfset miss3pt = 0>
<cfset fta     = 0>
<cfset ftaPct     = 0>

<cfset q1 = 0>
<cfset q2 = 0>
<cfset q3 = 0>
<cfset q4 = 0>
<cfset MadeInside = 0>
<cfset MissInside = 0>
<cfset MadeNormal = 0>
<cfset TotNormalShots = 0>
<cfset InsideShotCt = 0>
<cfset OutsideShotCt = 0>
<cfset MadeOutside = 0>

<cfoutput query="GetInfo">
	<cfset normalshot = 'Y'>
	<cfif InsideShot is 'Y'>
		<cfset InsideShotCt = InsideShotCt + 1>
		<cfset normalshot = 'N'>
	</cfif>

	<cfif OutsideShot is 'Y'>
		<cfset OutsideShotCt = OutsideShotCt + 1>
		<cfset normalshot = 'N'>
	</cfif>

	
	<cfif Result is '2PTMISS'>
		<cfset miss2pt = miss2pt + 1>
		<cfset TotNormalShots = TotNormalShots + 1>

	</cfif>

	<cfif Result is '3PTMISS'>
		<cfset miss3pt = miss3pt + 1>
	</cfif>

	<cfif Result is '2PTMADE'>
		<cfif NormalShot is 'Y'>
			<cfset MadeNormal = MadeNormal + 1>
			<cfset TotNormalShots = TotNormalShots + 1>

		</cfif>
	</cfif>		

	<cfif Result is '3PTMADE'>
		<cfset made3pt = made3pt + 1>
		<cfset MadeOutside = MadeOutside + 1>
	</cfif>

	<cfif Result is 'TURNOVER'>
		<cfset turn = turn + 1>
	</cfif>

	<cfif Result is 'FREETHROWMADE'>
		<cfset fta = fta + 1>
	</cfif>

	<cfif Result is 'FREETHROWMISS'>
		<cfset fta = fta + 1>
	</cfif>

	<cfif PlayType is 'INSIDE'>
		<cfset in = in + 1>
	</cfif>
	
	<cfif PlayType is 'OUTSIDE'>
		<cfset out = out + 1>
	</cfif>

	<cfif Result is '2PTMADE' and InsideShot is 'Y' >
		<cfset MadeInside = MadeInside + 1>
	<cfELSE>
		<cfif Result is '2PTMISS' and InsideShot is 'Y' >
			<cfset MissInside = MissInside + 1>
		</cfif>
	</CFIF>
	
	
	
	<cfif Qtr is 1>
		<cfset q1 = q1 + 1>
	</cfif>
	
	<cfif Qtr is 2>
		<cfset q2 = q2 + 1>
	</cfif>
	
	<cfif Qtr is 3>
		<cfset q3 = q3 + 1>
	</cfif>
	
	<cfif Qtr is 4>
		<cfset q4 = q4 + 1>
	</cfif>
</cfoutput>

<cfset pt2madePct = (made2pt/GetInfo.recordcount)*100>
<cfset pt2missPct = (miss2pt/GetInfo.recordcount)*100>
<cfset pt3madePct = (made3pt/GetInfo.recordcount)*100>
<cfset pt3missPct = (miss3pt/GetInfo.recordcount)*100>
<cfset turnoverPct = (turn/GetInfo.recordcount)*100>
<cfset ftaPct      = (fta/GetInfo.recordcount)*100>
<cfset InsidePct  = (in/GetInfo.recordcount)*100>
<cfset OutsidePct  = (out/GetInfo.recordcount)*100>

<cfset MadeInsidePct = 0>
<cfif InsideShotCt gt 0>
	<cfset MadeInsidePct = (Madeinside/InsideShotCt)*100>
</cfif>

<cfset MadeNormalPct = 0>
<cfif TotNormalShots gt 0 >
	<cfset MadeNormalPct = (MadeNormal/TotNormalShots)*100>
</cfif>

<cfset MadeOutsidePct = 0>
<cfif OutsideShotCt gt 0 >
	<cfset MadeOutsidePct = (MadeOutside/OutsideShotCt)*100>
</cfif>

<cfset strucReb = StructNew()>
<!--- 
<cfset strucReb.pt2madepct = pt2madePct>
<cfset strucReb.pt2misspct = pt2missPct>
<cfset strucReb.pt3madepct = pt3madePct>
<cfset strucReb.pt3misspct = pt3missPct>
 --->
<cfset strucReb.turnoverpct = TurnoverPct>
<cfset strucReb.FTApct      = FTAPct>
<cfset strucReb.Insidepct   = InsidePct>
<cfset strucReb.Outsidepct   = OutsidePct>
<cfset strucReb.Normalepct   = 100 - (InsidePct + OutsidePct)>

<cfset strucReb.MakeInsidePct = MadeInsidePct>
<cfset strucReb.MakeNormalPct = MadeNormalPct>
<cfset strucReb.MakeOutsidePct = MadeOutsidePct>

<cfreturn strucReb>

</cffunction>


<cffunction name="getFTA" access="remote" returntype="Numeric"> 
	<cfargument name="OffDef" type="String" required="yes"  />
	<cfargument name="Team"   type="String" required="yes"  />

	<cfquery name="GetInfo" datasource="nba">
	Select Count(*) / (Select count(*)
	from NBADriveCharts
	where OffDef = '#arguments.OffDef#'
	and team     = '#arguments.Team#'
	and OffOffReb <> 'Y'
	and Result in ('2PTMISS','2PTMADE','3PTMISS','3PTMADE','TURNOVER','FREETHROWMADE','FREETHROWMISS')
	) * 100 as retpct
	from NBADriveCharts
	where OffDef = '#arguments.OffDef#'
	and team     = '#arguments.Team#'
	and Result in ('FREETHROWMADE','FREETHROWMISS')
	and OffOffReb <> 'Y'
	</cfquery>

	<cfreturn Getinfo.retpct>

</cffunction>



<cffunction name="getDriveInfo" access="remote" returntype="struct"> 
	<cfargument name="OffDef"   type="String" required="yes"  />
	<cfargument name="Team"     type="String" required="yes"  />
	<cfargument name="HA"       type="String" required="no" default=""  />
	<cfargument name="GameTime" type="String" required="no" default=""  />
	



	<cfquery name="GetInfo" datasource="nba">
	Select dc.*
	from NBADriveCharts dc, NBASchedule sched
	where dc.OffDef = '#arguments.OffDef#'
	and dc.team     = '#arguments.Team#'
	and (dc.Result in ('2PTMISS','2PTMADE','3PTMISS','3PTMADE','TURNOVER','FREETHROWMADE','FREETHROWMISS')
		or (dc.Result in ('REBOUND') AND OffOffReb='Y') 
	    )	

	and sched.Gametime = dc.Gametime
	and (sched.fav = dc.Team or sched.und = dc.Team)
	<cfif arguments.ha gt ''>
	and sched.HA = '#arguments.ha#'
	</cfif>

	<!--- and OffOffReb <> 'Y' --->
	<cfif arguments.gametime gt ''>
	and Gametime = '#arguments.gametime#'
	</cfif>
	
	</cfquery>

<cfset miss2pt = 0>
<cfset made2pt = 0>
<cfset turn    = 0>
<cfset in      = 0>
<cfset out     = 0>
<cfset made3pt = 0>
<cfset miss3pt = 0>
<cfset fta     = 0>
<cfset ftaPct  = 0>
<cfset q1 = 0>
<cfset q2 = 0>
<cfset q3 = 0>
<cfset q4 = 0>
<cfset MadeInside = 0>
<cfset MissInside = 0>
<cfset MadeNormal = 0>
<cfset TotNormalShots = 0>
<cfset InsideShotCt = 0>
<cfset OutsideShotCt = 0>
<cfset MadeOutside = 0>
<cfset OffRebCt = 0>
<cfset OffRebPct = 0>

<cfoutput query="GetInfo">
	<cfset normalshot = 'Y'>

	<cfif OffOffReb is 'Y'>
		<cfset OffRebCt = OffRebCt + 1>
	</cfif>


	<cfif InsideShot is 'Y'>
		<cfset InsideShotCt = InsideShotCt + 1>
		<cfset normalshot = 'N'>
	</cfif>

	<cfif OutsideShot is 'Y'>
		<cfset OutsideShotCt = OutsideShotCt + 1>
		<cfset normalshot = 'N'>
	</cfif>


	<cfif Result is '2PTMISS'>
		<cfset miss2pt = miss2pt + 1>
		<cfset TotNormalShots = TotNormalShots + 1>

	</cfif>

	<cfif Result is '3PTMISS'>
		<cfset miss3pt = miss3pt + 1>
	</cfif>


	<cfif Result is '2PTMADE'>
		<cfset made2pt = made2pt + 1>
		<cfset TotNormalShots = TotNormalShots + 1>
		<cfset MadeNormal = MadeNormal + 1>
	</cfif>

	<cfif Result is '3PTMADE'>
		<cfset made3pt = made3pt + 1>
		<cfset MadeOutside = MadeOutside + 1>
	</cfif>

	<cfif Result is 'TURNOVER'>
		<cfset turn = turn + 1>
	</cfif>

	<cfif Result is 'FREETHROWMADE'>
		<cfset fta = fta + 1>
	</cfif>

	<cfif Result is 'FREETHROWMISS'>
		<cfset fta = fta + 1>
	</cfif>

	<cfif PlayType is 'INSIDE'>
		<cfset in = in + 1>
	</cfif>
	
	<cfif PlayType is 'OUTSIDE'>
		<cfset out = out + 1>
	</cfif>

	<cfif Result is '2PTMADE' and InsideShot is 'Y' >
		<cfset MadeInside = MadeInside + 1>
	<cfELSE>
		<cfif Result is '2PTMISS' and InsideShot is 'Y' >
			<cfset MissInside = MissInside + 1>
		</cfif>
	</CFIF>
	
	
	<cfif Qtr is 1>
		<cfset q1 = q1 + 1>
	</cfif>
	
	<cfif Qtr is 2>
		<cfset q2 = q2 + 1>
	</cfif>
	
	<cfif Qtr is 3>
		<cfset q3 = q3 + 1>
	</cfif>
	
	<cfif Qtr is 4>
		<cfset q4 = q4 + 1>
	</cfif>
</cfoutput>

<cfif GetInfo.recordcount gt 0 >
<cfset thect = GetInfo.recordcount - OffRebCt>	
	
<cfset pt2madePct = (made2pt/thect)*100>
<cfset pt2missPct = (miss2pt/thect)*100>
<cfset pt3madePct = (made3pt/thect)*100>
<cfset pt3missPct = (miss3pt/thect)*100>
<cfset turnoverPct = (turn/thect)*100>
<cfset ftaPct      = (fta/thect)*100>
<cfset InsidePct  = (in/thect)*100>
<cfset OutsidePct  = (out/thect)*100>
<cfset MadeInsidePct = (Madeinside/InsideShotCt)*100>
<cfset MadeNormalPct = (MadeNormal/TotNormalShots)*100>
<cfset MadeOutsidePct = (MadeOutside/OutsideShotCt)*100>
<cfset PerimPct = 100 - (InsidePct)>
<cfset OffRebPct = (OffRebct / GetInfo.recordcount)*100>

<cfset strucDC = StructNew()>
<!--- <cfset strucDC.pt2madepct = pt2madePct>
<cfset strucDC.pt2misspct = pt2missPct>
<cfset strucDC.pt3madepct = pt3madePct>
<cfset strucDC.pt3misspct = pt3missPct> --->
<cfset strucDC.turnoverpct = TurnoverPct>
<cfset strucDC.FTApct      = FTAPct>
<cfset strucDC.Insidepct   = InsidePct>
<cfset strucDC.Outsidepct  = OutsidePct>
<cfset strucDC.Normalpct   = 100 - (InsidePct)>
<cfset strucDC.PerimeterPct = PerimPct>
<cfset strucDC.MakeInsidePct = MadeInsidePct>
<cfset strucDC.MakeNormalPct = MadeNormalPct>
<cfset strucDC.MakeOutsidePct = MadeOutsidePct>
<cfset strucDC.OffRebPct      = OffRebPct>
<cfset strucDC.Q1     = Q1>
<cfset strucDC.Q2     = Q2>
<cfset strucDC.Q3     = Q3>
<cfset strucDC.Q4     = Q4>

</cfif>

<cfreturn strucDC>
</cffunction>






<cffunction name="getDriveInfo2" access="remote" returntype="struct"> 
	<cfargument name="OffDef"   type="String" required="yes"  />
	<cfargument name="Team"     type="String" required="yes"  />
	<cfargument name="GameTime" type="String" required="no" default=""  />


	<cfquery name="GetInfo" datasource="nba">
	Select *
	from NBADriveCharts
	where OffDef = '#arguments.OffDef#'
	and team     = '#arguments.Team#'
	and Result not in ('TECHNICAL','THREESECONDS','TIMEOUT','JUMPBALL','Substitution')
	
	and LEFT(RESULT,5) <> 'ERROR'
	<cfif arguments.gametime gt ''>
	and Gametime = '#arguments.gametime#'
	</cfif>
	</cfquery>

<cfset miss2pt         = 0>
<cfset made2pt         = 0>
<cfset made3pt         = 0>
<cfset miss3pt         = 0>
<cfset xofffoul         = 0>
<cfset xoffPersonal     = 0>
<cfset FoulShooting    = 0>
<cfset Freethrowmade   = 0>
<cfset Freethrowmissed = 0>
<cfset Rebound         = 0>
<cfset TeamRebound     = 0>
<cfset turn            = 0>

<cfset in      = 0>
<cfset out     = 0>
<cfset fta     = 0>
<cfset ftaPct  = 0>
<cfset q1      = 0>
<cfset q2      = 0>
<cfset q3      = 0>
<cfset q4      = 0>
<cfset MadeInside     = 0>
<cfset MissInside     = 0>
<cfset MadeNormal     = 0>
<cfset TotNormalShots = 0>
<cfset InsideShotCt   = 0>
<cfset OutsideShotCt  = 0>
<cfset MadeOutside    = 0>

<cfset offfoulPCT         = 0>
<cfset offPersonalPCT     = 0>
<cfset FoulShootingPCT    = 0>
<cfset FreethrowmadePCT   = 0> 
<cfset FreethrowmissedPCT = 0>
<cfset ReboundPCT         = 0>
<cfset TeamReboundPCT     = 0>

<cfoutput query="GetInfo">
	
	<cfif '#GetInfo.Result#' is 'FOULOFFENSIVE'>
		<cfset xofffoul = xofffoul + 1 >
	</cfif>

	<cfif '#GetInfo.Result#' is 'FOULPERSONAL'>
		<cfset xoffPersonal = xoffPersonal + 1>
	</cfif>
	
	<cfif '#GetInfo.Result#' is 'FOULSHOOTING'>
		<cfset FoulShooting = FoulShooting +1>
	</cfif>
	
	<cfif '#GetInfo.Result#' is 'REBOUND'>
		<cfset Rebound = Rebound +1>
	</cfif>

	<cfif '#GetInfo.Result#' is 'TEAMREBOUND'>
		<cfset TeamRebound = TeamRebound +1>
	</cfif>	
		
	<cfset normalshot = 'Y'>
	<cfif InsideShot is 'Y'>
		<cfset InsideShotCt = InsideShotCt + 1>
		<cfset normalshot = 'N'>
	</cfif>

	<cfif OutsideShot is 'Y'>
		<cfset OutsideShotCt = OutsideShotCt + 1>
		<cfset normalshot = 'N'>
	</cfif>

	<cfif Result is '2PTMISS'>
		<cfset miss2pt = miss2pt + 1>
		<cfset TotNormalShots = TotNormalShots + 1>

	</cfif>

	<cfif Result is '3PTMISS'>
		<cfset miss3pt = miss3pt + 1>
	</cfif>


	<cfif Result is '2PTMADE'>
		<cfset made2pt = made2pt + 1>
		<cfset TotNormalShots = TotNormalShots + 1>
		<cfset MadeNormal = MadeNormal + 1>
	</cfif>

	<cfif Result is '3PTMADE'>
		<cfset made3pt = made3pt + 1>
		<cfset MadeOutside = MadeOutside + 1>
	</cfif>

	<cfif Result is 'TURNOVER'>
		<cfset turn = turn + 1>
	</cfif>

	<cfif Result is 'FREETHROWMADE'>
		<cfset fta = fta + 1>
		<cfset freethrowmade = freethrowmade + 1>
		
	</cfif>

	<cfif Result is 'FREETHROWMISS'>
		<cfset fta = fta + 1>
		<cfset freethrowmissed = freethrowmissed + 1>
		
	</cfif>

	<cfif PlayType is 'INSIDE'>
		<cfset in = in + 1>
	</cfif>
	
	<cfif PlayType is 'OUTSIDE'>
		<cfset out = out + 1>
	</cfif>

	<cfif Result is '2PTMADE' and InsideShot is 'Y' >
		<cfset MadeInside = MadeInside + 1>
	<cfELSE>
		<cfif Result is '2PTMISS' and InsideShot is 'Y' >
			<cfset MissInside = MissInside + 1>
		</cfif>
	</CFIF>
	
	
	<cfif Qtr is 1>
		<cfset q1 = q1 + 1>
	</cfif>
	
	<cfif Qtr is 2>
		<cfset q2 = q2 + 1>
	</cfif>
	
	<cfif Qtr is 3>
		<cfset q3 = q3 + 1>
	</cfif>
	
	<cfif Qtr is 4>
		<cfset q4 = q4 + 1>
	</cfif>
</cfoutput>

<cfif GetInfo.recordcount gt 0 >
	<cfset pt2madePct     = (made2pt/GetInfo.recordcount)*100>
	<cfset pt2missPct     = (miss2pt/GetInfo.recordcount)*100>
	<cfset pt3madePct     = (made3pt/GetInfo.recordcount)*100>
	<cfset pt3missPct     = (miss3pt/GetInfo.recordcount)*100>
	<cfset turnoverPct    = (turn/GetInfo.recordcount)*100>
	<cfset ftaPct         = (fta/GetInfo.recordcount)*100>
	<cfset InsidePct      = (in/GetInfo.recordcount)*100>
	<cfset OutsidePct     = (out/GetInfo.recordcount)*100>
	<cfset MadeInsidePct  = (Madeinside/InsideShotCt)*100>
	<cfset MadeNormalPct  = (MadeNormal/TotNormalShots)*100>
	<cfset MadeOutsidePct = (MadeOutside/OutsideShotCt)*100>

	<cfset offfoulPCT         = (xofffoul/GetInfo.recordcount)*100>
	<cfset offPersonalPCT     = (xoffPersonal/GetInfo.recordcount)*100>
	<cfset FoulShootingPCT    = (FoulShooting/GetInfo.recordcount)*100>
	<cfset FreethrowmadePCT   = (Freethrowmade/GetInfo.recordcount)*100> 
	<cfset FreethrowmissedPCT = (Freethrowmissed/GetInfo.recordcount)*100>
	<cfset ReboundPCT         = (Rebound/GetInfo.recordcount)*100>
	<cfset TeamReboundPCT     = (TeamRebound/GetInfo.recordcount)*100>



	<cfset strucDC2 = StructNew()>
	<cfset strucDC2.TotalPlays = Getinfo.recordcount>
	<cfset strucDC2.pt2madepct = pt2madePct>
	<cfset strucDC2.pt2misspct = pt2missPct>
	<cfset strucDC2.pt3madepct = pt3madePct>
	<cfset strucDC2.pt3misspct = pt3missPct>
	<cfset strucDC2.turnoverpct = TurnoverPct>
	<cfset strucDC2.FTApct      = FTAPct>
	<cfset strucDC2.Insidepct   = InsidePct>
	<cfset strucDC2.Outsidepct  = OutsidePct>
	<cfset strucDC2.Normalpct   = 100 - (InsidePct + OutsidePct)>
	
	<cfset strucDC2.MakeInsidePct = MadeInsidePct>
	<cfset strucDC2.MakeNormalPct = MadeNormalPct>
	<cfset strucDC2.MakeOutsidePct = MadeOutsidePct>

	<cfset strucDC2.offfoulPCT         = offfoulPCT>
	<cfset strucDC2.offPersonalPCT     = offPersonalPCT>
	<cfset strucDC2.CommitFoulShootingPCT    = FoulShootingPCT>
	<cfset strucDC2.FreethrowmadePCT   = FreethrowmadePCT>
	<cfset strucDC2.FreethrowmissedPCT = FreethrowmissedPCT>

	<cfset strucDC2.ReboundPCT         = ReboundPCT>
	<cfset strucDC2.TeamReboundPCT     = TeamReboundPCT>


	<cfset strucDC2.Q1     = Q1>
	<cfset strucDC2.Q2     = Q2>
	<cfset strucDC2.Q3     = Q3>
	<cfset strucDC2.Q4     = Q4>

</cfif>

<cfreturn strucDC2>
</cffunction>














<cffunction name="checkPlay" output="Yes" access="remote" returntype="struct"> 
	<cfargument name="chkstr" type="String" required="yes"  />

<cfquery datasource="nba">
Insert into debug(Debug_info,insertdate) values ('Start',#now()#)
</cfquery>


	<cfset mystruc = structnew()>
	<cfset mystruc.ShotType   = ''>
	<cfset mystruc.ShotMade   = 'Y'>
	<cfset mystruc.ShotPts    = 2>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfoutput>
	<cfset mystruc.ShotDesc   = 'ERROR - coudnt find #arguments.chkstr#'>
	</cfoutput>
	

	
<cfif FindNocase('Alley Oop Dunk Shot: Made','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType   = 'INSIDE'>
	<cfset mystruc.ShotMade   = 'Y'>
	<cfset mystruc.ShotPts    = 2>
	<cfset mystruc.ShotDesc   = '2PTMADE'>
	<cfset mystruc.PlayIsOver = 'Y'>


<cfelseif FindNocase('Double Technical','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType   = 'UNKNOWN'>
	<cfset mystruc.ShotMade   = 'N'>
	<cfset mystruc.ShotPts    = 0>
	<cfset mystruc.ShotDesc   = 'DOUBLETECH'>
	<cfset mystruc.PlayIsOver = 'Y'>
	
<cfelseif FindNocase('Jump Ball','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType   = 'UNKNOWN'>
	<cfset mystruc.ShotMade   = 'N'>
	<cfset mystruc.ShotPts    = 0>
	<cfset mystruc.ShotDesc   = 'JUMPBALL'>
	<cfset mystruc.PlayIsOver = 'Y'>
	

<cfelseif FindNocase('Dunk Shot: Made','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType   = 'INSIDE'>
	<cfset mystruc.ShotMade   = 'Y'>
	<cfset mystruc.ShotPts    = 2>
	<cfset mystruc.ShotDesc   = '2PTMADE'>
	<cfset mystruc.PlayIsOver = 'Y'>

<cfelseif FindNocase('Dunk Shot: Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType   = 'INSIDE'>
	<cfset mystruc.ShotMade   = 'N'>
	<cfset mystruc.ShotPts    = 0>
	<cfset mystruc.ShotDesc   = '2PTMISS'>
	<cfset mystruc.PlayIsOver = 'N'>

<cfelseif FindNocase('Dunk Shot: Missed Block','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType   = 'INSIDE'>
	<cfset mystruc.ShotMade   = 'N'>
	<cfset mystruc.ShotPts    = 0>
	<cfset mystruc.ShotDesc   = '2PTMISS'>
	<cfset mystruc.PlayIsOver = 'N'>


<cfelseif FindNocase('Fadeaway Bank shot: Made','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType   = 'INSIDE'>
	<cfset mystruc.ShotMade   = 'Y'>
	<cfset mystruc.ShotPts    = 2>
	<cfset mystruc.ShotDesc   = '2PTMADE'>
	<cfset mystruc.PlayIsOver = 'Y'>

<cfelseif FindNocase('Fadeaway Bank shot: Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType   = 'INSIDE'>
	<cfset mystruc.ShotMade   = 'Y'>
	<cfset mystruc.ShotPts    = 0>
	<cfset mystruc.ShotDesc   = '2PTMISS'>
	<cfset mystruc.PlayIsOver = 'N'>

<cfelseif FindNocase('Fadeaway Bank shot: Missed Block','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType   = 'INSIDE'>
	<cfset mystruc.ShotMade   = 'N'>
	<cfset mystruc.ShotPts    = 0>
	<cfset mystruc.ShotDesc   = '2PTMISS'>
	<cfset mystruc.PlayIsOver = 'N'>

<cfelseif FindNocase('Hook Bank shot: Made','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType   = 'INSIDE'>
	<cfset mystruc.ShotMade   = 'Y'>
	<cfset mystruc.ShotPts    = 2>
	<cfset mystruc.ShotDesc   = '2PTMADE'>
	<cfset mystruc.PlayIsOver = 'Y'>

<cfelseif FindNocase('Hook Bank shot: Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType   = 'INSIDE'>
	<cfset mystruc.ShotMade   = 'Y'>
	<cfset mystruc.ShotPts    = 0>
	<cfset mystruc.ShotDesc   = '2PTMISS'>
	<cfset mystruc.PlayIsOver = 'N'>

<cfelseif FindNocase('Hook Bank shot: Missed Block','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType   = 'INSIDE'>
	<cfset mystruc.ShotMade   = 'N'>
	<cfset mystruc.ShotPts    = 0>
	<cfset mystruc.ShotDesc   = '2PTMISS'>
	<cfset mystruc.PlayIsOver = 'N'>


<cfelseif FindNocase('Pullup Bank shot: Made','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType   = ''>
	<cfset mystruc.ShotMade   = 'Y'>
	<cfset mystruc.ShotPts    = 2>
	<cfset mystruc.ShotDesc   = '2PTMADE'>
	<cfset mystruc.PlayIsOver = 'Y'>

<cfelseif FindNocase('Pullup Bank shot: Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType   = ''>
	<cfset mystruc.ShotMade   = 'N'>
	<cfset mystruc.ShotPts    = 0>
	<cfset mystruc.ShotDesc   = '2PTMISS'>
	<cfset mystruc.PlayIsOver = 'N'>

<cfelseif FindNocase('Pullup Bank shot: Missed Block','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType   = 'INSIDE'>
	<cfset mystruc.ShotMade   = 'N'>
	<cfset mystruc.ShotPts    = 0>
	<cfset mystruc.ShotDesc   = '2PTMISS'>
	<cfset mystruc.PlayIsOver = 'N'>




	
<cfelseif FindNocase('Alley Oop Dunk Shot: Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>

<cfelseif FindNocase('Alley Oop Dunk Shot: Missed Block','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>


<cfelseif FindNocase('Driving Bank shot: Made','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 2>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = '2PTMADE'>

<cfelseif FindNocase('Driving Bank shot: Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>

<cfelseif FindNocase('Driving Bank shot: Missed Block','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>


<cfelseif FindNocase('Turnaround Bank shot: Made','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 2>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = '2PTMADE'>

<cfelseif FindNocase('Turnaround Bank shot: Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>

<cfelseif FindNocase('Turnaround Bank shot: Missed Block','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>



<cfelseif FindNocase('Turnaround fadeaway: Made','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 2>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = '2PTMADE'>

<cfelseif FindNocase('Turnaround fadeaway: Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>

<cfelseif FindNocase('Turnaround fadeaway: Missed Block','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>






<cfelseif FindNocase('Driving Dunk shot: Made','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 2>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = '2PTMADE'>

<cfelseif FindNocase('Driving Dunk shot: Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>

<cfelseif FindNocase('Driving Dunk shot: Missed Block','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>


<cfelseif FindNocase('Driving Layup Shot: Made','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 2>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = '2PTMADE'>


<cfelseif FindNocase('Driving Layup Shot: Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>

<cfelseif FindNocase('Driving Layup Shot: Missed Block','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>


<cfelseif FindNocase('Driving Hook Shot: Made','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 2>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = '2PTMADE'>

<cfelseif FindNocase('Driving Hook Shot: Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>

<cfelseif FindNocase('Driving Hook Shot: Missed Block','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>


<cfelseif FindNocase('Fadeaway Jump Shot: Made','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'UNKNOWN'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 2>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = '2PTMADE'>


<cfelseif FindNocase('Fadeaway Jump Shot: Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'UNKNOWN'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>

<cfelseif FindNocase('Fadeaway Jump Shot: Missed Block','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'UNKNOWN'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>


<cfelseif FindNocase('Fadeaway Hook Shot: Made','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 2>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = '2PTMADE'>


<cfelseif FindNocase('Fadeaway Hook Shot: Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>


<cfelseif FindNocase('Fadeaway Hook Shot: Missed Block','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>


<cfelseif FindNocase('Hook Shot: Missed Block','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>

<cfelseif FindNocase('Hook Shot: Made','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = '2PTMADE'>

<cfelseif FindNocase('Hook Shot: Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>



<cfelseif FindNocase('Jump Shot: Made','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'UNKNOWN'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 2>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = '2PTMADE'>


<cfelseif FindNocase('Jump Shot: Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'UNKNOWN'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>


<cfelseif FindNocase('Jump Bank Shot: Made','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 2>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = '2PTMADE'>

<cfelseif FindNocase('Jump Bank Shot: Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>

<cfelseif FindNocase('Running Bank Shot: Made','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 2>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = '2PTMADE'>

<cfelseif FindNocase('Running Bank Shot: Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>

<cfelseif FindNocase('Running Bank Shot: Missed Block','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>


<cfelseif FindNocase('Jump Bank Shot: Missed Block','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>

<cfelseif FindNocase('Reverse Layup Shot: Made','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 2>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = '2PTMADE'>

<cfelseif FindNocase('Reverse Layup Shot: Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>

<cfelseif FindNocase('Reverse Layup Shot: Missed Block','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>

<cfelseif FindNocase('Layup Shot: Made','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 2>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = '2PTMADE'>

<cfelseif FindNocase('Layup Shot: Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>

<cfelseif FindNocase('Layup Shot: Missed Block','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>


<cfelseif FindNocase('Slam Dunk Shot: Made','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 2>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = '2PTMADE'>

<cfelseif FindNocase('Slam Dunk Shot: Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>

<cfelseif FindNocase('Slam Dunk Shot: Missed Block','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>


<cfelseif FindNocase('Jump shot: Made','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'UNKOWN'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 2>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = '2PTMADE'>

<cfelseif FindNocase('Tip shot: Made','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 2>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = '2PTMADE'>

<cfelseif FindNocase('Tip shot: Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>


<cfelseif FindNocase('Jump shot: Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'UNKOWN'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>

<cfelseif FindNocase('Jump shot: Missed Block','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'UNKOWN'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>


<cfelseif FindNocase('Pullup Jump shot: Made','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'UNKOWN'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 2>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = '2PTMADE'>

<cfelseif FindNocase('Pullup Jump shot: Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'UNKOWN'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>

<cfelseif FindNocase('Pullup Jump shot: Missed Block','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'UNKOWN'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>

<cfelseif FindNocase('Step Back Jump shot: Made','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'UNKOWN'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 2>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = '2PTMADE'>

<cfelseif FindNocase('Step Back Jump shot: Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'UNKOWN'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>

<cfelseif FindNocase('Step Back Jump shot: Missed Block','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'UNKOWN'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>	
	<cfset mystruc.ShotDesc   = '2PTMISS'>


<cfelseif FindNocase('Turnaround Fadeaway shot: Made','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 2>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = '2PTMADE'>

<cfelseif FindNocase('Turnaround Fadeaway Shot: Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>

<cfelseif FindNocase('Turnaround Fadeaway Shot: Missed Block','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>





<cfelseif FindNocase('Turnaround Jump Shot: Made','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 2>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = '2PTMADE'>

<cfelseif FindNocase('Turnaround Jump Shot: Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>

<cfelseif FindNocase('Turnaround Jump Shot: Missed Block','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'INSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '2PTMISS'>

<cfelseif FindNocase('3pt Shot: Made','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'OUTSIDE'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 3>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = '3PTMADE'>

<cfelseif FindNocase('3pt Shot: Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'OUTSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '3PTMISS'>

<cfelseif FindNocase('3pt Shot: Missed Block','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'OUTSIDE'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = '3PTMISS'>


<cfelseif FindNocase('Turnover','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'TURNOVER'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = 'TURNOVER'>


<cfelseif FindNocase('Team Timeout','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'TIMEOUT'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = 'TIMEOUT'>

<cfelseif FindNocase('Technical','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'TECHFREETHROW'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = 'TECHNICAL'>

<cfelseif FindNocase('Free Throw Technical','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 1>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMADE'>


<cfelseif FindNocase('Free Throw Technical Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMISS'>



<cfelseif FindNocase('Free Throw Flagrant 1 of 1 Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMISS'>

<cfelseif FindNocase('Free Throw Flagrant 1 of 2 Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMISS'>

<cfelseif FindNocase('Free Throw Flagrant 1 of 3 Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMISS'>



<cfelseif FindNocase('Free Throw Flagrant 2 of 2','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 1>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMADE'>

<cfelseif FindNocase('Free Throw Flagrant 2 of 2 Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 1>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMISS'>
	
	
<cfelseif FindNocase('Free Throw Flagrant 3 of 3','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 1>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMADE'>

<cfelseif FindNocase('Free Throw Flagrant 3 of 3 Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMISS'>
		
	

<cfelseif FindNocase('Free Throw Flagrant 1 of 3','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 1>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMADE'>



<cfelseif FindNocase('Free Throw Flagrant 1 of 1','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 1>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMADE'>

<cfelseif FindNocase('Free Throw Flagrant 1 of 2','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 1>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMADE'>

<cfelseif FindNocase('Free Throw Flagrant 1 of 3','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 1>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMADE'>



<cfelseif FindNocase('Free Throw 1 of 1 Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMISS'>

<cfelseif FindNocase('Free Throw 1 of 2 Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMISS'>

<cfelseif FindNocase('Free Throw 1 of 3 Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMISS'>


<cfelseif FindNocase('Free Throw Clear Path 1 of 1 Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMISS'>

<cfelseif FindNocase('Free Throw Clear Path 1 of 2 Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMISS'>

<cfelseif FindNocase('Free Throw Clear Path 1 of 3 Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMISS'>

<cfelseif FindNocase('Free Throw Clear Path 2 of 2 Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMISS'>

<cfelseif FindNocase('Free Throw Clear Path 2 of 3 Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMISS'>

<cfelseif FindNocase('Free Throw Clear Path 3 of 3 Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMISS'>


<cfelseif FindNocase('Free Throw Clear Path 1 of 1','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 1>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMADE'>

<cfelseif FindNocase('Free Throw Clear Path 1 of 2','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 1>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMADE'>

<cfelseif FindNocase('Free Throw Clear Path 1 of 3','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 1>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMADE'>

<cfelseif FindNocase('Free Throw Clear Path 2 of 2','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 1>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMADE'>

<cfelseif FindNocase('Free Throw Clear Path 2 of 3','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 1>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMADE'>

<cfelseif FindNocase('Free Throw Clear Path 3 of 3','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 1>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMADE'>





<cfelseif FindNocase('Free Throw 1 of 1','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 1>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMADE'>


<cfelseif FindNocase('Free Throw 1 of 2','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 1>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMADE'>


<cfelseif FindNocase('Free Throw 2 of 2 Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMISS'>


<cfelseif FindNocase('Free Throw 2 of 2','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 1>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMADE'>

<cfelseif FindNocase('Free Throw 2 of 3 Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMISS'>

<cfelseif FindNocase('Free Throw 3 of 3 Missed','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMISS'>


<cfelseif FindNocase('Free Throw 1 of 3','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 1>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMADE'>

<cfelseif FindNocase('Free Throw 2 of 3','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 1>
	<cfset mystruc.PlayIsOver = 'N'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMADE'>

<cfelseif FindNocase('Free Throw 3 of 3','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FREETHROW'>
	<cfset mystruc.ShotMade = 'Y'>
	<cfset mystruc.ShotPts  = 1>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = 'FREETHROWMADE'>



<cfelseif FindNocase('Team Rebound','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'REBOUND'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = 'TEAMREBOUND'>

<cfelseif FindNocase('Rebound','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'REBOUND'>
	<cfset mystruc.ShotMade = 'N'>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = 'Y'>
	<cfset mystruc.ShotDesc   = 'REBOUND'>

<cfelseif FindNocase('Foul: Flagrant Type','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FOULSHOOTING'>
	<cfset mystruc.ShotMade = ''>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = ''>
	<cfset mystruc.ShotDesc   = 'FOULSHOOTING'>




<cfelseif FindNocase('Foul: Flagrant Type','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FOULSHOOTING'>
	<cfset mystruc.ShotMade = ''>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = ''>
	<cfset mystruc.ShotDesc   = 'FOULSHOOTING'>


<cfelseif FindNocase('Foul: Shooting','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FOULSHOOTING'>
	<cfset mystruc.ShotMade = ''>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = ''>
	<cfset mystruc.ShotDesc   = 'FOULSHOOTING'>

<cfelseif FindNocase('Foul: Offensive','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FOULOFFENSIVE'>
	<cfset mystruc.ShotMade = ''>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = ''>
	<cfset mystruc.ShotDesc   = 'FOULOFFENSIVE'>


<cfelseif FindNocase('Foul: Defense 3 Second','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FOULDEFENSIVE'>
	<cfset mystruc.ShotMade = ''>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = ''>
	<cfset mystruc.ShotDesc   = 'THREESECONDS'>

<cfelseif FindNocase('Foul: Personal','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FOULPERSONAL'>
	<cfset mystruc.ShotMade = ''>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = ''>
	<cfset mystruc.ShotDesc   = 'FOULPERSONAL'>

<cfelseif FindNocase('Foul: Loose Ball','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'FOULPERSONAL'>
	<cfset mystruc.ShotMade = ''>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = ''>
	<cfset mystruc.ShotDesc   = 'FOULPERSONAL'>


<cfelseif FindNocase('Substitution','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'Substitution'>
	<cfset mystruc.ShotMade = ''>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = ''>
	<cfset mystruc.ShotDesc   = 'Substitution'>

<cfelseif FindNocase('Violation','#arguments.chkstr#') gt 0>
	<cfset mystruc.ShotType = 'VIOLATION'>
	<cfset mystruc.ShotMade = ''>
	<cfset mystruc.ShotPts  = 0>
	<cfset mystruc.PlayIsOver = ''>
	<cfset mystruc.ShotDesc   = 'TURNOVER'>

</cfif>	
<cfquery datasource="nba">
Insert into debug(Debug_info,insertdate) values ('end',#now()#)
</cfquery>

<!--- 






 --->
<cfreturn #mystruc#>



</cffunction>


<cffunction name="getTeam" returntype="string" output=True>
  
	<cfargument name="fullteam">

<Cfswitch expression='#arguments.fullteam#'>

	<cfcase value="Atlanta Hawks">
		<cfset myteamabbrev = 'ATL'>
	</cfcase>
	
	<cfcase value="Charlotte Hornets">
		<cfset myteamabbrev = 'CHA'>
	</cfcase>

	<cfcase value="Cleveland Cavaliers">
		<cfset myteamabbrev = 'CLE'>
	</cfcase>
	
	<cfcase value="Denver Nuggets">
		<cfset myteamabbrev = 'DEN'>
	</cfcase>
	
	<cfcase value="Golden State Warriors">
		<cfset myteamabbrev = 'GSW'>
	</cfcase>

	<cfcase value="Indiana Pacers">
		<cfset myteamabbrev = 'IND'>
	</cfcase>
		
	<cfcase value="Los Angeles Lakers">
		<cfset myteamabbrev = 'LAL'>
	</cfcase>

	<cfcase value="Miami Heat">
		<cfset myteamabbrev = 'MIA'>
	</cfcase>

	<cfcase value="Minnesota Timberwolves">
		<cfset myteamabbrev = 'MIN'>
	</cfcase>

	<cfcase value="New Orleans Pelicans">
		<cfset myteamabbrev = 'NOP'>
	</cfcase>

	<cfcase value="Orlando Magic">
		<cfset myteamabbrev = 'ORL'>
	</cfcase>

	<cfcase value="Phoenix Suns">
		<cfset myteamabbrev = 'PHX'>
	</cfcase>

	<cfcase value="Sacramento Kings">
		<cfset myteamabbrev = 'SAC'>
	</cfcase>

	<cfcase value="Utah Jazz">
		<cfset myteamabbrev = 'UTA'>
	</cfcase>

	<cfcase value="Boston Celtics">
		<cfset myteamabbrev = 'BOS'>
	</cfcase>

	<cfcase value="Chicago Bulls">
		<cfset myteamabbrev = 'CHI'>
	</cfcase>

	<cfcase value="Dallas Mavericks">
		<cfset myteamabbrev = 'DAL'>
	</cfcase>

	<cfcase value="Detroit Pistons">
		<cfset myteamabbrev = 'DET'>
	</cfcase>

	<cfcase value="Houston Rockets">
		<cfset myteamabbrev = 'HOU'>
	</cfcase>

	<cfcase value="Los Angeles Clippers">
		<cfset myteamabbrev = 'LAC'>
	</cfcase>

	<cfcase value="Memphis Grizzlies">
		<cfset myteamabbrev = 'MEM'>
	</cfcase>

	<cfcase value="Milwaukee Bucks">
		<cfset myteamabbrev = 'MIL'>
	</cfcase>

	<cfcase value="New York Knicks">
		<cfset myteamabbrev = 'NYK'>
	</cfcase>

	<cfcase value="Brooklyn Nets">
		<cfset myteamabbrev = 'BKN'>
	</cfcase>

	<cfcase value="Philadelphia 76ers">
		<cfset myteamabbrev = 'PHI'>
	</cfcase>

	<cfcase value="Portland Trail Blazers">
		<cfset myteamabbrev = 'POR'>
	</cfcase>

	<cfcase value="San Antonio Spurs">
		<cfset myteamabbrev = 'SAS'>
	</cfcase>

	<cfcase value="Toronto Raptors">
		<cfset myteamabbrev = 'TOR'>
	</cfcase>

	<cfcase value="Washington Wizards">
		<cfset myteamabbrev = 'WAS'>
	</cfcase>
	               
	<cfcase value="Oklahoma City Thunder">
		<cfset myteamabbrev = 'OKC'>
	</cfcase>

	<cfdefaultcase>
		<cfset myteamabbrev = 'XXX'>
	</cfdefaultcase>
	
</cfswitch>
  	<cfreturn  myteamabbrev>
</cffunction>
	

      
</cfcomponent>
