

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
	
<cfloop index="ii" from="1" to="20">

<cfset myteamarr = arraynew(1)>	

<cfif ii is 1>
	<cfset mystat = 'hTurnovers'>

	Turnovers<br>	
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(dturnovers - oturnovers) as stat
	from NBAData
	where gametime < '#variables.gametime#'
	and ha = 'H'
	group by team
	order by Avg(dturnovers - oturnovers) desc
	</cfquery>
	
</cfif>

<cfif ii is 2>
	<cfset mystat = 'hScoring'>
	
	Scoring<br>
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(ps - dps) as stat
	from NBAData
	where gametime < '#variables.gametime#'
	and ha = 'H'
	group by team
	order by Avg(ps - dps) desc
	</cfquery>
</cfif>
	
<cfif ii is 3>
	<cfset mystat = 'hFGAtt'>
	
	FGAtt<br>
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(ofga - dfga) as stat
	from NBAData
	where gametime < '#variables.gametime#'
	and ha = 'H'
	group by team
	order by Avg(ofga - dfga) desc
	</cfquery>
</cfif>
	
<cfif ii is 4>
	<cfset mystat = 'hFGPct'>
	
	FGpct....<br>
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(ofgpct - dfgpct) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'H'
	group by team
	order by Avg(ofgpct - dfgpct) desc
	</cfquery>
</cfif>
	
<cfif ii is 5>
	<cfset mystat = 'hRebounding'>
	
	Rebounding...<br>
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(otreb  - dtreb) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'H'
	group by team
	order by Avg(otreb  - dtreb) desc
	</cfquery>
</cfif>

<cfif ii is 6>
	<cfset mystat = 'hFTAtt'>
	
	FTAtt...<br>
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(ofta - dfta) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'H'
	group by team
	order by Avg(ofta - dfta) desc
	</cfquery>
</cfif>
	
<cfif ii is 7>
	<cfset mystat = 'hTPAtt'>
	
	TPAtt...<br>
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(otpm - dtpm) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'H'
	group by team
	order by Avg(otpm - dtpm) desc
	</cfquery>
</cfif>


<cfif ii is 8>
	<cfset mystat = 'hTPPct'>
	
	TPPct...<br>
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(otppct - dtppct) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'H'
	group by team
	order by Avg(otppct - dtppct) desc
	</cfquery>
</cfif>


<cfif ii is 9>
	<cfset mystat = 'hops'>
	
	
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(ps) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'H'
	group by team
	order by Avg(ps) desc
	</cfquery>
</cfif>
	
<cfif ii is 10>
	<cfset mystat = 'hdps'>
		
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(dps) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'H'
	group by team
	order by Avg(dps) asc
	</cfquery>
</cfif>	
	
<cfif ii is 11>
	<cfset mystat = 'hofgpct'>
		
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(ofgpct) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'H'
	group by team
	order by Avg(ofgpct) desc
	</cfquery>
</cfif>	
	
<cfif ii is 12>
	<cfset mystat = 'hdfgpct'>
		
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(dfgpct) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'H'
	group by team
	order by Avg(dfgpct) asc
	</cfquery>
</cfif>	
	
<cfif ii is 13>
	<cfset mystat = 'horebounding'>
		
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(oReb) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'H'
	group by team
	order by Avg(oReb) desc
	</cfquery>
</cfif>	
	
<cfif ii is 14>
	<cfset mystat = 'hdrebounding'>
		
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(dReb) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'H'
	group by team
	order by Avg(dReb) asc
	</cfquery>
</cfif>	
	
	
<cfif ii is 15>
	<cfset mystat = 'hofta'>
		
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(ofta) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'H'
	group by team
	order by Avg(ofta) desc
	</cfquery>
</cfif>	
	
<cfif ii is 16>
	<cfset mystat = 'hdfta'>
		
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(dfta) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'H'
	group by team
	order by Avg(dfta) asc
	</cfquery>
</cfif>	
	
<cfif ii is 17>
	<cfset mystat = 'hotppct'>
		
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(otppct) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'H'
	group by team
	order by Avg(otppct) desc
	</cfquery>
</cfif>	
	
