
<cfquery name="GetTeams" datasource="NBA">
Select Distinct team
from NBAData
</cfquery>


<cfquery name="GetGameTime" datasource="NBA">
Select GameTime
from NBASchedule
</cfquery>

<cfset TheGameTime = GetGameTime.Gametime>
<cfset TheGameTime = '20141122'>

<cfloop query ="GetTeams">

	<cfset theteam = GetTeams.Team>
	<cfoutput>
	Checking #theteam#<br>
	</cfoutput>
	
	<cfquery name="GetRowIds" datasource="NBA">
	Select Id from NBADriveCharts
	Where Team   = '#theteam#'
	and DownBig  = 1
	and Gametime = '#TheGameTime#'
	order by Id
	</cfquery>

	<cfset Start      = 0>
	<cfset Done       = false>
	<cfset comebackct = 0>

	<cfloop query ="GetRowIds">

		<cfif GetRowIds.id gt Start and not Done>

				
			<cfquery name="GetComeBack" datasource="NBA">
			Select * from NBADrivecharts
			Where Team  = '#TheTeam#'
			and HasLead = 1
			and Id > #GetRowIds.id#
			</cfquery>


			
			<cfif GetComeBack.Recordcount gt 0>
				<cfset comebackdate = '#theGametime#'> 
				<cfset comebackct   = comebackct + 1>
				<cfset Start        = GetComeBack.Id>
				<cfoutput>
				********************<br>
				COME BACK AT #start#<br>
				*********************<br>
				</cfoutput>
			<cfelse>
				<cfset Done = true>	
	
			</cfif>


		</cfif>

	</cfloop>

	<cfif comebackct gt 0>
		<cfquery name="addit" datasource="NBA">
		INSERT into GameEffort
		(
		Team,
		GameTime,
		Ha,
		ComeBackCt,
		WonGameFlag
		
		)
		Values
		(
		'#theteam#',
		'#TheGameTime#',
		'ha',
		#comebackct#,
		'Y'
		)

		</cfquery>
		#theteam# came back #comebackct# times from Big deficits
	</cfif> 

</cfloop>
