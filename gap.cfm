
<cftry>

<cfquery datasource="Nba" name="GetRunct">
	Select RunCt,Gametime
	from NBAGameTime
</cfquery>

<cfset yyyy = left(GetRunCt.gametime,4)>
<cfset mm   = mid(GetRunCt.gametime,5,2)>
<cfset dd   = right(GetRunCt.gametime,2)>
<cfset mydate = #Dateformat(DateAdd("d",1,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>

<cfoutput>
#mydate#<br>
</cfoutput>




<cfquery datasource="Nba" name="zGetRunct">
	Delete from GAP
</cfquery>



<cfif GetRunct.recordcount ge 10>
<!--- 	<cfquery datasource="Nba" name="GetRunct">
	Update NbaGameTime
	Set Gametime = '#myDate#',
	RunCt = 0
	</cfquery>
 --->	
	<cfset variables.gametime = '#myDate#'>
	
<cfelse>

	<cfset variables.gametime = '#GetRunCt.GameTime#'>
</cfif>


<cfquery datasource="NBA" name="AddPicks">
	delete from NBAPicks
	where GameTime = '#variables.gametime#'
	and Systemid = 'GAP'
</cfquery>


	
<cfloop index="ii" from="1" to="27">

<cfset myteamarr = arraynew(1)>	

<cfif ii is 1>
	<cfset mystat = 'Turnovers'>

	Turnovers<br>	
<!--- 	Select Team,Avg(dturnovers - oturnovers) stat

	order by stat desc
	group by team
 --->
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(dturnovers - oturnovers) as stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(dturnovers - oturnovers) desc
	</cfquery> 
	
</cfif>




<cfif ii is 2>
	<cfset mystat = 'Scoring'>
	
	Scoring<br>
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(ps - dps) as stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(ps - dps) desc
	</cfquery>
</cfif>
	
<cfif ii is 3>
	<cfset mystat = 'FGAtt'>
	
	FGAtt<br>
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(ofga - dfga) as stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(ofga - dfga) desc
	</cfquery>
</cfif>
	
<cfif ii is 4>
	<cfset mystat = 'FGPct'>
	
	FGpct....<br>
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(ofgpct - dfgpct) as stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(ofgpct - dfgpct) desc
	</cfquery>
</cfif>
	
<cfif ii is 5>
	<cfset mystat = 'Rebounding'>
	
	Rebounding...<br>
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(otreb  - dtreb) as stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(otreb  - dtreb) desc
	</cfquery>
</cfif>

<cfif ii is 6>
	<cfset mystat = 'FTAtt'>
	
	FTAtt...<br>
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(ofta - dfta) as stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(ofta - dfta) desc
	</cfquery>
</cfif>
	
<cfif ii is 7>
	<cfset mystat = 'TPAtt'>
	
	TPAtt...<br>
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(otpm - dtpm) as stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(otpm - dtpm) desc
	</cfquery>
</cfif>


<cfif ii is 8>
	<cfset mystat = 'TPPct'>
	
	TPPct...<br>
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(otppct - dtppct) as stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(otppct - dtppct) desc
	</cfquery>
</cfif>


<cfif ii is 9>
	<cfset mystat = 'ops'>
	
	
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(ps) as stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(ps) desc
	</cfquery>
</cfif>
	
<cfif ii is 10>
	<cfset mystat = 'dps'>
		
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(dps) as stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(dps) asc
	</cfquery>
</cfif>	
	
<cfif ii is 11>
	<cfset mystat = 'ofgpct'>
		
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(ofgpct) as stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(ofgpct) desc
	</cfquery>
</cfif>	
	
<cfif ii is 12>
	<cfset mystat = 'dfgpct'>
		
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(dfgpct) as stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(dfgpct) asc
	</cfquery>
</cfif>	
	
<cfif ii is 13>
	<cfset mystat = 'orebounding'>
		
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(oReb) as stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(oReb) desc
	</cfquery>
</cfif>	
	
<cfif ii is 14>
	<cfset mystat = 'drebounding'>
		
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(dReb) as stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(dReb) asc
	</cfquery>
</cfif>	
	
	
<cfif ii is 15>
	<cfset mystat = 'ofta'>
		
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(ofta) as stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(ofta) desc
	</cfquery>
</cfif>	
	
<cfif ii is 16>
	<cfset mystat = 'dfta'>
		
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(dfta) as stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(dfta) asc
	</cfquery>
</cfif>	
	
<cfif ii is 17>
	<cfset mystat = 'otppct'>
		
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(otppct) as stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(otppct) desc
	</cfquery>
