



<cfquery datasource="nba" name="getinfo">
Select distinct * from finalpicks fp
where gametime in (select gametime from nbagametime)
</cfquery>

<cfoutput query="getinfo">


	<cfquery datasource="nba" name="GetSitFav">
	Select * from TeamSituation
	Where Team = '#GetInfo.fav#'
	and Gametime = '#GetInfo.Gametime#'
	</cfquery>

	<cfquery datasource="nba" name="GetSitUnd">
	Select * from TeamSituation
	Where Team = '#GetInfo.und#'
	and Gametime = '#GetInfo.Gametime#'
	</cfquery>


	<cfloop query="GetSitFav">


		CHECKING NEW SYSTEM FOR FAV: #getsitfav.Team#<br>

	<!--- New system to check
	Go against any Favorite where in their last game they were BEHIND BIG for 25% or more of game
	 --->
		<cfif DownBigPct gte 25>
			
			<!--- Get the uderdog for this game --->
			<cfquery datasource="nba" name="Getund">
			Select Und,spd,gametime from FinalPicks
			Where Fav    = '#GetSitFav.Team#'
			and Gametime = '#GetSitFav.Gametime#'
			</cfquery>
		
			<cfif Getund.spd gte 6>
				Play on #GetUnd.Und# - SYS50<br>
				
				
				
				<cfquery datasource="nba">
				Update FinalPicks
				Set SYS51       = '#GetUnd.Und#'
				Where gametime  = '#Getinfo.gametime#'
				and fav         = '#GetSitFav.Team#'
				</cfquery>
				
			<cfelse>
				Play on #GetUnd.Und# - SYS51<br>
				<cfquery datasource="nba">
				Update FinalPicks
				Set SYS51       = '#GetUnd.Und#'
				Where gametime  = '#Getinfo.gametime#'
				and fav         = '#GetSitFav.Team#'
				</cfquery>
			 
			
			</cfif>
			
			
		</cfif>

	</cfloop>


	<cfloop query="GetSitUnd">
			
	 	CHECKING NEW SYSTEM FOR UND: #getsitund.Team#<br>
	 
	 
		<cfif DownBigPct gte 25>
			
			<!--- Get the fav for this game --->
			<cfquery datasource="nba" name="Getfav">
			Select fav,Und,ha,gametime from FinalPicks
			Where Und    = '#GetSitUnd.Team#'
			and Gametime = '#GetSitUnd.Gametime#'
			</cfquery>
	
			<!--- New system to check
			Play AGAINST underdog who is now HOME, after last game they were down BIG for 25% or more
	 		--->	
			<cfif GetFav.ha is 'A'>
				SYS52 - #GetFav.Fav#<br>
				<cfquery datasource="nba">
				Update FinalPicks
				Set SYS52       = '#GetFav.fav#'
				Where gametime  = '#GetFav.gametime#'
				and fav         = '#GetFav.fav#'
				</cfquery> 
			
			<cfelse>
				SYS53 - #GetSitUnd.Team#<br>
			
				<!--- New system to check
				Play ON underdog who is now AWAY, after last game they were down BIG for 25% or more
	 			--->
			
				<cfquery datasource="nba">
				Update FinalPicks
				Set SYS53       = '#Getfav.und#'
				Where gametime  = '#GetFav.gametime#'
				and fav         = '#GetFav.Fav#'
				</cfquery>
			
			</cfif>
			
			
		</cfif>

	</cfloop>
</cfoutput>
