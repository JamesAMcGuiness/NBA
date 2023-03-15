<cftry>

<cfset SystemId        = 'CommonOpp'>

<cfquery datasource="Nba" name="GetRunct">
	Select RunCt,Gametime
	from NBAGameTime
</cfquery>

<cfset mygametime = Getrunct.gametime>

<cfquery datasource="nba" name="Addit">
	Delete from NBAPicks
	where SystemId = '#SystemId#'
	and Gametime = '#myGametime#'
</cfquery>

<cfquery datasource="nba" name="Getspds">
Select *
from nbaschedule
where GameTime = '#mygametime#'
</cfquery>

<cfloop query="GetSpds">

	<cfset fav           = '#GetSpds.Fav#'> 
	<cfset und           = '#GetSpds.Und#'>
	<cfset ha            = '#GetSpds.ha#'>
	<cfset Client.spread = #GetSpds.spd#>

	
	<cfquery  datasource="nba" name="GetAdv">
	Select 
	  
       Avg(f.PS - u.ps) as FavOffAdv,
	   Avg(U.DPS - f.DPS) as FavDefAdv,
	   (Avg(f.PS - u.ps) + Avg(U.DPS - f.DPS)) as FavAdv
 	from nbadata f, nbadata u
  	where f.opp = u.opp
	and   f.Team = '#fav#'
	and   u.Team = '#und#'
	and   f.GameTime < '#myGameTime#'
	and   u.GameTime < '#myGameTime#'
	</cfquery>



	<cfif GetAdv.FavOffadv neq '' and GetAdv.FavDefAdv neq ''>
	<cfoutput query="GetAdv">
	#FavOffadv#,#FavDefAdv#,#FavAdv#<br>
	</cfoutput>
	________________________________________________________________________
	
	
		<cfif Ha is 'H'>
			<cfset PredFavScore = #GetAdv.FavAdv# + 2.5>
			
		<cfelse>
			<cfset PredFavScore = #GetAdv.FavAdv# - 2.5>
		</cfif>	
			
		<cfset PredMOV = PredFavScore>
						
		<cfif PredMOV gt #Client.spread#>
				<cfset Pick = fav>
				<cfset Rating = PredMOV - Client.spread>
		<cfelse>
			<cfif PredMOV lt 0>
				<cfset Pick = und>
				<cfset Rating = Client.spread - PredMOV>
			<cfelse>
				<cfset Pick = und>
				<cfset Rating = Client.spread - PredMOV>
			</cfif>
		</cfif>
			
		<cfoutput>Pick for #fav# vs. #und# is #pick# with rating of #Rating#<br></cfoutput>
	
	<cfquery datasource="nba" name="Addit">
		Insert into NBAPicks
		(
		SystemId,
		Gametime,
		Fav,
		Ha,
		Spd,
		Und,
		Pick,
		Pct)
		Values
		(
		'#SystemId#',
		'#MYGametime#',
		'#fav#',
		'#HA#',
		#Client.spread#,
		'#und#',
		'#pick#',
		#(rating)#
		)
	</cfquery>
	
	<cfset mypick = '#Pick#'>
	<cfif Rating ge 4>
		<cfset mypick = '**#Pick#'>
	</cfif>		

		<cfquery datasource="NBA" name="AddPicks">
		Update FinalPicks
		Set CommonOpp = '#myPick#'
		Where Fav = '#Fav#' 
		and GameTime = '#mygametime#'
		</cfquery>
		

	</cfif>
</cfloop>	

<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('CommonOpponentSys.cfm')
</cfquery>

<cfcatch type="any">
  
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.Detail#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:CommonOpponentSys.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>

</cfcatch>

</cftry>