</cfif>	
	
<cfif ii is 18>
	<cfset mystat = 'dtppct'>
		
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(dtppct) as stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(dtppct) asc
	</cfquery>
</cfif>	
	
<cfif ii is 19>
	<cfset mystat = 'oturnovers'>
		
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(oturnovers) as stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(oturnovers) asc
	</cfquery>
</cfif>	
	
<cfif ii is 20>
	<cfset mystat = 'dturnovers'>
		
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(dturnovers) as stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(dturnovers) desc
	</cfquery>
</cfif>	
	

<cfif ii is 21>
	<cfset mystat = 'ofga'>
		
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(ofga) as stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(ofga) desc
	</cfquery>
</cfif>	

<cfif ii is 22>
	<cfset mystat = 'dfga'>
		
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(dfga) as stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(dfga) 
	</cfquery>
</cfif>	


<cfif ii is 23>
	<cfset mystat = 'otpa'>
		
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(otpa) as stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(otpa) desc
	</cfquery>
</cfif>	

<cfif ii is 24>
	<cfset mystat = 'dtpa'>
		
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(dtpa) as stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(dtpa)
	</cfquery>
</cfif>	

<cfif ii is 25>
	<cfset mystat = 'oftpct'>
		
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(oftpct) as stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by Avg(oftpct) desc
	</cfquery>
</cfif>	

<cfif ii is 26>
	<cfset mystat = 'oPIP'>
		
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(PIPRat) as stat
	from PIP
	group by team
	order by Avg(PIPRat) desc
	</cfquery>
</cfif>	

<cfif ii is 27>
	<cfset mystat = 'dPIP'>
		
	<cfquery datasource="Nba" name="myquery">
	Select Team,Avg(PIPRat) as stat
	from PIP
	group by team
	order by Avg(PIPRat) desc
	</cfquery>
</cfif>	

	
	
<cfoutput query="myquery">
	<cfset  arrayappend(myteamarr,'#team#')> 
</cfoutput>


<cfoutput query="myquery">
	<cfset myRat = gap(myteamarr,'#myquery.Team#',10,20,30)>
