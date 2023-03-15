<cfquery datasource="nba" name="DelIt">
Delete from NBAHomeFieldAdv
</cfquery> 

<cfquery datasource="nba" name="GetIt">
Select Team, HomePower + 20 as hmp, AwayPower + 20 as awp, TotalPower + 20 as tp
From HomeAwayPower
</cfquery> 

<cfoutput query="GetIt">																																																		

	<cfset Homestat = (GetIt.hmp - GetIt.awp) / GetIt.tp>
	<cfset HFA = 2.3 + (2.3 * HomeStat)>


	<cfquery datasource="nba" name="Addit">
	INSERT INTO NBAHomeFieldAdv(Team, HFA, HomeFieldWt) VALUES('#GetIt.Team#',#HFA#,#HomeStat#)
	</cfquery>


</cfoutput>

<cfquery datasource="nba" name="GetIt">
Select Fav, Und, Ha 
From NbaSchedule s, NBAGametime gt
Where gt.Gametime = s.Gametime
</cfquery> 

<cfoutput query ="GetIt">

	<cfif Getit.Ha is 'H'>

		<cfquery datasource="nba" name="GetItHome">
		Select Team, HFA As HiddenValHome  
		From NBAHomeFieldAdv
		where Team = '#Getit.Fav#'
		</cfquery> 

		<cfquery datasource="nba" name="GetItAway">
		Select Team, HFA As HiddenValAway  
		From NBAHomeFieldAdv
		where Team = '#Getit.Und#'
		</cfquery> 

		<cfset TotHiddenVal = Getithome.HiddenValHome + Getitaway.HiddenValAway>
				
	<cfelse>	
		
		<cfquery datasource="nba" name="GetItHome">
		Select Team, HFA As HiddenValHome  
		From NBAHomeFieldAdv
		where Team = '#Getit.Und#'
		</cfquery> 

		<cfquery datasource="nba" name="GetItAway">
		Select Team, HFA As HiddenValAway  
		From NBAHomeFieldAdv
		where Team = '#Getit.Fav#'
		</cfquery> 

		<cfset TotHiddenVal = Getithome.HiddenValHome + Getitaway.HiddenValAway>
				
	</cfif>	
		
	
		
		
</cfoutput>		
	<cfquery datasource="Nba" name="UpdStatus">
		Insert into NBADataloadStatus(StepName) values('Finished CreateHFA.cfm')
	</cfquery>