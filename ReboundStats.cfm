<cfquery  datasource="nba" name="GetIt">
	Select 
	  Team,	
	  Avg(OffReb + DefReb) as totReb  

 	from Power 
	Group by Team
	order by Avg(OffReb + DefReb) desc
	</cfquery>
	
	<cfoutput query="Getit">
	#Team#...#totreb#<br>
	
	
	</cfoutput>