<cfif ii is 18>
	<cfset mystat = 'hdtppct'>
		
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(dtppct) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'H'
	group by team
	order by Avg(dtppct) asc
	</cfquery>
</cfif>	
	
<cfif ii is 19>
	<cfset mystat = 'hoturnovers'>
		
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(oturnovers) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'H'
	group by team
	order by Avg(oturnovers) asc
	</cfquery>
</cfif>	
	
<cfif ii is 20>
	<cfset mystat = 'hdturnovers'>
		
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(dturnovers) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'H'
	group by team
	order by Avg(dturnovers) desc
	</cfquery>
</cfif>	
	
	
	
	
<cfoutput query="myquery">
	<cfset  arrayappend(myteamarr,'#team#')> 
</cfoutput>


<cfoutput query="myquery">
	<cfset myRat = gapha(myteamarr,'#myquery.Team#',10,20,30)>
 	#Team#: #myrat#...#stat#<br> 
	
	<cfquery datasource="Nba" name="checkit">
		Select * from gapha
		Where Team = '#team#'
	</cfquery>

	<cfif checkit.recordcount is 0>
		<cfquery datasource="Nba" name="changeit">
		Insert into GAPHA
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
			Update GAPHA
			Set #mystat# = '#myrat#'
			Where Team = '#team#'
		</cfquery>

	</cfif>
</cfoutput>

</cfloop>











<cfloop index="ii" from="1" to="20">

<cfset myteamarr = arraynew(1)>	

<cfif ii is 1>
	<cfset mystat = 'aTurnovers'>

	Turnovers<br>	
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(dturnovers - oturnovers) as stat
	from NBAData
	where gametime < '#variables.gametime#'
	and ha = 'A'
	group by team
	order by Avg(dturnovers - oturnovers) desc
	</cfquery>
	
</cfif>

<cfif ii is 2>
	<cfset mystat = 'aScoring'>
	
	Scoring<br>
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(ps - dps) as stat
	from NBAData
	where gametime < '#variables.gametime#'
	and ha = 'A'
	group by team
	order by Avg(ps - dps) desc
	</cfquery>
</cfif>
	
<cfif ii is 3>
	<cfset mystat = 'aFGAtt'>
	
	FGAtt<br>
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(ofga - dfga) as stat
	from NBAData
	where gametime < '#variables.gametime#'
	and ha = 'A'
	group by team
	order by Avg(ofga - dfga) desc
	</cfquery>
</cfif>
	
<cfif ii is 4>
	<cfset mystat = 'aFGPct'>
	
	FGpct....<br>
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(ofgpct - dfgpct) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'A'
	group by team
	order by Avg(ofgpct - dfgpct) desc
	</cfquery>
</cfif>
	
<cfif ii is 5>
	<cfset mystat = 'aRebounding'>
	
	Rebounding...<br>
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(otreb  - dtreb) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'A'
	group by team
	order by Avg(otreb  - dtreb) desc
	</cfquery>
</cfif>

<cfif ii is 6>
	<cfset mystat = 'aFTAtt'>
	
	FTAtt...<br>
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(ofta - dfta) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'A'
	group by team
	order by Avg(ofta - dfta) desc
	</cfquery>
</cfif>
	
<cfif ii is 7>
	<cfset mystat = 'aTPAtt'>
	
	TPAtt...<br>
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(otpm - dtpm) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'A'
	group by team
	order by Avg(otpm - dtpm) desc
	</cfquery>
</cfif>


<cfif ii is 8>
	<cfset mystat = 'aTPPct'>
	
	TPPct...<br>
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(otppct - dtppct) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'A'
	group by team
	order by Avg(otppct - dtppct) desc
	</cfquery>
</cfif>


<cfif ii is 9>
	<cfset mystat = 'aops'>
	
	
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(ps) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'A'
	group by team
	order by Avg(ps) desc
	</cfquery>
</cfif>
	
<cfif ii is 10>
	<cfset mystat = 'adps'>
		
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(dps) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'A'
	group by team
	order by Avg(dps) asc
	</cfquery>
</cfif>	
	
<cfif ii is 11>
	<cfset mystat = 'aofgpct'>
		
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(ofgpct) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'A'
	group by team
	order by Avg(ofgpct) desc
	</cfquery>
