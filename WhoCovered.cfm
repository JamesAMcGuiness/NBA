
<cftry>

<cfquery datasource="NBA" name="GetDay">
Select * 
from Nbagametime
</cfquery>

                
 
<cfquery datasource="nba" name="GetResults"> 
Select * from nbadata 
where gametime = '#GetDay.Gametime#' 
</cfquery> 


<!--- 
<cfquery datasource="nba" name="GetResults"> 
Select * from nbadata 
where gametime = '20140317' 
</cfquery> 
 --->


<cfset toggle = 0> 
<cfloop query="GetResults"> 

        <cfif toggle is 0> 
                <cfset variables.team        = GetResults.Team> 
                <cfset variables.teamps      = GetResults.Ps> 
                <cfset variables.opp         = GetResults.opp> 
                <cfset variables.oppps      = GetResults.dPs> 
                <cfset thegametime          = GetResults.gametime> 

        
                <!--- Get the Matchup info... --->              
                <cfquery datasource="nba" name="GetSpreads1"> 
                Select * from nbaschedule 
                where gametime = '#thegametime#' 
                and fav = '#variables.team#' 
                </cfquery> 
                
                <cfif GetSpreads1.recordcount neq 0> 
                        <cfset myfav = '#variables.team#'> 
                        <cfset myund = '#variables.opp#'> 
                        <cfset myspd = #GetSpreads1.spd#> 
                        <cfset myfavps = variables.teamps> 
                        <cfset myundps = variables.oppps> 
                </cfif> 

        
                <!--- Get the Matchup info... --->              
                <cfquery datasource="nba" name="GetSpreads"> 
                Select * from nbaschedule 
                where gametime = '#thegametime#' 
                and fav = '#variables.opp#' 
                </cfquery> 
                
                <cfif GetSpreads.recordcount neq 0> 
                        <cfset myfav = '#variables.opp#'> 
                        <cfset myund = '#variables.team#'> 
                        <cfset myspd = #GetSpreads.spd#> 
                        <cfset myfavps = variables.oppps> 
                        <cfset myundps = variables.teamps> 
                </cfif> 
        
        		<cfoutput>
				
				#myfav#:#myfavps# vs #myund#:#myundps# vs the spread of #myspd#<br>
				
				</cfoutput>
				
                <!--- Determine who covered... ---> 
                <cfset spreadwinner = 'PUSH'> 
                <cfif (myfavps - myundps) gt myspd> 
						fav covers<br>
                        <cfset spreadwinner = myfav> 
                </cfif> 
        
                <cfif (myfavps - myundps) lt myspd>
						Und covers <br> 
                        <cfset spreadwinner = myund> 
                </cfif> 
        
                <cfif (myfavps lt myundps)>
						Und won staright up<br> 
                        <cfset spreadwinner = myund> 
                </cfif> 
        
		
				<cfquery datasource="nba" name="Findit"> 
                Select * from FinalPicks 
                where gametime = '#thegametime#' 
                and fav = '#myfav#' 
                </cfquery> 
		
                <cfquery datasource="nba" name="Updateit"> 
                Update FinalPicks 
                Set WhoCovered = '#spreadwinner#' 
                where gametime = '#thegametime#' 
                and fav = '#myfav#' 
                </cfquery> 
                
				
				<cfquery datasource="nba" name="Updateit"> 
                Update FinalPicks 
                Set WhoCovered = 'OT' 
                where gametime = '#thegametime#' 
                and fav = '#myfav#' 
				and WhoCovered not in ('#myfav#','#myund#','PUSH')
                </cfquery> 		
				
				
                <cfset toggle = toggle + 1> 
                
				
				<cfquery datasource="nba" name="Updateit"> 
                Update FinalPicks 
                Set ThirtyRatFav = '#myfav#' 
                where gametime = '#thegametime#' 
                and fav = '#myfav#' 
				and FavImpStatpts >= 30
                </cfquery> 

				<cfquery datasource="nba" name="Updateit"> 
                Update FinalPicks 
                Set UndRatBetter = '#myund#' 
                where gametime = '#thegametime#' 
                and fav = '#myfav#' 
				and FavImpStatpts < UndImpStatpts
                </cfquery> 

				
        <cfelse> 
                <cfset toggle = 0> 
        </cfif> 
		

		
</cfloop>       
<cfquery datasource="Nba" name="GetStatus">
	Insert into NBADataLoadStatus (gametime,StepName)
	values('#GetDay.Gametime#','UpdatedWhoCovered')
</cfquery>


<cfcatch type="any">
  
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.Detail#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:WhoCovered.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>

</cfcatch>

</cftry>