<!-- 	#Team#: #myrat#...#stat#<br> -->
	
	<cfquery datasource="Nba" name="checkit">
		Select * from gap
		Where Team = '#team#'
	</cfquery>

	<cfif checkit.recordcount is 0>
		<cfquery datasource="Nba" name="changeit">
		Insert into GAP
		(
		team ,
		#mystat#
		)
		Values
		(
		'#team#',
		'#myrat#'
		)
		</cfquery>
	<cfelse>

	
		
		<cfquery datasource="Nba" name="changeit">
			Update GAP
			Set #mystat# = '#myrat#'
			Where Team = '#team#'
		</cfquery>

	</cfif>

	
			<cfquery datasource="Nba" name="UpdateGAP">
			Select * from GAP where team = '#team#'
		</cfquery>

		<cfset offrt = 0>
		<cfset dfrt = 0>
		<cfset totrat = 0>	
		<cfloop query="UpdateGAP">
		
			<cfif UpdateGAP.ofga is 'G'>
				get here1
				<cfset offrt = offrt + 3> 
				get here2
			</cfif>
		
			<cfif UpdateGAP.ofga is 'A'>
				<cfset offrt = offrt + 2> 
			</cfif>
		
			<cfif UpdateGAP.ofga is 'P'>
				<cfset offrt = offrt + 1> 
			</cfif>

			<cfif UpdateGAP.ofta is 'G'>
				<cfset offrt = offrt + 3> 
			</cfif>
		
			<cfif UpdateGAP.ofta is 'A'>
				<cfset offrt = offrt + 2> 
			</cfif>
		
			<cfif UpdateGAP.ofta is 'P'>
				<cfset offrt = offrt + 1> 
			</cfif>
			
			<cfif UpdateGAP.otpa is 'G'>
				<cfset offrt = offrt + 3> 
			</cfif>
		
			<cfif UpdateGAP.otpa is 'A'>
				<cfset offrt = offrt + 2> 
			</cfif>
		
			<cfif UpdateGAP.otpa is 'P'>
				<cfset offrt = offrt + 1> 
			</cfif>
			
			<cfif UpdateGAP.ofgpct is 'G'>
				<cfset offrt = offrt + 3> 
			</cfif>
		
			<cfif UpdateGAP.ofgpct is 'A'>
				<cfset offrt = offrt + 2> 
			</cfif>
		
			<cfif UpdateGAP.ofgpct is 'P'>
				<cfset offrt = offrt + 1> 
			</cfif>

			<cfif UpdateGAP.oftpct is 'G'>
				<cfset offrt = offrt + 3> 
			</cfif>
		
			<cfif UpdateGAP.oftpct is 'A'>
				<cfset offrt = offrt + 2> 
			</cfif>
		
			<cfif UpdateGAP.oftpct is 'P'>
				<cfset offrt = offrt + 1> 
			</cfif>
			
			
			<cfif UpdateGAP.otppct is 'G'>
				<cfset offrt = offrt + 3> 
			</cfif>
		
			<cfif UpdateGAP.otppct is 'A'>
				<cfset offrt = offrt + 2> 
			</cfif>
		
			<cfif UpdateGAP.otppct is 'P'>
				<cfset offrt = offrt + 1> 
			</cfif>

			



			<cfif UpdateGAP.dfga is 'G'>
				<cfset DfRt = DfRt + 3> 
			</cfif>
		
			<cfif UpdateGAP.dfga is 'A'>
				<cfset DfRt = DfRt + 2> 
			</cfif>
		
			<cfif UpdateGAP.dfga is 'P'>
				<cfset DfRt = DfRt + 1> 
			</cfif>

			<cfif UpdateGAP.dfta is 'G'>
				<cfset DfRt = DfRt + 3> 
			</cfif>
		
			<cfif UpdateGAP.dfta is 'A'>
				<cfset DfRt = DfRt + 2> 
			</cfif>
		
			<cfif UpdateGAP.dfta is 'P'>
				<cfset DfRt = DfRt + 1> 
			</cfif>
			
			<cfif UpdateGAP.dtpa is 'G'>
				<cfset DfRt = DfRt + 3> 
			</cfif>
		
			<cfif UpdateGAP.dtpa is 'A'>
				<cfset DfRt = DfRt + 2> 
			</cfif>
		
			<cfif UpdateGAP.dtpa is 'P'>
				<cfset DfRt = DfRt + 1> 
			</cfif>
			
			<cfif UpdateGAP.dfgpct is 'G'>
				<cfset DfRt = DfRt + 3> 
			</cfif>
		
			<cfif UpdateGAP.dfgpct is 'A'>
				<cfset DfRt = DfRt + 2> 
			</cfif>
		
			<cfif UpdateGAP.dfgpct is 'P'>
				<cfset DfRt = DfRt + 1> 
			</cfif>

		
			<cfif UpdateGAP.dtppct is 'G'>
				<cfset DfRt = DfRt + 3> 
			</cfif>
		
			<cfif UpdateGAP.dtppct is 'A'>
				<cfset DfRt = DfRt + 2> 
			</cfif>
		
			<cfif UpdateGAP.dtppct is 'P'>
				<cfset DfRt = DfRt + 1> 
			</cfif>



			<cfquery datasource="Nba" name="changeit">
			Update GAP
			Set offrat = #offrt#,
			DefRat     = #DfRt#,
			OverallRat = #offrt + DfRt#,
			OverPlayRat = #offrt - DfRt#
			Where Team = '#team#'
			</cfquery>
		
		</cfloop>

	
</cfoutput>



</cfloop>



<cfquery datasource="nba" name="Getspds">
Select *
from nbaschedule
where GameTime = '#variables.gametime#'
 </cfquery>

<cfset gamect = 0>
<cfloop query="GetSpds">

	<cfset fav           = '#GetSpds.Fav#'> 
	<cfset und           = '#GetSpds.Und#'>
	<cfset ha            = '#GetSpds.ha#'>
	<cfset spd           = #GetSpds.spd#>
	<cfset ou          = #GetSpds.ou#>  

<cfquery datasource="Nba" name="GetGAPFav">
	Select Scoring
	from GAP
	Where Team = '#Fav#'
</cfquery>

<cfquery datasource="Nba" name="GetGAPUnd">
	Select Scoring
	from GAP
	Where Team = '#Und#'
</cfquery>

<cfquery datasource="Nba" name="GetGAP">
	Select Team
	from GAP
	Where scoring = '#GetGAPUnd.scoring#'
</cfquery>