</cfif>	
	
<cfif ii is 12>
	<cfset mystat = 'adfgpct'>
		
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(dfgpct) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'A'
	group by team
	order by Avg(dfgpct) asc
	</cfquery>
</cfif>	
	
<cfif ii is 13>
	<cfset mystat = 'aorebounding'>
		
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(oReb) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'A'
	group by team
	order by Avg(oReb) desc
	</cfquery>
</cfif>	
	
<cfif ii is 14>
	<cfset mystat = 'adrebounding'>
		
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(dReb) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'A'
	group by team
	order by Avg(dReb) asc
	</cfquery>
</cfif>	
	
	
<cfif ii is 15>
	<cfset mystat = 'aofta'>
		
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(ofta) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'A'
	group by team
	order by Avg(ofta) desc
	</cfquery>
</cfif>	
	
<cfif ii is 16>
	<cfset mystat = 'adfta'>
		
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(dfta) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'A'
	group by team
	order by Avg(dfta) asc
	</cfquery>
</cfif>	
	
<cfif ii is 17>
	<cfset mystat = 'aotppct'>
		
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(otppct) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'A'
	group by team
	order by Avg(otppct) desc
	</cfquery>
</cfif>	
	
<cfif ii is 18>
	<cfset mystat = 'adtppct'>
		
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(dtppct) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'A'
	group by team
	order by Avg(dtppct) asc
	</cfquery>
</cfif>	
	
<cfif ii is 19>
	<cfset mystat = 'aoturnovers'>
		
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(oturnovers) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'A'
	group by team
	order by Avg(oturnovers) asc
	</cfquery>
</cfif>	
	
<cfif ii is 20>
	<cfset mystat = 'adturnovers'>
		
	<cfquery datasource="nba" name="myquery">
	Select Team,Avg(dturnovers) as stat
	from NBAData
	where gametime < '#variables.gametime#'
		and ha = 'A'
	group by team
	order by Avg(dturnovers) desc
	</cfquery>
</cfif>	
	
	
	
	
<cfoutput query="myquery">
	<cfset  arrayappend(myteamarr,'#team#')> 
</cfoutput>


<cfoutput query="myquery">
	<cfset myRat = gapha(myteamarr,'#myquery.Team#',10,20,30)>
