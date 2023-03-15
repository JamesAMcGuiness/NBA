<cfif 1 is 1>
<cftry>


<cfquery datasource="NBA" name="GetSystems">
Select * 
from SystemRecord
where Active='Y'
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


<!--- <cfquery datasource="NBA" name="GetPicks">
Select * 
from FinalPicks
where Gametime >= '20131115'
order by gametime desc
</cfquery> --->

<cfquery datasource="NBA" name="GetDay">
Select * 
from Nbagametime
</cfquery>


<cfset yyyy = left(GetDay.gametime,4)>
<cfset mm   = mid(GetDay.gametime,5,2)>
<cfset dd   = right(GetDay.gametime,2)>
<cfset mydate = #Dateformat(DateAdd("d",0,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
<CFSET PriorDAY = #Dateformat(DateAdd("d",-1,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>
<CFSET PriorDayStr = ToString(PriorDay)>

<cfoutput>
#priordaystr#
</cfoutput>

<cfquery datasource="NBA" name="GetPriorDayPicks">
Select * 
from FinalPicks
where Gametime = '#PriorDayStr#'
</cfquery>


<cfoutput query="GetPriorDayPicks">
<cfloop index="ii" from="1" to="#arraylen(mysysarry)#">
	<cfset mysys =trim(mysysarry[#ii#])>

	<!--- Check Totals --->
	<cfif evaluate('GetPriorDayPicks.#mysys#') is 'OVER' or evaluate('GetPriorDayPicks.#mysys#') is 'UNDER'  >

************** We need to check #GetPriorDayPicks.fav# / #GetPriorDayPicks.und# <br>


		<!--- See what the total score was for the game --->
		<cfquery datasource="NBA" name="GetTotals">
		Select ps + dps as total 
		from NBAData
		where Gametime = '#PriorDayStr#'
		and Team = '#GetPriorDayPicks.fav#'
		</cfquery>

		<cfset OUWinner = 'PUSH'>
		<cfif GetTotals.recordcount gt 0>
		
			<!--- See what the OU was for the game --->
			<cfquery datasource="NBA" name="GetOU">
			Select ou 
			from NBASchedule
			where Gametime = '#PriorDayStr#'
			and Fav        = '#GetPriorDayPicks.fav#'
			</cfquery>
		
			<cfif GetTotals.total gt GetOu.ou>
				<cfset OUWinner = 'OVER'>
			</cfif>
			
			<cfif GetTotals.total lt GetOu.ou> 
				<cfset OUWinner = 'UNDER'>
			</cfif>		

			<cfif OUWinner neq 'PUSH'>
				<cfif evaluate('GetPriorDayPicks.#mysys#') is OUWinner>
					<cfquery datasource="NBA" name="Upd">
					Update FinalPicks 
					Set SYS100 = '#OUWinner#' & '-W'
					where Gametime = '#PriorDayStr#'
					and Fav        = '#GetPriorDayPicks.fav#'
					</cfquery>
					
					<cfquery datasource="nba" name="updateit">
					Update SystemRecord
					Set W2012  = #S100Wins + 1#
				  	where SystemNum = 'SYS100'
					</cfquery>
					
					<cfset S100Wins = S100Wins + 1>
					
				<cfelse>
				
					<cfquery datasource="NBA" name="Upd">
					Update FinalPicks 
					Set SYS100 = '#evaluate('GetPriorDayPicks.#mysys#')#' & '-L'
					where Gametime = '#PriorDayStr#'
					and Fav        = '#GetPriorDayPicks.fav#'
					</cfquery>
					
					<cfquery datasource="nba" name="updateit">
					Update SystemRecord
					Set L2012  = #S100Losses + 1#
				  	where SystemNum = 'SYS100'
					</cfquery>
				
					<cfset S100Losses = S100Losses + 1>
				
				
				</cfif>
			
			<cfelse>
				<cfquery datasource="NBA" name="Upd">
					Update FinalPicks 
					Set SYS100 = '#OUWinner#' & '-P'
					where Gametime = '#PriorDayStr#'
					and Fav        = '#GetPriorDayPicks.fav#'
				</cfquery>
			
			</cfif>


		</cfif>


	</cfif>

	<cfif S100Losses + S100Wins gt 0>
	<cfquery datasource="nba" name="updateit">
	Update SystemRecord
		Set Pct2012  = #100 * (S100Wins / (S100Losses + S100Wins))# 
	  	where SystemNum = 'SYS100'
	</cfquery>
	</cfif>


	<cfif GetPriorDayPicks.WhoCovered neq 'PUSH'>
	
		<cfset mypick = evaluate('GetPriorDayPicks.#mysys#') >
		
		<cfif mypick gt ''>
			comparing sytem #mysys# mypick of #mypick# to whocovered of #GetPriorDayPicks.WhoCovered#<br>
			<cfif (GetPriorDayPicks.WhoCovered is '#mypick#') or ('**' & '#GetPriorDayPicks.WhoCovered#' is '#mypick#')>
					yes we won!<br>
				
					<cfset myWarry[ii] = myWarry[ii] + 1> 
					<cfset myWin  = myWarry[ii]>
					<cfset myLoss = myLarry[ii]>
					
					<cfif (mywin + myloss) gt 0>
					<cfset mypct = 100*(myWin/(myWin + myLoss))>
					<cfelse>
					<cfset mypct = 0>
					</cfif>
					<cfquery datasource="nba" name="updateit">
					Update SystemRecord
					Set W2012 = #mywin#,
				  		 L2012 = #myLoss#,
					Pct2012 = #mypct#
					where SystemNum = '#mysys#'
					</cfquery>  
					
					
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
					
					<cfquery datasource="nba" name="updateit">
					Update SystemRecord
					Set W2012 = #mywin#,
				  		 L2012 = #myLoss#,
						Pct2012 = #mypct#
					where SystemNum = '#mysys#'
					</cfquery> 
					
			</cfif>
		</cfif>
	</cfif>
</cfloop>
</cfoutput>

<cfquery datasource="Nba" name="GetStatus">
	Insert into NBADataLoadStatus (gametime,StepName)
	values('#GetDay.Gametime#','UpdatedRecord')
</cfquery>


<cfcatch type="any">
  
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.Detail#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:UpdateRecord.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>

</cfcatch>

</cftry>
</cfif>