<cfquery datasource="Nba" name="sc">
	Select Avg(ps) as ps1, Avg(dps) as dps1, Avg(ps + dps) as aps 
	from NBAData
	Where opp in (#QuotedValueList(GetGap.Team)#)
	and team='#fav#'
	and gametime < '#variables.gametime#'
</cfquery>

<cfquery datasource="Nba" name="TotalScenarios">
	Select *
	from NBAData d, NBASchedule s
	Where d.opp in (#QuotedValueList(GetGap.Team)#)
	and d.team='#fav#'
	and s.fav = '#fav#'
	and s.spd >= #spd - 2#
	and s.spd <= #spd + 2#
	and s.und = d.opp
	and s.gametime = d.gametime
	and s.gametime < '#variables.gametime#'
	order by d.gametime
</cfquery>


<!-- <cfoutput query="TotalScenarios">
#team#,#opp#,#spd#,fav=#fav#<br>
</cfoutput>
 -->

<cfquery datasource="Nba" name="TotalCoverd">
	Select *
	from NBAData d, NBASchedule s
	Where d.opp in (#QuotedValueList(GetGap.Team)#)
	and d.team='#fav#'
	and d.ps-d.dps > #spd#
	and s.fav = '#fav#'
	and s.spd >= #spd - 2#
	and s.spd <= #spd + 2#
	and s.und = d.opp
	and s.gametime = d.gametime
	and s.gametime < '#variables.gametime#'
</cfquery>

<cfquery datasource="Nba" name="TotalouScenarios">
	Select *
	from NBAData d
	Where d.opp in (#QuotedValueList(GetGap.Team)#)
	and d.team='#fav#'
	and d.gametime < '#variables.gametime#'
</cfquery>

<cfquery datasource="Nba" name="TotalOverCoverd">
	Select *
	from NBAData d
	Where d.opp in (#QuotedValueList(GetGap.Team)#)
	and d.team='#fav#'
	and d.ps + d.dps > #ou#
	and d.gametime < '#variables.gametime#'
</cfquery>


<cfset FavAvgPS  = sc.ps1>
<cfset FavAvgDPS = sc.dps1>

<!--- <cfoutput>
#fav# Avg PS= #sc.ps#, Avg DPS= #sc.dps#<br>
#fav# covered this number #numberformat(100*(totalcoverd.recordcount/totalscenarios.recordcount),'99.9')#<br>
#fav# covered OVER #numberformat(100*(totalovercoverd.recordcount/totalouscenarios.recordcount),'99.9')#<br>
</cfoutput> --->

<cfquery datasource="Nba" name="GetGAP">
	Select Team
	from GAP
	Where scoring = '#GetGAPFav.scoring#'
</cfquery>

<cfif GetGAP.recordcount neq 0>

<cfquery datasource="Nba" name="TotalScenarios">
	Select *
	from NBAData d, NBASchedule s
	Where d.opp in (#QuotedValueList(GetGap.Team)#)
	and d.team='#und#'
	and s.und = '#und#'
	and s.spd >= #spd - 2#
	and s.spd <= #spd + 2#
	and s.fav = d.opp
	and s.gametime = d.gametime
	and s.gametime < '#variables.gametime#'	
	order by d.gametime
</cfquery>

<cfquery datasource="Nba" name="TotalCoverd">
	Select *
	from NBAData d, NBASchedule s
	Where d.opp in (#QuotedValueList(GetGap.Team)#)
	and d.team='#und#'
	and s.und = '#und#'
	and s.spd >= #spd - 2#
	and s.spd <= #spd + 2#
	and s.fav = d.opp
	and (d.ps - d.dps > 0 or d.dps - d.ps < #spd#)
	and s.gametime = d.gametime
	and s.gametime < '#variables.gametime#'
	order by d.gametime
</cfquery>


<cfquery datasource="Nba" name="TotalouScenarios">
	Select *
	from NBAData d
	Where d.opp in (#QuotedValueList(GetGap.Team)#)
	and d.team='#und#'
	and d.gametime < '#variables.gametime#'
</cfquery>


<cfquery datasource="Nba" name="TotalOverCoverd">
	Select *
	from NBAData d
	Where d.opp in (#QuotedValueList(GetGap.Team)#)
	and d.team='#und#'
	and d.ps + d.dps > #ou#
	and d.gametime < '#variables.gametime#'
</cfquery>


<cfquery datasource="Nba" name="Sc">
	Select Avg(ps) as ps1, Avg(dps) as dps1, Avg(ps + dps) as aps
	from NBAData
	Where Team = '#und#'
	and opp in (#QuotedValueList(GetGap.Team)#)
	and gametime < '#variables.gametime#'
</cfquery>


<cfoutput>
<br>
#und# Avg PS= #sc.ps1#, Avg DPS= #sc.dps1#<br>
<cfif totalscenarios.recordcount gt 0>
#und# covered this number #numberformat(100*(totalcoverd.recordcount/totalscenarios.recordcount),'99.9')#<br>
#und# covered OVER #numberformat(100*(totalovercoverd.recordcount/totalouscenarios.recordcount),'99.9')#<br>
</cfif>
<p>
<cfset UndAvgPS  = sc.ps1>
<cfset UndAvgDPS = sc.dps1>
</cfoutput>

<cfoutput>
<cfif FavAvgPS neq '' and UndAvgDPS neq '' and UndAvgPS neq '' and FavAvgDPS neq ''>

<cfoutput>
===========>*#FavAvgPS#*  *#UndAvgDPS#*<br>
</cfoutput>


<cfset FavPredPs = (FavAvgPS + UndAvgDPS)/2>
<cfset UndPredPs = (UndAvgPS + FavAvgDPS)/2>

<cfif ha is 'H'>
	<cfset FavPredPs = FavPredPS + 3.5>
<cfelse>
	<cfset UndPredPs = UndPredPS + 3.5>
</cfif>

<cfset ourpick = "P">
<cfset ourrat  = 0>
<cfset ourtotalpick = "P">
<cfset ourtotrat = 0>
<cfset mov = FavPredPs - UndPredPs>


<cfif mov gt spd>
	<cfset ourpick = "#fav#">
	<cfset ourrat  = mov - spd>
</cfif>

<cfif mov lt spd>
	<cfset ourpick = "#und#">
	<cfset ourrat  = spd - mov>
</cfif>

<cfif mov lt 0>
	<cfset ourpick = "#und#">
	<cfset ourrat  = spd - mov>
</cfif>

<cfset PredTot = FavPredPs + UndPredPs - 3.5>
<cfif Predtot gt ou>
	<cfset ourtotalpick = "O">
	<cfset ourtotrat    = Predtot - ou>
<cfelse>
	<cfset ourtotalpick = "U">
	<cfset ourtotrat    = ou - Predtot>
</cfif>	


<br>
Final Prediction:<br>
#fav#: #Numberformat(FavPredPs,'999.99')#<br>
#und#: #Numberformat(UndPredPs,'999.99')#<br>
#fav# by #Numberformat(mov,'999.99')#<br>
Vegas Line: #fav# by #spd#<br>
Our Pick is: #ourpick# with a rating of: #ourrat#<br>

TOTAL: #Numberformat(FavPredPs + UndPredPs - 3.5,'999.99')#<br>
Our TOTAL Pick is: #ourtotalpick# with a rating of: #ourtotrat#<br>
Vegas Total: #ou#<br>

**************************************************************************

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
	oupct
	)
	values
	(
	'#variables.gametime#',
	'#fav#',
	'#ha#',
	#spd#,
	'#und#',
	'#ourpick#',
	#ourrat#,
	'GAP',
	#ou#,
	'#ourtotalpick#',
	#ourtotrat#
	)
	</cfquery>


</cfif>
</cfoutput>
</cfif>
</cfloop>


<cfset gamect = 0>
<cfloop query="GetSpds">

	<cfset fav           = '#GetSpds.Fav#'> 
	<cfset und           = '#GetSpds.Und#'>

	<cfquery datasource="Nba" name="changeit">
		select Sum(OverPlayRat) as pred 
		from gap
		Where Team in ('#fav#','#und#')
	</cfquery>
<cfoutput>
	The OverUndRat for #fav#/#und# is #Changeit.pred# at #Getspds.ou#<br>
</cfoutput>
</cfloop>	
		



<cfscript>
function gap(myteamarr,myteam,gHigh,aHigh,pHigh)
{

var currentRow = 1;
for (; currentRow lte ArrayLen(myteamarr) ;)
	
	//WriteOutput(#myteamarr[currentRow]#);

	{

//	WriteOutput('....' & currentRow); 
		if (#trim(myteam)# is #trim(myteamarr[currentRow])#)
		{
		
			//WriteOutput('Yes....'); 
			if (currentRow lte gHigh)
			{
				return 'G';
			}
			
			if (currentRow lte aHigh)
			{
				return 'A';
			}
			
			if (currentRow lte pHigh)
			{
				return 'P';
			}
			
		}
		else
		{
				
		}
		currentRow = currentRow + 1;
	}	
	return 'N/A'; 
}
</cfscript>

<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('GAP.cfm')
</cfquery>

<cfcatch type="any">
  
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.Detail#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:GAP.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>

</cfcatch>

</cftry>
