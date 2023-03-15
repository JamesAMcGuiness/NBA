<cfset gametime = Session.GameTime>
<CFSET systemid = 'Power'>

<cfquery datasource="nbaschedule" name="Getspds">
Select *
from nbaschedule
where GameTime = '#gametime#'
</cfquery>

<cfquery datasource="nbapicks" name="Addit">
	Delete from NBAPicks
	where SystemId = '#SystemId#'
	and Gametime = '#Gametime#'
</cfquery>

<cfloop query="GetSpds">

	<cfset fav           = '#GetSpds.Fav#'> 
	<cfset und           = '#GetSpds.Und#'>
	<cfset ha            = '#GetSpds.ha#'>
	<cfset spd           = Getspds.spd>
	
	<cfquery datasource="NBAStats" name="FavPower">
	select team,
	 48*(2*(Avg((ofgm-otpm)/(ofga-otpa))*Avg((ofga-otpa) / (mins/5))) - 2*(Avg((dfgm-dtpm)/(dfga-dtpa))*Avg((dfga-dtpa) / (dmin/5)))) + (3*(Avg(otpm/otpa) * Avg(otpa /(mins/5))) - 3*(Avg(dtpm/dtpa) * Avg(dtpa /(dmin/5)))) + (Avg(oftm/ofta)*Avg(ofta/(mins/5)) - Avg(dftm/dfta)*Avg(dfta/(dmin/5))) as power
	from nbadata
	where Team = '#fav#'
	</cfquery>   

	<cfquery datasource="NBAStats" name="UndPower">
	select team,
  		 48*(2*(Avg((ofgm-otpm)/(ofga-otpa))*Avg((ofga-otpa) / (mins/5))) - 2*(Avg((dfgm-dtpm)/(dfga-dtpa))*Avg((dfga-dtpa) / (dmin/5)))) + (3*(Avg(otpm/otpa) * Avg(otpa /(mins/5))) - 3*(Avg(dtpm/dtpa) * Avg(dtpa /(dmin/5)))) + (Avg(oftm/ofta)*Avg(ofta/(mins/5)) - Avg(dftm/dfta)*Avg(dfta/(dmin/5))) as power
	from nbadata
	where Team = '#und#'
	</cfquery>   

	<cfset Prediction = FavPower.Power - UndPower.Power>

	<cfif ha is 'H'>
		<cfset Prediction = Prediction + 2.5>
	<cfelse>
		<cfset Prediction = Prediction - 2.5>
	</cfif>
	
	<cfset Pick = '#und#'>
	
	
	<cfif Prediction gt 0>
	fav wins<br>
		<cfif Prediction - spd gt 0>
			<cfset Pick = '#fav#'>
			<cfset Rating = Prediction - spd>
		<cfelse>
			<cfset Pick = '#und#'>
			<cfset Rating = spd - Prediction>
		</cfif>
	<cfelse>
		Underdog to win	<br>
		<cfset Pick = '#und#'>
		<cfset Rating = spd - Prediction>
	</cfif>
	
	<cfoutput>
	Predition is we like #pick# at #spd# with a rating of #Numberformat(rating,999.99)#<br>
	</cfoutput>
	
	<cfquery datasource="nbapicks" name="Addit">
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
		'#Gametime#',
		'#fav#',
		'#ha#',
		#spd#,
		'#und#',
		'#pick#',
		#rating#
		)
	</cfquery>
	
</cfloop>	
