<cfquery datasource="nba" name = "GetIt">
Select f.gametime,f.Fav,f.spd,f.Und,f.ha,f.WhoCovered,f.FavHealthL7,f.UndHealthL7,ge.Team,ge.TotEffl2,ge.TotEffl3,ge.TotEffl4,ge.ConseqGood,ge.ConseqBad
from Finalpicks f, GameEffort ge
Where f.gametime = ge.gametime
and f.gametime > '20191020'
and ge.Team in (f.fav)

union

Select f.gametime, f.Fav,f.spd,f.Und,f.ha,f.WhoCovered,f.FavHealthL7,f.UndHealthL7,ge.Team,ge.TotEffl2,ge.TotEffl3,ge.TotEffl4,ge.ConseqGood,ge.ConseqBad
from Finalpicks f, GameEffort ge
Where f.gametime = ge.gametime
and ge.Team in (f.und)
and f.gametime > '20191020'
order by f.gametime desc 
</cfquery>






<cfquery datasource="nba" name = "GetIt">
Select f.gametime,f.Fav,f.spd,f.Und,f.ha,f.WhoCovered,f.FavHealthL7,f.UndHealthL7,ge.Team,ge.TotEffl2,ge.TotEffl3,ge.TotEffl4,ge.ConseqGood,ge.ConseqBad
from Finalpicks f, GameEffort ge
Where f.gametime = ge.gametime
and f.gametime > '20191020'
and ge.Team in (f.fav)
and ge.conseqgood = 3
and ge.efflst2 >= 20
union

Select f.gametime, f.Fav,f.spd,f.Und,f.ha,f.WhoCovered,f.FavHealthL7,f.UndHealthL7,ge.Team,ge.TotEffl2,ge.TotEffl3,ge.TotEffl4,ge.ConseqGood,ge.ConseqBad
from Finalpicks f, GameEffort ge
Where f.gametime = ge.gametime
and ge.Team in (f.und)
and f.gametime > '20191020'
and ge.conseqgood <> 3
order by f.gametime desc 
</cfquery>















<table width="60%" cellpadding="4" cellspacing="4" border="1">
<tr>
<td>GameTime</td>
<td>Fav</td>
<td>HA</td>
<td>Spread</td>
<td>Und</td>
<td>Covered</td>
<td>Fav Health</td>
<td>Und Health</td>
<td>Stats For</td>
<td>EffLst2</td>
<td>EffLst3</td>
<td>EffLst4</td>
<td>Conseq Good</td>
<td>Conseq Bad</td>
</tr>
<cfoutput query="GetIt">
<tr>
<td>#GameTime#</td>
<td>#Fav#</td>
<td>#HA#</td>
<td>#Spd#</td>
<td>#Und#</td>
<td>#WhoCovered#</td>
<td>#FavHealthL7#</td>
<td>#UndHealthL7#</td>
<td>#team#</td>
<td>#totEffL2#</td>
<td>#totEffL3#</td>
<td>#totEffL4#</td>
<td>#ConseqGood#</td>
<td>#ConseqBad#</td>
</tr>
</cfoutput>



<cfquery datasource="NBA" name="GetDay">
Select * 
from Nbagametime
</cfquery>

<cfset mygametime='#getday.gametime#'>

<cfset yyyy        = left(mygametime,4)>
<cfset mm          = mid(mygametime,5,2)>
<cfset dd          = right(mygametime,2)>
<cfset mydate      = #Dateformat(DateAdd("d",0,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
<CFSET PriorDAY    = #Dateformat(DateAdd("d",-1,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
<CFSET PriorDayStr = ToString(PriorDay)>

<cfquery datasource="NBA" name="GetTeams">
Select Distinct Team from NBADATA 
</cfquery>

<cfquery datasource="NBA" name="Addit">
	Delete from GameEffort where gametime = '#mygametime#'
</cfquery>

<table border="1" width="50%">
	<tr><td>Team</td>
	<td>toteffl2</td>
	<td>toteffl3</td>
	<td>toteffl4</td>
	<td>conseqGoodEffort</td>
	<td>conseqBadEffort</td>
	</tr>