<!-- 	#Team#: #myrat#...#stat#<br> -->
	
	<cfquery datasource="Nba" name="checkit">
		Select * from gapha
		Where Team = '#team#'
	</cfquery>

	<cfif checkit.recordcount is 0>
		<cfquery datasource="Nba" name="changeit">
		Insert into GAPHA
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
			Update GAPHA
			Set #mystat# = '#myrat#'
			Where Team = '#team#'
		</cfquery>

	</cfif>
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

	<cfset Favha = "">
	<cfset Undha = "">	
	<cfif GetSpds.ha is 'H'>
		<cfset Favha = "H">
		<cfset Undha = "A">	
	<cfelse>	
		<cfset Favha = "A">
		<cfset Undha = "H">	
	</cfif>	
	
	<cfif Favha is 'H'>
	
		<cfquery datasource="Nba" name="GetGAPFav">
		Select hScoring
		from GAPHA
		Where Team = '#Fav#'
	
		</cfquery>

		<cfquery datasource="Nba" name="GetGAPUnd">
		Select aScoring
		from GAPha
		Where Team = '#Und#'
		</cfquery>


		<cfquery datasource="Nba" name="GetGAP">
		Select Team
		from GAPHA
		Where ascoring = '#GetGAPUnd.ascoring#'
		</cfquery>


		<cfquery datasource="nba" name="sc">
		Select Avg(ps) as ps1, Avg(dps) as dps1, Avg(ps + dps) as aps 
		from NBAData
		Where opp in (#QuotedValueList(GetGap.Team)#)
		and team='#fav#'
		and ha = 'H'
		and gametime < '#variables.gametime#'
		</cfquery>

		<cfquery datasource="nba" name="TotalScenarios">
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
		and s.ha = 'H'
		order by d.gametime
		</cfquery>

			<cfquery datasource="nba" name="TotalCoverd">
				Select *
				from NBAData d, NBASchedule s
				Where d.opp in (#QuotedValueList(GetGap.Team)#)
				and d.team='#fav#'
				and d.ps-d.dps > #spd#
				and s.fav = '#fav#'
				and s.spd >= #spd - 2#
				and s.spd <= #spd + 2#
				and s.und = d.opp
				and s.ha = 'H'
				and s.gametime = d.gametime
				and s.gametime < '#variables.gametime#'
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
				from GAPha
				Where hscoring = '#GetGAPFav.hscoring#'
				
			</cfquery>

			<cfif GetGAP.recordcount neq 0>

				<cfquery datasource="nba" name="TotalScenarios">
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
					and s.ha = 'A'
					order by d.gametime
				</cfquery>
	
				<cfquery datasource="nba" name="TotalCoverd">
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
						and s.ha = 'A'
					order by d.gametime
				</cfquery>
	
	
				<cfquery datasource="nba" name="TotalouScenarios">
					Select *
					from NBAData d
					Where d.opp in (#QuotedValueList(GetGap.Team)#)
					and d.team='#und#'
					and d.gametime < '#variables.gametime#'
					and d.ha = 'A'
				</cfquery>
	
	
				<cfquery datasource="nba" name="TotalOverCoverd">
					Select *
					from NBAData d
					Where d.opp in (#QuotedValueList(GetGap.Team)#)
					and d.team='#und#'
					and d.ps + d.dps > #ou#
					and d.gametime < '#variables.gametime#'
					and d.ha = 'A'
				</cfquery>
				
				
				<cfquery datasource="nba" name="Sc">
					Select Avg(ps) as ps1, Avg(dps) as dps1, Avg(ps + dps) as aps
					from NBAData
					Where Team = '#und#'
					and opp in (#QuotedValueList(GetGap.Team)#)
					and gametime < '#variables.gametime#'
					and ha = 'A'
				</cfquery>

				<cfoutput>
				<br>
			<!--- #und# Avg PS= #sc.ps#, Avg DPS= #sc.dps#<br>
			#und# covered this number #numberformat(100*(totalcoverd.recordcount/totalscenarios.recordcount),'99.9')#<br>
			#und# covered OVER #numberformat(100*(totalovercoverd.recordcount/totalouscenarios.recordcount),'99.9')#<br>
			 --->
				<cfset UndAvgPS  = sc.ps1>
				<cfset UndAvgDPS = sc.dps1>
				*----------------------*<BR>
				#FAV#..#UND#<BR>
				FavAvgPS= #FavAvgPS#..#UndAvgDPS#<BR>
				UndAvgDPS= #UndAvgPS#..#FavAvgDPS#<BR>
				<HR>
				*----------------------*<BR>
				
				<CFIF FavAvgPS neq '' and UndAvgDPS neq '' and UndAvgPS neq '' and  FavAvgDPS neq ''>
				
				<cfset FavPredPs = (FavAvgPS + UndAvgDPS)/2>
				<cfset UndPredPs = (UndAvgPS + FavAvgDPS)/2>
			
				<cfif GetSpds.ha is 'H'>
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
				'GAPHA',
				#ou#,
				'#ourtotalpick#',
				#ourtotrat#
				)
				</cfquery>
		
				<cfif ourrat ge 4.5>
				<cfquery datasource="NBA" name="AddPicks">
				Update FinalPicks
				Set GAPHA = '#ourpick#'
				Where Fav = '#Fav#' 
				and GameTime = '#variables.gametime#'
				</cfquery>
				</cfif>
				</cfif>
				</cfoutput>
			
			</cfif>
		
	<cfelse>


		<cfquery datasource="Nba" name="GetGAPFav">
		Select aScoring
		from GAPHA
		Where Team = '#Fav#'
		</cfquery>

		<cfquery datasource="Nba" name="GetGAPUnd">
			Select hScoring
			from GAPha
			Where Team = '#Und#'
		</cfquery>


		<cfquery datasource="Nba" name="GetGAP">
			Select Team
			from GAPHA
			Where hscoring = '#GetGAPUnd.hscoring#'
		</cfquery>
		
		
		<cfquery datasource="nba" name="sc">
			Select Avg(ps) as ps1, Avg(dps) as dps1, Avg(ps + dps) as aps 
			from NBAData
			Where opp in (#QuotedValueList(GetGap.Team)#)
			and team='#fav#'
			and ha = 'A'
			and gametime < '#variables.gametime#'
		</cfquery>

		<cfquery datasource="nba" name="TotalScenarios">
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
			and s.ha = 'A'
			order by d.gametime
		</cfquery>


		<cfquery datasource="nba" name="TotalCoverd">
			Select *
			from NBAData d, NBASchedule s
			Where d.opp in (#QuotedValueList(GetGap.Team)#)
			and d.team='#fav#'
			and d.ps-d.dps > #spd#
			and s.fav = '#fav#'
			and s.spd >= #spd - 2#
			and s.spd <= #spd + 2#
			and s.und = d.opp
			and s.ha = 'A'
			and s.gametime = d.gametime
			and s.gametime < '#variables.gametime#'
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
			from GAPha
			Where ascoring = '#GetGAPFav.ascoring#'
			
		</cfquery>

		<cfif GetGAP.recordcount neq 0>

			<cfquery datasource="nba" name="TotalScenarios">
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
				and s.ha = 'H'
				order by d.gametime
			</cfquery>
			
			<cfquery datasource="nba" name="TotalCoverd">
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
					and s.ha = 'H'
				order by d.gametime
			</cfquery>


			<cfquery datasource="nba" name="TotalouScenarios">
				Select *
				from NBAData d
				Where d.opp in (#QuotedValueList(GetGap.Team)#)
				and d.team='#und#'
				and d.gametime < '#variables.gametime#'
				and d.ha = 'H'
			</cfquery>
			
			
			<cfquery datasource="nba" name="TotalOverCoverd">
				Select *
				from NBAData d
				Where d.opp in (#QuotedValueList(GetGap.Team)#)
				and d.team='#und#'
				and d.ps + d.dps > #ou#
				and d.gametime < '#variables.gametime#'
				and d.ha = 'H'
			</cfquery>
			
			
			<cfquery datasource="nba" name="Sc">
				Select Avg(ps) as ps1, Avg(dps) as dps1, Avg(ps + dps) as aps
				from NBAData
				Where Team = '#und#'
				and opp in (#QuotedValueList(GetGap.Team)#)
				and gametime < '#variables.gametime#'
				and ha = 'H'
			</cfquery>

			<cfoutput>
			<br>
			<!--- #und# Avg PS= #sc.ps#, Avg DPS= #sc.dps#<br>
			#und# covered this number #numberformat(100*(totalcoverd.recordcount/totalscenarios.recordcount),'99.9')#<br>
			#und# covered OVER #numberformat(100*(totalovercoverd.recordcount/totalouscenarios.recordcount),'99.9')#<br>
			 --->
			<cfset UndAvgPS  = sc.ps1>
			<cfset UndAvgDPS = sc.dps1>
			
			<cfif FavAvgPS neq "" and UndAvgDPS neq "" and UndAvgPS neq "" and FavAvgDPS neq "">
			
				<cfset FavPredPs = (FavAvgPS + UndAvgDPS)/2>
				<cfset UndPredPs = (UndAvgPS + FavAvgDPS)/2>
			
				<cfif GetSpds.ha is 'H'>
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
			'GAPHA',
			#ou#,
			'#ourtotalpick#',
			#ourtotrat#
			)
			</cfquery>

				<cfset mypick = '#ourpick#'>
				<cfif ourrat ge 4.5>
					<cfset mypick = '**#ourpick#'>
				</cfif>
				
					<cfquery datasource="NBA" name="AddPicks">
					Update FinalPicks
					Set GAPHA = '#mypick#'
					Where Fav = '#Fav#' 
					and GameTime = '#variables.gametime#'
					</cfquery>
				

			
			

		</cfif>
		</cfoutput>
		</cfif>
		
	</cfif>





</cfloop>


<cfscript>
function gapha(myteamarr,myteam,gHigh,aHigh,pHigh)
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

<cfcatch type="any">
  
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.Detail#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:GAPHA.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>

</cfcatch>

</cftry>

