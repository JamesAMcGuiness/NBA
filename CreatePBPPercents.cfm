<cfif 1 is 2>
<cftry>

<cfquery datasource="nba" name="Addit">
Delete from PBPPercents
</cfquery>

<cfset myUserCFC = createObject("component", "PSP2012.NFL.FORMS.User") />
<cfset myPBPCFC = createObject("component", "NBAPBP") />


 
<cfquery datasource="nba" name="GetTeams">
Select Distinct Team from NBAData
</cfquery>


<cfloop query="GetTeams">


<cfset FavDCOff  = myPBPCFC.getDriveInfo('O','#GetTeams.Team#')>

<cfquery datasource="nba" name="Addit">
Insert into PBPPercents(Team,OffDef,turnoverPct,ftaPct,InsidePct,OutsidePct,
MadeInsidePct,MadeNormalPct,MadeOutsidePct,PerimeterShotPct)
values('#GetTeams.Team#','O',#FavDCOff.turnoverPct#,#FavDCOff.ftaPct#
,#FavDCOff.InsidePct#,#FavDCOff.OutsidePct#,#FavDCOff.MakeInsidePct#,#FavDCOff.MakeNormalPct#,#FavDCOff.MakeOutsidePct#,#FavDCOff.PerimeterPct#
)
</cfquery>

<cfset UndDCOff  = myPBPCFC.getDriveInfo('D','#GetTeams.Team#')>

<cfquery datasource="nba" name="Addit">
Insert into PBPPercents(Team,OffDef,turnoverPct,ftaPct,InsidePct,OutsidePct,
MadeInsidePct,MadeNormalPct,MadeOutsidePct,PerimeterShotPct)
values('#GetTeams.Team#','D',#undDCOff.turnoverPct#,#undDCOff.ftaPct#
,#undDCOff.InsidePct#,#undDCOff.OutsidePct#,#undDCOff.MakeInsidePct#,#undDCOff.MakeNormalPct#,#undDCOff.MakeOutsidePct#,#UndDCOff.PerimeterPct#
)

</cfquery>

</cfloop>


<!--- Now figure out whst teams are rated Good and Bad at inside play --->
<cfquery datasource="nba" name="Getit">
Select o.team,(o.InsidePct + o.MadeInsidePct + o.FTAPct) as oInside, (d.InsidePct + d.MadeInsidePct + d.FTAPct) as dInside  
from PBPPercents o, PBPPercents d
Where o.OffDef = 'O'
and d.OffDef   = 'D'
and o.Team = d.Team
</cfquery>

<cfoutput query="GetIt">
	<cfset totrat = 0>
	<cfset Good = false>
	<cfset Bad = false>
	<cfset totrat = Getit.oInside - Getit.dInside>
	
	<cfif (Getit.oInside - Getit.dInside) gte 6>
		<cfset Good = true>
	</cfif>

	<cfif (Getit.oInside - Getit.dInside) lte -6>
		<cfset Bad = true>
	</cfif>

	<cfif Good is true>
		<cfquery datasource="nba" name="updit">
		Update PBPPercents
		Set GoodInsideTeam = 'Y'
		Where Team = '#Getit.Team#' 
		</cfquery>
	</cfif>


	<cfif Bad is true>
		<cfquery datasource="nba" name="updit">
		Update PBPPercents
		Set BadInsideTeam = 'Y'
		Where Team = '#Getit.Team#' 
		</cfquery>
	</cfif>

	<cfquery datasource="nba" name="updit">
		Update PBPPercents
		Set OverallInsideRating = #totrat#
		Where Team = '#Getit.Team#' 
	</cfquery>


</cfoutput>

<cfquery datasource="Nba" name="UPDATE">
	Insert into NBADataLoadStatus
	(
	ProgramName
	)
	values
	(
	'CreatePBPPercents.cfm'
	)
</cfquery>



<cfcatch type="any">
  
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.Detail#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:CreatePBPPercents.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>

</cfcatch>

</cftry>
</cfif>