<cfloop query="GetTeams">

	<cfquery datasource="NBA" name="GetData">
	Select * 
	from NbaData
	Where team = '#GetTeams.Team#'
	and gametime < '#mygametime#'
	order by gametime desc
	</cfquery>

	<cfset loopct   = 0>
	<cfset toteffl2 = 0>
	<cfset toteffl3 = 0>
	<cfset toteffl4 = 0>
	
	<cfset ConseqBadEffort  = 0>
	<cfset ConseqGoodEffort = 0>
	<cfset CheckStreak=''>
	<cfset Done = 'N'>
	
	<cfset PrevEffortWasBad = ''>
	<cfset PrevEffortWasGood = ''>
	
	
	
	<cfloop query="GetData">
	
		<cfset loopct = loopct + 1>
		<cfif loopct lt 3>
			<cfset toteffl2 = toteffl2 + #GetData.TotEffort#>
		</cfif>
		<cfif loopct lt 4>
			<cfset toteffl3 = toteffl3 + #GetData.TotEffort#>
		</cfif>
		<cfif loopct lt 5>
			<cfset toteffl4 = toteffl4 + #GetData.TotEffort#>
		</cfif>
	
		
		<cfif done is 'N'>
			1
			<cfif CheckStreak is 'BAD' or CheckStreak is ''>
			2
				<cfif PrevEffortWasBad is 'Y' or loopct is 1 or PrevEffortWasGood is ''>
				3
					<cfoutput>
					...#GetData.TotEffort#...
					</cfoutput>	
					<cfif GetData.TotEffort lt 0>
					4
						<cfset CheckStreak='BAD'>
						<cfset ConseqBadEffort = ConseqBadEffort + 1>
						<cfset PrevEffortWasBad = 'Y'>
					<cfelse>
						5
						<cfif loopct gt 1>
							<cfset done = 'Y'>
						</cfif>
					</cfif>
			
				</cfif>
			</cfif>
			
			<cfif CheckStreak is 'GOOD' or CheckStreak is ''>
			6
				<cfif PrevEffortWasGood is 'Y' or loopct is 1 or PrevEffortWasGood is '' >
				7
				<cfoutput>
					...#GetData.TotEffort#...
					</cfoutput>	
					<cfif GetData.TotEffort gt 0>
					8
						<cfset CheckStreak='GOOD'>
						<cfset PrevEffortWasGood = 'Y'>
						<cfset ConseqGoodEffort = ConseqGoodEffort + 1>
					<cfelse>
						9
						<cfif loopct gt 1>
							<cfset done = 'Y'>
						</cfif>
					</cfif>

				</cfif>

			</cfif>
				
		</cfif>
	

	</cfloop>
	<cfoutput>
	<tr>
	<td>#GetTeams.Team#</td>
	<td>#toteffl2#</td>
	<td>#toteffl3#</td>
	<td>#toteffl4#</td>
	<td>#conseqGoodEffort#</td>
	<td>#conseqBadEffort#</td>
	</tr>
	
	<cfquery datasource="NBA" name="Addit">
	INSERT INTO GameEffort (gametime,Team,toteffl2,toteffl3,toteffl4,ConseqGood,ConseqBad) values ('#mygametime#','#GetTeams.Team#',#toteffl2#,#toteffl3#,#toteffl4#,#conseqGoodEffort#,#conseqBadEffort#) 
	</cfquery>
	
	
	
	</cfoutput>
	<cfset loopct   = 0>
	<cfset toteffl2 = 0>
	<cfset toteffl3 = 0>
	<cfset toteffl4 = 0>
	
	<cfset ConseqBadEffort  = 0>
	<cfset ConseqGoodEffort = 0>
	<cfset CheckStreak      =''>

</cfloop>

</table>


<cfquery datasource="nba" name = "GetItF">
Select f.Fav,f.spd,f.Und,f.ha,f.WhoCovered,f.FavHealthL7,f.UndHealthL7,ge.Team,ge.TotEffl2,ge.TotEffl3,ge.TotEffl4,ge.ConseqGood,ge.ConseqBad
from Finalpicks f, GameEffort ge
Where f.gametime = ge.gametime
and ge.Team in (f.fav)
</cfquery>

<cfquery datasource="nba" name = "GetItU">
Select f.Fav,f.spd,f.Und,f.ha,f.WhoCovered,f.FavHealthL7,f.UndHealthL7,ge.Team,ge.TotEffl2,ge.TotEffl3,ge.TotEffl4,ge.ConseqGood,ge.ConseqBad
from Finalpicks f, GameEffort ge
Where f.gametime = ge.gametime
and ge.Team in (f.und)
</cfquery>


<table>
<cfif 1 is 2>
<cfoutput query="GetIt">
<tr>
<td>#GetIt.gametime#</td>
<td>#GetIt.Fav#</td>
<td>#GetIt.ha#</td>
<td>#GetIt.spd#</td>
<td>#GetIt.Und#</td>
<td>#GetIt.WhoCovered#</td>
<td>#GetIt.FavHealthL7#</td>
<td>#GetIt.UndHealthL7#</td>
<td>#GetIt.FavConseqGood#</td>
<td>#GetIt.UndConseqGood#</td>
<td>#GetIt.FavConseqBad#</td>
<td>#GetIt.UndConseqBad#</td>
<td>#GetIt.TotEffl2#</td>
<td>#GetIt.TotEffl2#</td>




</cfoutput>

</cfif>









