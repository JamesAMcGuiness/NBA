
--Use below to reload from backup
<cfif 1 is 2>
<cfquery datasource="NBA" name="DelRecs">
Delete from SystemRecord 
</cfquery>

<cfquery datasource="NBA" name="GetRecs">
Select * 
from RecordBackup
where Active='Y'
order by Systemnum
</cfquery>


<cfloop query="GetRecs">
	<cfoutput>
	Trying to load #SystemNum#<br>
	</cfoutput>
	<cfquery datasource="NBA" name="AddRecs">
	Insert into SystemRecord (Unit,UsingForPicksFlag,System,SystemNum,Wins,Losses,Pct,PyWins,PyLosses,W2011,L2011,Pct2011,Active,LifetimeWins,LifetimeLosses,LifetimePct,W2012,L2012,Pct2012,UpToDateWins,UpToDateLosses,UpToDatePct) values(#GetRecs.Unit#,'#GetRecs.UsingForPicksFlag#','#GetRecs.System#','#GetRecs.SystemNum#',#GetRecs.Wins#,#GetRecs.Losses#,#GetRecs.Pct#,#GetRecs.PyWins#,#GetRecs.PyLosses#,#GetRecs.W2011#,#GetRecs.L2011#,#GetRecs.Pct2011#,'#GetRecs.Active#',#GetRecs.LifetimeWins#,#GetRecs.LifetimeLosses#,#GetRecs.LifetimePct#,#GetRecs.W2012#,#GetRecs.L2012#,#GetRecs.Pct2012#,#GetRecs.UpToDateWins#,#GetRecs.UpToDateLosses#,#GetRecs.UpToDatePct#)
	</cfquery>
</cfloop>

</cfif>


<cfquery datasource="NBA" name="GetRecs">
Select * 
from SystemRecord
where Active='Y'
order by Systemnum
</cfquery>


-- Save a backup of the current System Record...
<cfif 1 is 1>
<cfquery datasource="NBA" name="DelRecs">
Delete from RecordBackup 
</cfquery>

<cfloop query="GetRecs">
	<cfoutput>
	Trying to load #SystemNum#<br>
	</cfoutput>
	<cfquery datasource="NBA" name="AddRecs">
	Insert into RecordBackup (Unit,UsingForPicksFlag,System,SystemNum,Wins,Losses,Pct,PyWins,PyLosses,W2011,L2011,Pct2011,Active,LifetimeWins,LifetimeLosses,LifetimePct,W2012,L2012,Pct2012,UpToDateWins,UpToDateLosses,UpToDatePct) values(#GetRecs.Unit#,'#GetRecs.UsingForPicksFlag#','#GetRecs.System#','#GetRecs.SystemNum#',#GetRecs.Wins#,#GetRecs.Losses#,#GetRecs.Pct#,#GetRecs.PyWins#,#GetRecs.PyLosses#,#GetRecs.W2011#,#GetRecs.L2011#,#GetRecs.Pct2011#,'#GetRecs.Active#',#GetRecs.LifetimeWins#,#GetRecs.LifetimeLosses#,#GetRecs.LifetimePct#,#GetRecs.W2012#,#GetRecs.L2012#,#GetRecs.Pct2012#,#GetRecs.UpToDateWins#,#GetRecs.UpToDateLosses#,#GetRecs.UpToDatePct#)
	</cfquery>
</cfloop>
</cfif>

<cfset StartTracking = '20221017'>


<cfquery datasource="NBA" name="UpdSystems">
Update  SystemRecord
Set W2012 = 0,
L2012 = 0,
pct2012 = 0
</cfquery>


<cfquery datasource="NBA" name="GetSystems">
Select * 
from SystemRecord
WHERE Active='Y'
order by PCT2012 desc
</cfquery>

<cfquery dbtype="query" name="GetSYS100WL">
Select * 
from GetSystems
where SYSTEMNUM = 'SYS100'
</cfquery>

<cfset S100Wins   = GetSYS100WL.W2012>
<cfset S100Losses = GetSYS100WL.L2012>


<cfset mysysarry = arraynew(1)>
<cfset myWarry = arraynew(1)>
<cfset myLarry = arraynew(1)>

<cfset loopct = 0>
<cfloop query="GetSystems">
	<cfset loopct = loopct + 1>
	<cfset mysysarry[loopct] = '#GetSystems.SystemNum#'>
	<cfset myWarry[loopct]  = #GetSystems.W2012#>
	<cfset myLarry[loopct]  = #GetSystems.L2012#>
</cfloop>

<cfquery datasource="NBA" name="GetDay">
Select * 
from Nbagametime
</cfquery>


<cfset yyyy = left(GetDay.gametime,4)>
<cfset mm   = mid(GetDay.gametime,5,2)>
<cfset dd   = right(GetDay.gametime,2)>
<cfset mydate = #Dateformat(DateAdd("d",0,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
<CFSET PriorDAY = #Dateformat(DateAdd("d",0,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
<CFSET PriorDayStr = ToString(PriorDay)>

<cfoutput>
#priordaystr#
</cfoutput>

<cfquery datasource="NBA" name="GetPriorDayPicks">
Select * 
from FinalPicks
where Gametime >= '#StartTracking#'
</cfquery>

<cfif 1 is 2>
(Gametime >= '20181115' and Gametime <= '2019305') or (Gametime >= '20191115' and Gametime <= '2020305')
</cfif>

<cfloop index="ii" from="1" to="#arraylen(mysysarry)#">

	<cfset mysys =trim(mysysarry[#ii#])>
	
	
	<cfif 1 is 2>
	<cfquery datasource="NBA" name="GetPriorDayPicks">
	Select * 
	from FinalPicks
	where Gametime = '#StartTracking#'
	and #mysys# > ''
	order by gametime
	</cfquery>
	</cfif>



	<cfoutput query="GetPriorDayPicks">

	************************************<br>
	Evaluating for: #Gametime#<br>
	************************************<br>
	
	<cfif GetPriorDayPicks.WhoCovered neq 'PUSH' and GetPriorDayPicks.WhoCovered gt '' >
	
		<cfset mypick = evaluate('GetPriorDayPicks.#mysys#') >
		
		<cfif mypick gt ''>
			<p>
			comparing sytem #mysys# mypick of #mypick# to whocovered of #GetPriorDayPicks.WhoCovered#<br>
			<br>
			<cfif (GetPriorDayPicks.WhoCovered is '#mypick#') or ('**' & '#GetPriorDayPicks.WhoCovered#' is '#mypick#') or ('#GetPriorDayPicks.WhoCovered#' & '*' is '#mypick#')>
					yes we won!<br>
				
					<cfset myWarry[ii] = myWarry[ii] + 1> 
					<cfset myWin  = myWarry[ii]>
					<cfset myLoss = myLarry[ii]>
					
					<cfif (mywin + myloss) gt 0>
					<cfset mypct = 100*(myWin/(myWin + myLoss))>
					<cfelse>
					<cfset mypct = 0>
					</cfif>
					
					
			<cfelse>
			
					shit..we lost<br>
					<cfset myLarry[ii] = myLarry[ii] + 1> 
					<cfset myWin  = myWarry[ii]>
					<cfset myLoss = myLarry[ii]>
					
					<cfif (mywin + myloss) gt 0>
					<cfset mypct = 100*(myWin/(myWin + myLoss))>
					<cfelse>
					<cfset mypct = 0>
					</cfif>
					
					
					

			</cfif>
		</cfif>
		
	</cfif>
			
</cfoutput>	
		<cfif myWarry[ii] + myLarry[ii] gt 0>
				<cfquery datasource="nba" name="updateit">
					Update SystemRecord
					Set W2012 = #myWarry[ii]#,
				  		 L2012 = #myLarry[ii]#
					where SystemNum = '#mysys#'
				</cfquery>
			</cfif>	
</cfloop>


<cfif 1 is 1>
<cfquery datasource="nba" name="updateit">
					Update SystemRecord
					Set UpToDateWins   = (W2012  + LifetimeWins),
						UpToDateLosses = (L2012  + LifetimeLosses)
						where SystemNum > ''
						and Active='Y'
</cfquery>
</cfif>


<cfquery datasource="nba" name="updateit1">
					Select * from SystemRecord
					where SystemNum > '' 
					and Active='Y'
					order by SystemNum
</cfquery>


<cfif 1 is 1>
<cfloop query="updateit1">
<cfoutput>
Starting #updateit1.SystemNum#<br>
</cfoutput>
<cfquery datasource="nba" name="updateit">
					Update SystemRecord
					Set UpToDatePct   = 100*(UpToDateWins /(UpToDateWins + UpToDateLosses))
					where SystemNum = '#Updateit1.SystemNum#' 
</cfquery>



</cfloop>
</cfif>



get here!
<cfquery datasource="nba" name="updateit2">
					Update SystemRecord
					Set Pct2012   = 100*(W2012 /(W2012 + L2012))
					where SystemNum > '' 
					and (W2012 + L2012) > 0 
</cfquery>


<cfquery datasource="Nba" name="UPDATE">
	Insert into NBADataLoadStatus
	(
	ProgramName
	)
	values
	(
	'Record has been updated - UpdateRecordForTimePeriod.cfm'
	)
</cfquery>

