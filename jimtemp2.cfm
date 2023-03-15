
<cftry>

<cfquery datasource="Nba" name="GetRunct">
	Select Gametime
	from NBAGameTime
</cfquery>

<cfset myGameTime = GetRunct.GameTime>


<cfoutput>
<cfquery datasource="NBA" name="AddPicks">
Delete from NBAPicks where gametime = '#mygametime#'
and systemid = 'MATRIX'
</cfquery>


<cfquery datasource="nba" name="AddPicks">
Delete from PredictedStats where gametime = '#mygametime#'
</cfquery>


</cfoutput>

<cfquery datasource="NBA" name="AddPicks">
Delete from ImportantStatPreds where gametime = '#mygametime#'
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
	<cfset spd           = #GetSpds.spd#>
	<cfset myou          = #GetSpds.ou#>  
	<cfset overct        = 0>

	<cfquery datasource="nba" name="getPIP">
	Select f.PIPRat - u.PIPRat as adv
	from PIP f, PIP u
	WHERE f.Team = '#GetSpds.Fav#'
	AND u.Team = '#GetSpds.Und#'
	</cfquery>
	
	<cfset pipadv = 'EVEN'>
	<cfif getPIP.adv gt 0>
		<cfset pipadv='#GetSpds.Fav#'>
	</cfif>
	<cfif getPIP.adv lt 0>
		<cfset pipadv='#GetSpds.UND#'>
	</cfif>
		
	<cfquery datasource="nba" name="getit1">
	Insert into ImportantStatPreds
	(Fav,
	spd,
	Und,
	ha,
	gametime,
	PIPADV)
	values
	(
	'#fav#',
	'#spd#',
	'#und#',
	'#ha#',
	'#mygametime#',
	'#pipADV#'
	)
	</cfquery>
	
	<cfset UndHa = 'H'>
	<cfset favha = ha>
	
	<cfif ha is 'H'>
		<cfset UndHa = 'A'>
	</cfif>

<cfquery datasource="nba" name="getit1">
Select ops as aops
from Matrix m
where m.team = '#fav#' 
and m.OPP = '#und#'
and m.ha='#favHa#'
</cfquery>

<cfset sum1 = 0>
<cfset sum2 = 0>
<cfset sum3 = 0>
<cfset sum4 = 0>



<cfoutput query="getit1">
<!-- #fav#: #Getit1.aops#<br>  -->
<cfset sum1 = sum1 + #Getit1.aops# >
</cfoutput>

<hr>


<cfquery datasource="nba" name="getit2">
Select ops as aops
from Matrix m
where m.team = '#und#' 
and m.OPP = '#fav#'
and m.ha='#undha#'
</cfquery>

<cfoutput query="getit2">
<!-- #und#: #Getit2.aops#<br> -->
<cfset sum2 = sum2 + #Getit2.aops# >
</cfoutput>

<hr>


<cfquery datasource="nba" name="getit3">
Select dps as adps
from Matrixdps m
where m.team = '#fav#' 
and m.OPP = '#und#'
and m.ha='#favHa#'
</cfquery>

<cfoutput query="getit3">
<!-- #Fav# pts against: #Getit3.adps#<br> -->
<cfset sum3 = sum3 + #Getit3.adps# >
</cfoutput>

<hr>


<cfquery datasource="nba" name="getit4">
Select dps as adps
from Matrixdps m
where m.team = '#und#' 
and m.OPP = '#fav#'
and m.ha='#undhA#'
</cfquery>

<cfoutput query="getit4">
<!-- #Und# pts against: #Getit4.adps#<br> -->
<cfset sum4 = sum4 + #Getit4.adps# >
</cfoutput>


<cfset s1recct = Getit1.Recordcount>
<cfset s2recct = Getit2.Recordcount>
<cfset s3recct = Getit3.Recordcount>
<cfset s4recct = Getit4.Recordcount>

<cfoutput>
<cfset skip = false>	
<cfif s1recct neq 0 and s2recct neq 0 and s3recct neq 0 and s4recct neq 0>
	
	#fav# : #((sum1/s1recct) + (Sum4/s4recct))/2#<br>
	#und# : #((sum2/s2recct) + (Sum3/s3recct))/2#<br>
	<cfset sc1 = ((sum1/s1recct) + (Sum4/s4recct))/2 - ((sum2/s2recct) + (Sum3/s3recct))/2>
	Prediction #fav# by #sc1#
<cfelse>
	<cfset skip = true>	
	Not enough data
</cfif>
</cfoutput>

<cfif skip is false>
<cfquery name="addit" datasource="nba">
Insert into PredictedStats
(Gametime, Fav, Spd, ha, und, favscore, undscore,ou,ourspd,ourtotal)
Values('#mygametime#','#fav#','#spd#','#ha#','#und#',#((sum1/s1recct) + (Sum4/s4recct))/2#,#((sum2/s2recct) + (Sum3/s3recct))/2#,#myou#,#sc1#,#((sum1/s1recct) + (Sum4/s4recct))/2 + ((sum2/s2recct) + (Sum3/s3recct))/2#)
</cfquery>
</cfif>

</cfloop>


<cfquery datasource="nba" name="Getspds">
Select *
from nbaschedule
where GameTime = '#mygametime#'
 </cfquery>


<cfloop query="GetSpds">
	<cfset fav           = '#GetSpds.Fav#'> 
	<cfset und           = '#GetSpds.Und#'>
	<cfset ha            = '#GetSpds.ha#'>
	<cfset spd           = #GetSpds.spd#>
	<cfset myou          = #GetSpds.ou#>  
	<cfset overct        = 0>

	<cfset UndHa = 'H'>
	<cfset favha = ha>
	
	<cfif ha is 'H'>
		<cfset UndHa = 'A'>
	</cfif>

<cfquery datasource="nba" name="getit1">
Select oreb as aops
from Matrixreb m
where m.team = '#fav#' 
and m.OPP = '#und#'
and m.ha='#favHa#'
</cfquery>

<cfset sum1 = 0>
<cfset sum2 = 0>
<cfset sum3 = 0>
<cfset sum4 = 0>



<cfquery datasource="nba" name="getit2">
Select oreb as aops
from Matrixreb m
where m.team = '#und#' 
and m.OPP = '#fav#'
and m.ha='#undha#'
</cfquery>

<cfquery datasource="nba" name="getit3">
Select dreb as adps
from Matrixdreb m
where m.team = '#fav#' 
and m.OPP = '#und#'
and m.ha='#favHa#'
</cfquery>

<cfquery datasource="nba" name="getit4">
Select dreb as adps
from Matrixdreb m
where m.team = '#und#' 
and m.OPP = '#fav#'
and m.ha='#undhA#'
</cfquery>





<cfquery datasource="nba" name="getit1">
Select oPIP as aops
from MatrixPIP m
where m.team = '#fav#' 
and m.OPP = '#und#'
and m.ha='#favHa#'
</cfquery>

<cfset sum1 = 0>
<cfset sum2 = 0>
<cfset sum3 = 0>
<cfset sum4 = 0>
<cfset Gamect = 0>


<cfquery datasource="nba" name="getit2">
Select oPIP as aops
from MatrixPIP m
where m.team = '#und#' 
and m.OPP = '#fav#'
and m.ha='#undha#'
</cfquery>

<cfquery datasource="nba" name="getit3">
Select dPIP as adps
from MatrixdPIP m
where m.team = '#fav#' 
and m.OPP = '#und#'
and m.ha='#favHa#'
</cfquery>

<cfquery datasource="nba" name="getit4">
Select dPIP as adps
from MatrixdPIP m
where m.team = '#und#' 
and m.OPP = '#fav#'
and m.ha='#undhA#'
</cfquery>

<cfset s1recct = Getit1.Recordcount>
<cfset s2recct = Getit2.Recordcount>
<cfset s3recct = Getit3.Recordcount>
<cfset s4recct = Getit4.Recordcount>



<cfoutput query="getit1">
<!-- #fav#: #Getit1.aops#<br>  -->
<cfset sum1 = sum1 + #Getit1.aops# >
</cfoutput>


<cfoutput query="getit2">
<!-- #fav#: #Getit1.aops#<br>  -->
<cfset sum2 = sum2 + #Getit2.aops# >
</cfoutput>


<cfoutput query="getit3">
<!-- #fav#: #Getit1.aops#<br>  -->
<cfset sum3 = sum3 + #Getit3.adps# >
</cfoutput>

<cfoutput query="getit4">
<!-- #fav#: #Getit1.aops#<br>  -->
<cfset sum4 = sum4 + #Getit4.adps# >
</cfoutput>


<cfset skip = false>

<cfif s1recct neq 0 and s2recct neq 0 and s3recct neq 0 and s4recct neq 0>
	
	#fav# PIP : #((sum1/s1recct) + (Sum4/s4recct))/2#<br>
	#und# PIP: #((sum2/s2recct) + (Sum3/s3recct))/2#<br>
	<cfset sc1 = ((sum1/s1recct) + (Sum4/s4recct))/2 - ((sum2/s2recct) + (Sum3/s3recct))/2>
	Prediction #fav# PIP by #sc1#
	
	<cfif sc1 gt 0 >
		<cfset mypick = '#fav#'>
	</cfif>

	<cfif sc1 lt 0 >
		<cfset mypick = '#und#'>
	</cfif>

<cfelse>
	Not enough data
	<cfset skip = true>
	<cfset mypick = 'Pass'>
</cfif>


<cfquery datasource="nba" >
Update FinalPicks
Set PIPPick    = '#mypick#'
Where Fav      = '#fav#'
and   Gametime = '#mygametime#'
</cfquery>



</cfloop>




















<cfquery datasource="nba" name="Getspds">
Select *
from nbaschedule
where GameTime = '#mygametime#'
 </cfquery>

<cfloop query="GetSpds">
	<cfset fav           = '#GetSpds.Fav#'> 
	<cfset und           = '#GetSpds.Und#'>
	<cfset ha            = '#GetSpds.ha#'>
	<cfset spd           = #GetSpds.spd#>
	<cfset myou          = #GetSpds.ou#>  
	<cfset overct        = 0>
	
	<cfset UndHa = 'H'>
	<cfset favha = ha>
	
	<cfif ha is 'H'>
		<cfset UndHa = 'A'>
	</cfif>

<cfquery datasource="nba" name="getit1">
Select ops as aops
from Matrix m
where m.team = '#fav#' 
and m.OPP = '#und#'
and m.ha='#favHa#'
</cfquery>

<cfset sum1 = 0>
<cfset sum2 = 0>
<cfset sum3 = 0>
<cfset sum4 = 0>



<cfquery datasource="nba" name="getit2">
Select ops as aops
from Matrix m
where m.team = '#und#' 
and m.OPP = '#fav#'
and m.ha='#undha#'
</cfquery>

<cfquery datasource="nba" name="getit3">
Select dps as adps
from Matrixdps m
where m.team = '#fav#' 
and m.OPP = '#und#'
and m.ha='#favHa#'
</cfquery>

<cfquery datasource="nba" name="getit4">
Select dps as adps
from Matrixdps m
where m.team = '#und#' 
and m.OPP = '#fav#'
and m.ha='#undhA#'
</cfquery>

<cfset s1recct = Getit1.Recordcount>
<cfset s2recct = Getit2.Recordcount>
<cfset s3recct = Getit3.Recordcount>
<cfset s4recct = Getit4.Recordcount>

<cfset favcov = 0>
<cfset undcov = 0>
<cfset gamect = 0>

<cfset favarry = Arraynew(1)>
<cfset Undarry = Arraynew(1)>

<cfset FavGamect = 0>
<cfset UndGamect = 0>


<cfset rg1to3     = 0>
<cfset rg4to6     = 0>
<cfset rg7to9     = 0>
<cfset rg10ormore = 0>

<!-- Add 1 and 4 -->
<cfloop query="Getit1">
	<cfset cmp1 = Getit1.aops>
	<cfloop query="Getit4">
		<cfset cmp2 = Getit4.adps> 
		<cfset favgamect = favgamect + 1>
		
		<cfset favarry[favgamect] = (cmp1 + cmp2)/2>
		<!--- <cfoutput>
		Comparing #cmp1# to #cmp2#<br> 
		</cfoutput> --->
 </cfloop> 
</cfloop>


<!-- Add 2 and 3 -->
<cfloop query="Getit2">
	<cfset cmp1 = Getit2.aops>
	<cfloop query="Getit3">
			<cfset cmp2 = Getit3.adps> 
		<cfset undgamect = undgamect + 1>
		
		<cfset undarry[undgamect] = (cmp1 + cmp2)/2>
		<!--- <cfoutput>
		Comparing #cmp1# to #cmp2#<br> 
		</cfoutput> --->
	</cfloop>
</cfloop>

<!-- Comapare the results -->
<cfset maxloop = UndGameCt>
<cfif Favgamect le UndGamect>
	<cfset maxloop = FavGameCt>
</cfif>

<cfset gamect = 0>
<cfset totpts = 0>

<cfset rg1to3     = 0>
<cfset rg4to6     = 0>
<cfset rg7to9     = 0>
<cfset rg10ormore = 0>

<cfset urg1to3     = 0>
<cfset urg4to6     = 0>
<cfset urg7to9     = 0>
<cfset urg10ormore = 0>
<cfset overct = 0>

<cfloop index="ii" from="1" to="#maxloop#">


	<cfset gamect = gamect + 1>
	<cfoutput>
	<!-- Comparing #favarry[ii]# to #UndArry[ii]#<br> -->
	</cfoutput>
	<cfif (favarry[ii] - UndArry[ii]) ge #spd#>
		<cfset favcov = favcov + 1>
		<!-- Fav Covers!<br> -->
	<cfelse>
		<cfset undcov = undcov + 1>
	</cfif>
	
	<cfset totpts = totpts + (favarry[ii] + UndArry[ii])>

	<cfset diff = #numberformat(favarry[ii] - UndArry[ii],'99.999')#>
	
	<cfif diff ge .000001 and diff le 3.9999>
		<cfset rg1to3 = rg1to3 + 1> 
	</cfif>

	<cfif diff ge 4 and diff le 6.9999>
		<cfset rg4to6 = rg4to6 + 1> 
	</cfif>

	<cfif diff ge 7 and diff le 9.9999>
		<cfset rg7to9 = rg7to9 + 1> 
	</cfif>

	<cfif diff ge 10>
		<cfset rg10ormore = rg10ormore + 1> 
	</cfif>

	<cfif diff le 0 and diff ge -3.9999>
		<cfset urg1to3 = urg1to3 + 1>
		
	<cfelseif diff le -4 and diff ge -6.9999>
		<cfset urg4to6 = urg4to6 + 1> 
		
	<cfelseif diff le -7 and diff ge -9.9999>
		<cfset urg7to9 = urg7to9 + 1> 
		
	<cfelseif diff le -10>
		<cfset urg10ormore = urg10ormore + 1> 
	</cfif>


	<cfif (favarry[ii] + UndArry[ii]) ge ou>
		<cfset overct = overct + 1>
	</cfif>

	
</cfloop>
<hr>

<cfif gamect gt 0>
<cfset WhoCovers = ''>
<cfif Favcov gt UndCov>
	<cfset CoversPct = (favcov/gamect)*100>
	<cfset WhoCovers = '#fav#'>

	<cfoutput>
	#Fav# better by (1-3) #(rg1to3/favcov)*100#<br>
	#Fav# better by (4-6) #(rg4to6/favcov)*100#<br>
	#Fav# better by (7-9) #(rg7to9/favcov)*100#<br>
	#Fav# better by (10+) #(rg10ormore/favcov)*100#<br>
	</cfoutput>
<cfelse>
		<cfset WhoCovers = '#und#'>
		<cfset CoversPct = (Undcov/gamect)*100>
	<cfoutput>
	#Und# better by (1-3) #(urg1to3/undcov)*100#<br>
	#Und# better by (4-6) #(urg4to6/undcov)*100#<br>
	#Und# better by (7-9) #(urg7to9/undcov)*100#<br>
	#Und# better by (10+) #(urg10ormore/undcov)*100#<br>
	</cfoutput>

</cfif>

<cfquery datasource="nba" >
Update ImportantStatPreds
Set WhoCovers  = '#whocovers#',
CoversPct      = #CoversPct#
Where Fav      = '#fav#'
and   Gametime = '#mygametime#'
</cfquery>


<hr>


<cfif (favcov/gamect)*100 gt 50>
	<cfset ourpick = fav>
	<cfset ourrat = (favcov/gamect)*100>
		
		<cfif (favcov/gamect)*100 gt 59>
			<cfset ourpick = '**#fav#'>
		</cfif>

	<cfoutput>
	=================================================> #Fav# predicted cover of -#spd# against #und# is #(favcov/gamect)*100# for #gamect# of games, Avg total pts is #numberformat(totpts/gamect,'999.9')#<br>
	</cfoutput>


	<cfquery datasource="NBA" name="AddPicks">
	Insert into NBAPicks
	(GameTime,
	Fav,
	Ha,
	Spd,
	Und,
	Pick,
	Pct,
	Systemid
	)
	values
	(
	'#mygametime#',
	'#fav#',
	'#ha#',
	#spd#,
	'#und#',
	'#ourpick#',
	#ourrat#,
	'MATRIX'
	)
	</cfquery>





<cfelse>

	<cfset ourpick = und>
	<cfset ourrat = (undcov/gamect)*100>
		
		<cfif (undcov/gamect)*100 gt 59>
			<cfset ourpick = '**#und#'>
		</cfif>

		
			<cfquery datasource="NBA" name="AddPicks">
	Insert into NBAPicks
	(GameTime,
	Fav,
	Ha,
	Spd,
	Und,
	Pick,
	Pct,
	Systemid
	)
	values
	(
	'#mygametime#',
	'#fav#',
	'#ha#',
	#spd#,
	'#und#',
	'#ourpick#',
	#ourrat#,
	'MATRIX'
	)
	</cfquery>

		

<cfoutput>
=================================================> #Und# predicted cover of +#spd# against #fav# is #(undcov/gamect)*100# for #gamect# of games, Avg total pts is #numberformat(totpts/gamect,'999.9')#<br>
</cfoutput>

</cfif>
</cfif>
</cfloop>






















































<hr>
FGPCT<br>
<cfloop query="GetSpds">
	<cfset fav           = '#GetSpds.Fav#'> 
	<cfset und           = '#GetSpds.Und#'>
	<cfset ha            = '#GetSpds.ha#'>
	<cfset spd           = #GetSpds.spd#>
	<cfset myou          = #GetSpds.ou#>  
	<cfset overct        = 0>
	
	<cfset UndHa = 'H'>
	<cfset favha = ha>
	
	<cfif ha is 'H'>
		<cfset UndHa = 'A'>
	</cfif>

<cfquery datasource="nba" name="getit1">
Select ofgpct as aops
from Matrixfgpct m
where m.team = '#fav#' 
and m.OPP = '#und#'
and m.ha='#favHa#'
</cfquery>

<cfset sum1 = 0>
<cfset sum2 = 0>
<cfset sum3 = 0>
<cfset sum4 = 0>



<cfoutput query="getit1">
<!-- #fav#: #Getit1.aops#<br>  -->
<cfset sum1 = sum1 + #Getit1.aops# >
</cfoutput>

<cfquery datasource="nba" name="getit2">
Select ofgpct as aops
from Matrixfgpct m
where m.team = '#und#' 
and m.OPP = '#fav#'
and m.ha='#undha#'
</cfquery>

<cfoutput query="getit2">
<!-- #und#: #Getit2.aops#<br> -->
<cfset sum2 = sum2 + #Getit2.aops# >
</cfoutput>

<cfquery datasource="nba" name="getit3">
Select dfgpct as adps
from Matrixdfgpct m
where m.team = '#fav#' 
and m.OPP = '#und#'
and m.ha='#favHa#'
</cfquery>

<cfoutput query="getit3">
<!-- #Fav# pts against: #Getit3.adps#<br> -->
<cfset sum3 = sum3 + #Getit3.adps# >
</cfoutput>

<cfquery datasource="nba" name="getit4">
Select dfgpct as adps
from Matrixdfgpct m
where m.team = '#und#' 
and m.OPP = '#fav#'
and m.ha='#undhA#'
</cfquery>

<cfoutput query="getit4">
<!-- #Und# pts against: #Getit4.adps#<br> -->
<cfset sum4 = sum4 + #Getit4.adps# >
</cfoutput>


<cfset s1recct = Getit1.Recordcount>
<cfset s2recct = Getit2.Recordcount>
<cfset s3recct = Getit3.Recordcount>
<cfset s4recct = Getit4.Recordcount>

<cfset skip = false>
<cfoutput>
<cfif s1recct neq 0 and s2recct neq 0 and s3recct neq 0 and s4recct neq 0>
	
	#fav# FGPCT : #((sum1/s1recct) + (Sum4/s4recct))/2#<br>
	#und# FGPCT: #((sum2/s2recct) + (Sum3/s3recct))/2#<br>
	<cfset sc1 = ((sum1/s1recct) + (Sum4/s4recct))/2 - ((sum2/s2recct) + (Sum3/s3recct))/2>
	Prediction #fav# by #sc1#
<cfelse>
	Not enough data
	<cfset skip = true>
</cfif>
</cfoutput>
<hr>
<cfif skip is false>
<cfquery name="updateit" datasource="nba">
Update PredictedStats
set FavFG = #((sum1/s1recct) + (Sum4/s4recct))/2#,
UndFG = #((sum2/s2recct) + (Sum3/s3recct))/2#
where gametime = '#mygametime#'
and fav = '#fav#'
</cfquery>
</cfif>

</cfloop>


<hr>
<p>

<cfquery datasource="NBA" name="Getspds">
Select *
from nbaschedule
where GameTime = '#mygametime#'
 </cfquery>

<cfloop query="GetSpds">
	<cfset fav           = '#GetSpds.Fav#'> 
	<cfset und           = '#GetSpds.Und#'>
	<cfset ha            = '#GetSpds.ha#'>
	<cfset spd           = #GetSpds.spd#>
	<cfset myou          = #GetSpds.ou#>  
	<cfset overct        = 0>
	
	<cfset UndHa = 'H'>
	<cfset favha = ha>
	
	<cfif ha is 'H'>
		<cfset UndHa = 'A'>
	</cfif>

<cfquery datasource="nba" name="getit1">
Select ofgpct as aops
from Matrixfgpct m
where m.team = '#fav#' 
and m.OPP = '#und#'
and m.ha='#favHa#'
</cfquery>

<cfset sum1 = 0>
<cfset sum2 = 0>
<cfset sum3 = 0>
<cfset sum4 = 0>



<cfquery datasource="nba" name="getit2">
Select ofgpct as aops
from Matrixfgpct m
where m.team = '#und#' 
and m.OPP = '#fav#'
and m.ha='#undha#'
</cfquery>

<cfquery datasource="nba" name="getit3">
Select dfgpct as adps
from Matrixdfgpct m
where m.team = '#fav#' 
and m.OPP = '#und#'
and m.ha='#favHa#'
</cfquery>

<cfquery datasource="nba" name="getit4">
Select dfgpct as adps
from Matrixdfgpct m
where m.team = '#und#' 
and m.OPP = '#fav#'
and m.ha='#undhA#'
</cfquery>

<cfset s1recct = Getit1.Recordcount>
<cfset s2recct = Getit2.Recordcount>
<cfset s3recct = Getit3.Recordcount>
<cfset s4recct = Getit4.Recordcount>

<cfset favcov = 0>
<cfset undcov = 0>
<cfset gamect = 0>

<cfset favarry = Arraynew(1)>
<cfset Undarry = Arraynew(1)>

<cfset FavGamect = 0>
<cfset UndGamect = 0>

<!-- Add 1 and 4 -->
<cfloop query="Getit1">
	<cfset cmp1 = Getit1.aops>
	<cfloop query="Getit4">
			<cfset cmp2 = Getit4.adps> 
		<cfset favgamect = favgamect + 1>
		
		<cfset favarry[favgamect] = (cmp1 + cmp2)/2>
		<!--- <cfoutput>
		Comparing #cmp1# to #cmp2#<br> 
		</cfoutput> --->
 </cfloop> 
</cfloop>


<!-- Add 2 and 3 -->
<cfloop query="Getit2">
	<cfset cmp1 = Getit2.aops>
	<cfloop query="Getit3">
			<cfset cmp2 = Getit3.adps> 
		<cfset undgamect = undgamect + 1>
		
		<cfset undarry[undgamect] = (cmp1 + cmp2)/2>
		<!--- <cfoutput>
		Comparing #cmp1# to #cmp2#<br> 
		</cfoutput> --->
	</cfloop>
</cfloop>

<!-- Comapare the results -->
<cfset maxloop = UndGameCt>
<cfif Favgamect le UndGamect>
	<cfset maxloop = FavGameCt>
</cfif>

<cfset rg1to3     = 0>
<cfset rg4to6     = 0>
<cfset rg7to9     = 0>
<cfset rg10ormore = 0>

<cfset urg1to3     = 0>
<cfset urg4to6     = 0>
<cfset urg7to9     = 0>
<cfset urg10ormore = 0>



<cfset gamect = 0>
<cfset totpts = 0>
<cfloop index="ii" from="1" to="#maxloop#">
	<cfset gamect = gamect + 1>
	<cfoutput>
	<!-- Comparing #favarry[ii]# to #UndArry[ii]#<br> -->
	</cfoutput>
	<cfif (favarry[ii] gt UndArry[ii])>
		<cfset favcov = favcov + 1>
		<!-- Fav Covers!<br> -->
	<cfelse>
		<cfset undcov = undcov + 1>
	</cfif>
	
	<cfset totpts = totpts + (favarry[ii] + UndArry[ii])>
	<cfset diff = #numberformat(favarry[ii] - UndArry[ii],'99.999')#>
	
	<cfif diff ge .000001 and diff le 3.9999>
		<cfset rg1to3 = rg1to3 + 1> 
	</cfif>

	<cfif diff ge 4 and diff le 6.9999>
		<cfset rg4to6 = rg4to6 + 1> 
	</cfif>

	<cfif diff ge 7 and diff le 9.9999>
		<cfset rg7to9 = rg7to9 + 1> 
	</cfif>

	<cfif diff ge 10>
		<cfset rg10ormore = rg10ormore + 1> 
	</cfif>

	<cfif diff le 0 and diff ge -3.9999>
		<cfset urg1to3 = urg1to3 + 1>
		
	<cfelseif diff le -4 and diff ge -6.9999>
		<cfset urg4to6 = urg4to6 + 1> 
		
	<cfelseif diff le -7 and diff ge -9.9999>
		<cfset urg7to9 = urg7to9 + 1> 
		
	<cfelseif diff le -10>
		<cfset urg10ormore = urg10ormore + 1> 
	</cfif>

	
</cfloop>
<hr>
<cfif gamect neq 0>
<cfset myfgpct60 = false>

<cfif (favcov/gamect)*100 ge 60 or (undcov/gamect)*100 ge 60>
	<cfset myfgpct60 = true>
</cfif>


<cfif (favcov/gamect)*100 gt 50>
	<cfset myFGPctAdv = '#fav#'>
<cfoutput>
=================================================> #Fav# predicted FGPCT adv against #und# is #(favcov/gamect)*100# for #gamect# of games, Avg total pts is #numberformat(totpts/gamect,'999.9')#<br>
</cfoutput>

<cfelse>
	<cfset myFGPctAdv = '#und#'>
<cfoutput>
=================================================> #Und# predicted FGPCT adv against #fav# is #(undcov/gamect)*100# for #gamect# of games, Avg total pts is #numberformat(totpts/gamect,'999.9')#<br>
</cfoutput>

</cfif>

<cfif Favcov gt Undcov>
<hr>
<cfoutput>
#Fav# better FGpct by (1-3) #(rg1to3/favcov)*100#<br>
#Fav# better FGpct by (4-6) #(rg4to6/favcov)*100#<br>
#Fav# better FGpct by (7-9) #(rg7to9/favcov)*100#<br>
#Fav# better FGpct by (10+) #(rg10ormore/favcov)*100#<br>

<cfset myBigFGpct = 100 - ((rg1to3/favcov)*100)>
</cfoutput>
<hr>
<cfelse>
<hr>
<cfoutput>
#und# better FGpct by (1-3) #(urg1to3/undcov)*100#<br>
#und# better FGpct by (4-6) #(urg4to6/undcov)*100#<br>
#und# better FGpct by (7-9) #(urg7to9/undcov)*100#<br>
#und# better FGpct by (10+) #(urg10ormore/undcov)*100#<br>

<cfset myBigFGpct = 100 - ((urg1to3/undcov)*100)>
</cfoutput>
<hr>
</cfif>


<cfquery datasource="nba" >
Update ImportantStatPreds
Set FGPctAdv   = '#myfgpctadv#',
FGPct60        = #myfgpct60#,
FGPctBig       = #mybigfgpct#
Where Fav      = '#fav#'
and   Gametime = '#mygametime#'
</cfquery>

</cfif>

</cfloop>





































<cfloop query="GetSpds">
	<cfset fav           = '#GetSpds.Fav#'> 
	<cfset und           = '#GetSpds.Und#'>
	<cfset ha            = '#GetSpds.ha#'>
	<cfset spd           = #GetSpds.spd#>
	<cfset myou          = #GetSpds.ou#>  
	<cfset overct        = 0>
	
	<cfset UndHa = 'H'>
	<cfset favha = ha>
	
	<cfif ha is 'H'>
		<cfset UndHa = 'A'>
	</cfif>

<cfquery datasource="nba" name="getit1">
Select oreb as aops
from Matrixreb m
where m.team = '#fav#' 
and m.OPP = '#und#'
and m.ha='#favHa#'
</cfquery>

<cfset sum1 = 0>
<cfset sum2 = 0>
<cfset sum3 = 0>
<cfset sum4 = 0>



<cfquery datasource="nba" name="getit2">
Select oreb as aops
from Matrixreb m
where m.team = '#und#' 
and m.OPP = '#fav#'
and m.ha='#undha#'
</cfquery>

<cfquery datasource="nba" name="getit3">
Select dreb as adps
from Matrixdreb m
where m.team = '#fav#' 
and m.OPP = '#und#'
and m.ha='#favHa#'
</cfquery>

<cfquery datasource="nba" name="getit4">
Select dreb as adps
from Matrixdreb m
where m.team = '#und#' 
and m.OPP = '#fav#'
and m.ha='#undhA#'
</cfquery>

<cfset s1recct = Getit1.Recordcount>
<cfset s2recct = Getit2.Recordcount>
<cfset s3recct = Getit3.Recordcount>
<cfset s4recct = Getit4.Recordcount>

<cfoutput query="getit1">
<!-- #fav#: #Getit1.aops#<br>  -->
<cfset sum1 = sum1 + #Getit1.aops# >
</cfoutput>


<cfoutput query="getit2">
<!-- #fav#: #Getit1.aops#<br>  -->
<cfset sum2 = sum2 + #Getit2.aops# >
</cfoutput>


<cfoutput query="getit3">
<!-- #fav#: #Getit1.aops#<br>  -->
<cfset sum3 = sum3 + #Getit3.adps# >
</cfoutput>

<cfoutput query="getit4">
<!-- #fav#: #Getit1.aops#<br>  -->
<cfset sum4 = sum4 + #Getit4.adps# >
</cfoutput>


<cfset skip = false>
<cfoutput>
<cfif s1recct neq 0 and s2recct neq 0 and s3recct neq 0 and s4recct neq 0>
	
	#fav# REB : #((sum1/s1recct) + (Sum4/s4recct))/2#<br>
	#und# REB: #((sum2/s2recct) + (Sum3/s3recct))/2#<br>
	<cfset sc1 = ((sum1/s1recct) + (Sum4/s4recct))/2 - ((sum2/s2recct) + (Sum3/s3recct))/2>
	Prediction #fav# REB by #sc1#
<cfelse>
	Not enough data
	<cfset skip = true>
</cfif>
</cfoutput>

<cfif skip is false>
<cfquery name="updateit" datasource="nba">
Update PredictedStats
set FavREB = #((sum1/s1recct) + (Sum4/s4recct))/2#,
UndREB = #((sum2/s2recct) + (Sum3/s3recct))/2#
where gametime = '#mygametime#'
and fav = '#fav#'
</cfquery>
</cfif>


<cfset favcov = 0>
<cfset undcov = 0>
<cfset gamect = 0>

<cfset favarry = Arraynew(1)>
<cfset Undarry = Arraynew(1)>

<cfset FavGamect = 0>
<cfset UndGamect = 0>

<!-- Add 1 and 4 -->
<cfloop query="Getit1">
	<cfset cmp1 = Getit1.aops>
	<cfloop query="Getit4">
			<cfset cmp2 = Getit4.adps> 
		<cfset favgamect = favgamect + 1>
		
		<cfset favarry[favgamect] = (cmp1 + cmp2)/2>
		<!--- <cfoutput>
		Comparing #cmp1# to #cmp2#<br> 
		</cfoutput> --->
 </cfloop> 
</cfloop>


<!-- Add 2 and 3 -->
<cfloop query="Getit2">
	<cfset cmp1 = Getit2.aops>
	<cfloop query="Getit3">
			<cfset cmp2 = Getit3.adps> 
		<cfset undgamect = undgamect + 1>
		
		<cfset undarry[undgamect] = (cmp1 + cmp2)/2>
		<!--- <cfoutput>
		Comparing #cmp1# to #cmp2#<br> 
		</cfoutput> --->
	</cfloop>
</cfloop>

<!-- Comapare the results -->
<cfset maxloop = UndGameCt>
<cfif Favgamect le UndGamect>
	<cfset maxloop = FavGameCt>
</cfif>

<cfset rg1to3     = 0>
<cfset rg4to6     = 0>
<cfset rg7to9     = 0>
<cfset rg10ormore = 0>

<cfset urg1to3     = 0>
<cfset urg4to6     = 0>
<cfset urg7to9     = 0>
<cfset urg10ormore = 0>



<cfset gamect = 0>
<cfset totpts = 0>
<cfloop index="ii" from="1" to="#maxloop#">
	<cfset gamect = gamect + 1>
	<cfoutput>
	<!-- Comparing #favarry[ii]# to #UndArry[ii]#<br> -->
	</cfoutput>
	<cfif (favarry[ii] gt UndArry[ii])>
		<cfset favcov = favcov + 1>
		<!-- Fav Covers!<br> -->
	<cfelse>
		<cfset undcov = undcov + 1>
	</cfif>
	
	<cfset totpts = totpts + (favarry[ii] + UndArry[ii])>
	<cfset diff = #numberformat(favarry[ii] - UndArry[ii],'99.999')#>
	
	<cfif diff ge .000001 and diff le 3.9999>
		<cfset rg1to3 = rg1to3 + 1> 
	</cfif>

	<cfif diff ge 4 and diff le 6.9999>
		<cfset rg4to6 = rg4to6 + 1> 
	</cfif>

	<cfif diff ge 7 and diff le 9.9999>
		<cfset rg7to9 = rg7to9 + 1> 
	</cfif>

	<cfif diff ge 10>
		<cfset rg10ormore = rg10ormore + 1> 
	</cfif>

	<cfif diff le 0 and diff ge -3.9999>
		<cfset urg1to3 = urg1to3 + 1>
		
	<cfelseif diff le -4 and diff ge -6.9999>
		<cfset urg4to6 = urg4to6 + 1> 
		
	<cfelseif diff le -7 and diff ge -9.9999>
		<cfset urg7to9 = urg7to9 + 1> 
		
	<cfelseif diff le -10>
		<cfset urg10ormore = urg10ormore + 1> 
	</cfif>


	
</cfloop>

<cfset myreb60 = false>

<cfif gamect neq 0>
<cfif (favcov/gamect)*100 ge 60 or (undcov/gamect)*100 ge 60>
	<cfset myreb60 = true>
</cfif>


<cfif (favcov/gamect)*100 gt 50>
	<cfset myrebAdv = '#fav#'>
<cfoutput>
=================================================> #Fav# predicted REB adv against #und# is #(favcov/gamect)*100# for #gamect# of games, Avg total pts is #numberformat(totpts/gamect,'999.9')#<br>
</cfoutput>

<cfelse>
	<cfset myRebAdv = '#und#'>
<cfoutput>
=================================================> #Und# predicted REB adv against #fav# is #(undcov/gamect)*100# for #gamect# of games, Avg total pts is #numberformat(totpts/gamect,'999.9')#<br>
</cfoutput>

</cfif>

<cfif Favcov gt Undcov>
<hr>
<cfoutput>
#Fav# better REB by (1-3) #(rg1to3/favcov)*100#<br>
#Fav# better REB by (4-6) #(rg4to6/favcov)*100#<br>
#Fav# better REB by (7-9) #(rg7to9/favcov)*100#<br>
#Fav# better REB by (10+) #(rg10ormore/favcov)*100#<br>

<cfset myBigReb = 100 - ((rg1to3/favcov)*100)>
</cfoutput>
<hr>
<cfelse>
<hr>
<cfoutput>
#und# better REB by (1-3) #(urg1to3/undcov)*100#<br>
#und# better REB by (4-6) #(urg4to6/undcov)*100#<br>
#und# better REB by (7-9) #(urg7to9/undcov)*100#<br>
#und# better REB by (10+) #(urg10ormore/undcov)*100#<br>

<cfset myBigReb = 100 - ((urg1to3/undcov)*100)>
</cfoutput>
<hr>
</cfif>


<cfquery datasource="nba" >
Update ImportantStatPreds
Set RebAdv   = '#myRebadv#',
Reb60        = #myReb60#,
RebBig       = #myBigReb#
Where Fav      = '#fav#'
and   Gametime = '#mygametime#'
</cfquery>
</cfif>
</cfloop>









<cfloop query="GetSpds">
	<cfset fav           = '#GetSpds.Fav#'> 
	<cfset und           = '#GetSpds.Und#'>
	<cfset ha            = '#GetSpds.ha#'>
	<cfset spd           = #GetSpds.spd#>
	<cfset myou          = #GetSpds.ou#>  
	<cfset overct        = 0>
	
	<cfset UndHa = 'H'>
	<cfset favha = ha>
	
	<cfif ha is 'H'>
		<cfset UndHa = 'A'>
	</cfif>

<cfquery datasource="nba" name="getit1">
Select otpm as aops
from Matrixtpm m
where m.team = '#fav#' 
and m.OPP = '#und#'
and m.ha='#favHa#'
</cfquery>

<cfset sum1 = 0>
<cfset sum2 = 0>
<cfset sum3 = 0>
<cfset sum4 = 0>



<cfquery datasource="nba" name="getit2">
Select otpm as aops
from Matrixtpm m
where m.team = '#und#' 
and m.OPP = '#fav#'
and m.ha='#undha#'
</cfquery>

<cfquery datasource="nba" name="getit3">
Select dtpm as adps
from Matrixdtpm m
where m.team = '#fav#' 
and m.OPP = '#und#'
and m.ha='#favHa#'
</cfquery>

<cfquery datasource="nba" name="getit4">
Select dtpm as adps
from Matrixdtpm m
where m.team = '#und#' 
and m.OPP = '#fav#'
and m.ha='#undhA#'
</cfquery>

<cfset s1recct = Getit1.Recordcount>
<cfset s2recct = Getit2.Recordcount>
<cfset s3recct = Getit3.Recordcount>
<cfset s4recct = Getit4.Recordcount>

<cfoutput query="getit1">
<!-- #fav#: #Getit1.aops#<br>  -->
<cfset sum1 = sum1 + #Getit1.aops# >
</cfoutput>


<cfoutput query="getit2">
<!-- #fav#: #Getit1.aops#<br>  -->
<cfset sum2 = sum2 + #Getit2.aops# >
</cfoutput>


<cfoutput query="getit3">
<!-- #fav#: #Getit1.aops#<br>  -->
<cfset sum3 = sum3 + #Getit3.adps# >
</cfoutput>

<cfoutput query="getit4">
<!-- #fav#: #Getit1.aops#<br>  -->
<cfset sum4 = sum4 + #Getit4.adps# >
</cfoutput>


<cfset skip = false>
<cfoutput>
<cfif s1recct neq 0 and s2recct neq 0 and s3recct neq 0 and s4recct neq 0>
	
	#fav# TPM : #((sum1/s1recct) + (Sum4/s4recct))/2#<br>
	#und# TPM: #((sum2/s2recct) + (Sum3/s3recct))/2#<br>
	<cfset sc1 = ((sum1/s1recct) + (Sum4/s4recct))/2 - ((sum2/s2recct) + (Sum3/s3recct))/2>
	Prediction #fav# TPM by #sc1#
<cfelse>
	<cfset skip = true>
	Not enough data
</cfif>
</cfoutput>

<cfif skip is false>
<cfquery name="updateit" datasource="nba">
Update PredictedStats
set FavTPM = #((sum1/s1recct) + (Sum4/s4recct))/2#,
UndTPM = #((sum2/s2recct) + (Sum3/s3recct))/2#
where gametime = '#mygametime#'
and fav = '#fav#'
</cfquery>
</cfif>

<cfset favcov = 0>
<cfset undcov = 0>
<cfset gamect = 0>

<cfset favarry = Arraynew(1)>
<cfset Undarry = Arraynew(1)>

<cfset FavGamect = 0>
<cfset UndGamect = 0>

<!-- Add 1 and 4 -->
<cfloop query="Getit1">
	<cfset cmp1 = Getit1.aops>
	<cfloop query="Getit4">
			<cfset cmp2 = Getit4.adps> 
		<cfset favgamect = favgamect + 1>
		
		<cfset favarry[favgamect] = (cmp1 + cmp2)/2>
		<!--- <cfoutput>
		Comparing #cmp1# to #cmp2#<br> 
		</cfoutput> --->
 </cfloop> 
</cfloop>


<!-- Add 2 and 3 -->
<cfloop query="Getit2">
	<cfset cmp1 = Getit2.aops>
	<cfloop query="Getit3">
			<cfset cmp2 = Getit3.adps> 
		<cfset undgamect = undgamect + 1>
		
		<cfset undarry[undgamect] = (cmp1 + cmp2)/2>
		<!--- <cfoutput>
		Comparing #cmp1# to #cmp2#<br> 
		</cfoutput> --->
	</cfloop>
</cfloop>

<!-- Comapare the results -->
<cfset maxloop = UndGameCt>
<cfif Favgamect le UndGamect>
	<cfset maxloop = FavGameCt>
</cfif>

<cfset rg1to3     = 0>
<cfset rg4to6     = 0>
<cfset rg7to9     = 0>
<cfset rg10ormore = 0>

<cfset urg1to3     = 0>
<cfset urg4to6     = 0>
<cfset urg7to9     = 0>
<cfset urg10ormore = 0>


<cfset gamect = 0>
<cfset totpts = 0>
<cfset winct = 0>

<cfloop index="ii" from="1" to="#maxloop#">
	<cfset gamect = gamect + 1>
	<cfoutput>
	<!-- Comparing #favarry[ii]# to #UndArry[ii]#<br> -->
	</cfoutput>
	<cfif (favarry[ii] gt UndArry[ii])>
		<cfset favcov = favcov + 1>
		<cfset winct = winct + 1>
		<!-- Fav Covers!<br> -->
	<cfelse>
		<cfset undcov = undcov + 1>
	</cfif>
	
	<cfset totpts = totpts + (favarry[ii] + UndArry[ii])>
	<cfset diff = #numberformat(favarry[ii] - UndArry[ii],'99.999')#>
	
	<cfif diff ge .000001 and diff le 3.9999>
		<cfset rg1to3 = rg1to3 + 1>
		
	<cfelseif diff ge 4 and diff le 6.9999>
		<cfset rg4to6 = rg4to6 + 1> 
		
	<cfelseif diff ge 7 and diff le 9.9999>
		<cfset rg7to9 = rg7to9 + 1> 
		
	<cfelseif diff ge 10>
		
		<cfset rg10ormore = rg10ormore + 1> 
	</cfif>

	<cfif diff le 0 and diff ge -3.9999>
		<cfset urg1to3 = urg1to3 + 1>
		
	<cfelseif diff le -4 and diff ge -6.9999>
		<cfset urg4to6 = urg4to6 + 1> 
		
	<cfelseif diff le -7 and diff ge -9.9999>
		<cfset urg7to9 = urg7to9 + 1> 
		
	<cfelseif diff le -10>
		<cfset urg10ormore = urg10ormore + 1> 
	</cfif>
	
	
	
	
	
</cfloop>
<hr>
<cfset mytpm60 = false>

<cfif gamect neq 0>

<cfif (favcov/gamect)*100 ge 60 or (undcov/gamect)*100 ge 60>
	<cfset mytpm60 = true>
</cfif>


<cfif (favcov/gamect)*100 gt 50>
	<cfset mytpmAdv = '#fav#'>
<cfoutput>
=================================================> #Fav# predicted TPM adv against #und# is #(favcov/gamect)*100# for #gamect# of games, Avg total pts is #numberformat(totpts/gamect,'999.9')#<br>
</cfoutput>

<cfelse>
	<cfset mytpmAdv = '#und#'>
<cfoutput>
=================================================> #Und# predicted TPM adv against #fav# is #(undcov/gamect)*100# for #gamect# of games, Avg total pts is #numberformat(totpts/gamect,'999.9')#<br>
</cfoutput>

</cfif>

<cfif Favcov gt Undcov>
<hr>
<cfoutput>
#Fav# better TPM by (1-3) #(rg1to3/favcov)*100#<br>
#Fav# better TPM by (4-6) #(rg4to6/favcov)*100#<br>
#Fav# better TPM by (7-9) #(rg7to9/favcov)*100#<br>
#Fav# better TPM by (10+) #(rg10ormore/favcov)*100#<br>

<cfset myBigtpm = 100 - ((rg1to3/favcov)*100)>
</cfoutput>
<hr>
<cfelse>
<hr>
<cfoutput>
#und# better TPM by (1-3) #(urg1to3/undcov)*100#<br>
#und# better TPM by (4-6) #(urg4to6/undcov)*100#<br>
#und# better TPM by (7-9) #(urg7to9/undcov)*100#<br>
#und# better TPM by (10+) #(urg10ormore/undcov)*100#<br>

<cfset myBigtpm = 100 - ((urg1to3/undcov)*100)>
</cfoutput>
<hr>
</cfif>


<cfquery datasource="nba" >
Update ImportantStatPreds
Set tpmAdv   = '#myTpmadv#',
tpm60        = #mytpm60#,
tpmBig       = #myBigtpm#
Where Fav      = '#fav#'
and   Gametime = '#mygametime#'
</cfquery>

</cfif>
</cfloop>










<cfloop query="GetSpds">
	<cfset fav           = '#GetSpds.Fav#'> 
	<cfset und           = '#GetSpds.Und#'>
	<cfset ha            = '#GetSpds.ha#'>
	<cfset spd           = #GetSpds.spd#>
	<cfset myou          = #GetSpds.ou#>  
	<cfset overct        = 0>
	
	<cfset UndHa = 'H'>
	<cfset favha = ha>
	
	<cfif ha is 'H'>
		<cfset UndHa = 'A'>
	</cfif>

<cfquery datasource="nba" name="getit1">
Select oftm as aops
from Matrixftm m
where m.team = '#fav#' 
and m.OPP = '#und#'
and m.ha='#favHa#'
</cfquery>

<cfset sum1 = 0>
<cfset sum2 = 0>
<cfset sum3 = 0>
<cfset sum4 = 0>



<cfquery datasource="nba" name="getit2">
Select oftm as aops
from Matrixftm m
where m.team = '#und#' 
and m.OPP = '#fav#'
and m.ha='#undha#'
</cfquery>

<cfquery datasource="nba" name="getit3">
Select dftm as adps
from Matrixdftm m
where m.team = '#fav#' 
and m.OPP = '#und#'
and m.ha='#favHa#'
</cfquery>

<cfquery datasource="nba" name="getit4">
Select dftm as adps
from Matrixdftm m
where m.team = '#und#' 
and m.OPP = '#fav#'
and m.ha='#undhA#'
</cfquery>

<cfset s1recct = Getit1.Recordcount>
<cfset s2recct = Getit2.Recordcount>
<cfset s3recct = Getit3.Recordcount>
<cfset s4recct = Getit4.Recordcount>

<cfoutput query="getit1">
<!-- #fav#: #Getit1.aops#<br>  -->
<cfset sum1 = sum1 + #Getit1.aops# >
</cfoutput>


<cfoutput query="getit2">
<!-- #fav#: #Getit1.aops#<br>  -->
<cfset sum2 = sum2 + #Getit2.aops# >
</cfoutput>


<cfoutput query="getit3">
<!-- #fav#: #Getit1.aops#<br>  -->
<cfset sum3 = sum3 + #Getit3.adps# >
</cfoutput>

<cfoutput query="getit4">
<!-- #fav#: #Getit1.aops#<br>  -->
<cfset sum4 = sum4 + #Getit4.adps# >
</cfoutput>


<cfset skip = false>
<cfoutput>
<cfif s1recct neq 0 and s2recct neq 0 and s3recct neq 0 and s4recct neq 0>
	
	#fav# FTM : #((sum1/s1recct) + (Sum4/s4recct))/2#<br>
	#und# FTM: #((sum2/s2recct) + (Sum3/s3recct))/2#<br>
	<cfset sc1 = ((sum1/s1recct) + (Sum4/s4recct))/2 - ((sum2/s2recct) + (Sum3/s3recct))/2>
	Prediction #fav# FTM by #sc1#
<cfelse>
	<cfset skip = true>
	Not enough data
</cfif>
</cfoutput>

<cfif skip is false>
<cfquery name="updateit" datasource="nba">
Update PredictedStats
set FavFTM = #((sum1/s1recct) + (Sum4/s4recct))/2#,
UndFTM = #((sum2/s2recct) + (Sum3/s3recct))/2#
where gametime = '#mygametime#'
and fav = '#fav#'
</cfquery>
</cfif>

<cfset favcov = 0>
<cfset undcov = 0>
<cfset gamect = 0>

<cfset favarry = Arraynew(1)>
<cfset Undarry = Arraynew(1)>

<cfset FavGamect = 0>
<cfset UndGamect = 0>

<!-- Add 1 and 4 -->
<cfloop query="Getit1">
	<cfset cmp1 = Getit1.aops>
	<cfloop query="Getit4">
			<cfset cmp2 = Getit4.adps> 
		<cfset favgamect = favgamect + 1>
		
		<cfset favarry[favgamect] = (cmp1 + cmp2)/2>
		<!--- <cfoutput>
		Comparing #cmp1# to #cmp2#<br> 
		</cfoutput> --->
 </cfloop> 
</cfloop>


<!-- Add 2 and 3 -->
<cfloop query="Getit2">
	<cfset cmp1 = Getit2.aops>
	<cfloop query="Getit3">
			<cfset cmp2 = Getit3.adps> 
		<cfset undgamect = undgamect + 1>
		
		<cfset undarry[undgamect] = (cmp1 + cmp2)/2>
		<!--- <cfoutput>
		Comparing #cmp1# to #cmp2#<br> 
		</cfoutput> --->
	</cfloop>
</cfloop>

<!-- Comapare the results -->
<cfset maxloop = UndGameCt>
<cfif Favgamect le UndGamect>
	<cfset maxloop = FavGameCt>
</cfif>

<cfset rg1to3     = 0>
<cfset rg4to6     = 0>
<cfset rg7to9     = 0>
<cfset rg10ormore = 0>

<cfset urg1to3     = 0>
<cfset urg4to6     = 0>
<cfset urg7to9     = 0>
<cfset urg10ormore = 0>


<cfset gamect = 0>
<cfset totpts = 0>
<cfset winct = 0>

<cfloop index="ii" from="1" to="#maxloop#">
	<cfset gamect = gamect + 1>
	<cfoutput>
	<!-- Comparing #favarry[ii]# to #UndArry[ii]#<br> -->
	</cfoutput>
	<cfif (favarry[ii] gt UndArry[ii])>
		<cfset favcov = favcov + 1>
		<cfset winct = winct + 1>
		<!-- Fav Covers!<br> -->
	<cfelse>
		<cfset undcov = undcov + 1>
	</cfif>
	
	<cfset totpts = totpts + (favarry[ii] + UndArry[ii])>
	<cfset diff = #numberformat(favarry[ii] - UndArry[ii],'99.999')#>
	
	<cfif diff ge .000001 and diff le 3.9999>
		<cfset rg1to3 = rg1to3 + 1>
		
	<cfelseif diff ge 4 and diff le 6.9999>
		<cfset rg4to6 = rg4to6 + 1> 
		
	<cfelseif diff ge 7 and diff le 9.9999>
		<cfset rg7to9 = rg7to9 + 1> 
		
	<cfelseif diff ge 10>
		
		<cfset rg10ormore = rg10ormore + 1> 
	</cfif>

	<cfif diff le 0 and diff ge -3.9999>
		<cfset urg1to3 = urg1to3 + 1>
		
	<cfelseif diff le -4 and diff ge -6.9999>
		<cfset urg4to6 = urg4to6 + 1> 
		
	<cfelseif diff le -7 and diff ge -9.9999>
		<cfset urg7to9 = urg7to9 + 1> 
		
	<cfelseif diff le -10>
		<cfset urg10ormore = urg10ormore + 1> 
	</cfif>
	
	
	
	
	
</cfloop>
<hr>
<cfset myftm60 = false>

<cfif gamect neq 0>

<cfif (favcov/gamect)*100 ge 60 or (undcov/gamect)*100 ge 60>
	<cfset myftm60 = true>
</cfif>


<cfif (favcov/gamect)*100 gt 50>
	<cfset myftmAdv = '#fav#'>
<cfoutput>
=================================================> #Fav# predicted FTM adv against #und# is #(favcov/gamect)*100# for #gamect# of games, Avg total pts is #numberformat(totpts/gamect,'999.9')#<br>
</cfoutput>

<cfelse>
	<cfset myftmAdv = '#und#'>
<cfoutput>
=================================================> #Und# predicted FTM adv against #fav# is #(undcov/gamect)*100# for #gamect# of games, Avg total pts is #numberformat(totpts/gamect,'999.9')#<br>
</cfoutput>

</cfif>

<cfif Favcov gt Undcov>
<hr>
<cfoutput>
#Fav# better FTM by (1-3) #(rg1to3/favcov)*100#<br>
#Fav# better FTM by (4-6) #(rg4to6/favcov)*100#<br>
#Fav# better FTM by (7-9) #(rg7to9/favcov)*100#<br>
#Fav# better FTM by (10+) #(rg10ormore/favcov)*100#<br>

<cfset myBigftm = 100 - ((rg1to3/favcov)*100)>
</cfoutput>
<hr>
<cfelse>
<hr>
<cfoutput>
#und# better FTM by (1-3) #(urg1to3/undcov)*100#<br>
#und# better FTM by (4-6) #(urg4to6/undcov)*100#<br>
#und# better FTM by (7-9) #(urg7to9/undcov)*100#<br>
#und# better FTM by (10+) #(urg10ormore/undcov)*100#<br>

<cfset myBigftm = 100 - ((urg1to3/undcov)*100)>
</cfoutput>
<hr>
</cfif>


<cfquery datasource="nba" >
Update ImportantStatPreds
Set ftmAdv   = '#myftmadv#',
ftm60        = #myftm60#,
ftmBig       = #myBigftm#
Where Fav      = '#fav#'
and   Gametime = '#mygametime#'
</cfquery>

</cfif>
</cfloop>























<cfloop query="GetSpds">
	<cfset fav           = '#GetSpds.Fav#'> 
	<cfset und           = '#GetSpds.Und#'>
	<cfset ha            = '#GetSpds.ha#'>
	<cfset spd           = #GetSpds.spd#>
	<cfset myou          = #GetSpds.ou#>  
	<cfset overct        = 0>
	
	<cfset UndHa = 'H'>
	<cfset favha = ha>
	
	<cfif ha is 'H'>
		<cfset UndHa = 'A'>
	</cfif>

<cfquery datasource="nba" name="getit1">
Select oTO as aops
from MatrixTO m
where m.team = '#fav#' 
and m.OPP = '#und#'
and m.ha='#favHa#'
</cfquery>

<cfset sum1 = 0>
<cfset sum2 = 0>
<cfset sum3 = 0>
<cfset sum4 = 0>



<cfquery datasource="nba" name="getit2">
Select oTO as aops
from MatrixTO m
where m.team = '#und#' 
and m.OPP = '#fav#'
and m.ha='#undha#'
</cfquery>

<cfquery datasource="nba" name="getit3">
Select dTO as adps
from MatrixdTO m
where m.team = '#fav#' 
and m.OPP = '#und#'
and m.ha='#favHa#'
</cfquery>

<cfquery datasource="nba" name="getit4">
Select dTO as adps
from MatrixdTO m
where m.team = '#und#' 
and m.OPP = '#fav#'
and m.ha='#undhA#'
</cfquery>

<cfset s1recct = Getit1.Recordcount>
<cfset s2recct = Getit2.Recordcount>
<cfset s3recct = Getit3.Recordcount>
<cfset s4recct = Getit4.Recordcount>

<cfoutput query="getit1">
<!-- #fav#: #Getit1.aops#<br>  -->
<cfset sum1 = sum1 + #Getit1.aops# >
</cfoutput>


<cfoutput query="getit2">
<!-- #fav#: #Getit1.aops#<br>  -->
<cfset sum2 = sum2 + #Getit2.aops# >
</cfoutput>


<cfoutput query="getit3">
<!-- #fav#: #Getit1.aops#<br>  -->
<cfset sum3 = sum3 + #Getit3.adps# >
</cfoutput>

<cfoutput query="getit4">
<!-- #fav#: #Getit1.aops#<br>  -->
<cfset sum4 = sum4 + #Getit4.adps# >
</cfoutput>

<cfset skip = false>
<cfoutput>
<cfif s1recct neq 0 and s2recct neq 0 and s3recct neq 0 and s4recct neq 0>
	
	#fav# TO : #((sum1/s1recct) + (Sum4/s4recct))/2#<br>
	#und# TO : #((sum2/s2recct) + (Sum3/s3recct))/2#<br>
	<cfset sc1 = ((sum1/s1recct) + (Sum4/s4recct))/2 - ((sum2/s2recct) + (Sum3/s3recct))/2>
	Prediction #fav# Turnovers Advantage by #sc1#
<cfelse>
	Not enough data
	<cfset skip = true>
</cfif>
</cfoutput>

<cfif skip is false>
<cfquery name="updateit" datasource="nba">
Update PredictedStats
set FavTO = #((sum1/s1recct) + (Sum4/s4recct))/2#,
UndTO = #((sum2/s2recct) + (Sum3/s3recct))/2#
where gametime = '#mygametime#'
and fav = '#fav#'
</cfquery>
</cfif>


<cfset favcov = 0>
<cfset undcov = 0>
<cfset gamect = 0>

<cfset favarry = Arraynew(1)>
<cfset Undarry = Arraynew(1)>

<cfset FavGamect = 0>
<cfset UndGamect = 0>

<!-- Add 1 and 4 -->
<cfloop query="Getit1">
	<cfset cmp1 = Getit1.aops>
	<cfloop query="Getit4">
			<cfset cmp2 = Getit4.adps> 
		<cfset favgamect = favgamect + 1>
		
		<cfset favarry[favgamect] = (cmp1 + cmp2)/2>
		<!--- <cfoutput>
		Comparing #cmp1# to #cmp2#<br> 
		</cfoutput> --->
 </cfloop> 
</cfloop>


<!-- Add 2 and 3 -->
<cfloop query="Getit2">
	<cfset cmp1 = Getit2.aops>
	<cfloop query="Getit3">
			<cfset cmp2 = Getit3.adps> 
		<cfset undgamect = undgamect + 1>
		
		<cfset undarry[undgamect] = (cmp1 + cmp2)/2>
		<!--- <cfoutput>
		Comparing #cmp1# to #cmp2#<br> 
		</cfoutput> --->
	</cfloop>
</cfloop>

<!-- Comapare the results -->
<cfset maxloop = UndGameCt>
<cfif Favgamect le UndGamect>
	<cfset maxloop = FavGameCt>
</cfif>

<cfset rg1to3     = 0>
<cfset rg4to6     = 0>
<cfset rg7to9     = 0>
<cfset rg10ormore = 0>

<cfset urg1to3     = 0>
<cfset urg4to6     = 0>
<cfset urg7to9     = 0>
<cfset urg10ormore = 0>


<cfset gamect = 0>
<cfset totpts = 0>
<cfset winct = 0>

<cfloop index="ii" from="1" to="#maxloop#">
	<cfset gamect = gamect + 1>
	<cfoutput>
	<!-- Comparing #favarry[ii]# to #UndArry[ii]#<br> -->
	</cfoutput>
	<cfif (favarry[ii] gt UndArry[ii])>
		<cfset favcov = favcov + 1>
		<cfset winct = winct + 1>
		<!-- Fav Covers!<br> -->
	<cfelse>
		<cfset undcov = undcov + 1>
	</cfif>
	
	<cfset totpts = totpts + (favarry[ii] + UndArry[ii])>
	<cfset diff = #numberformat(favarry[ii] - UndArry[ii],'99.999')#>
	
	<cfif diff ge .000001 and diff le 3.9999>
		<cfset rg1to3 = rg1to3 + 1>
		
	<cfelseif diff ge 4 and diff le 6.9999>
		<cfset rg4to6 = rg4to6 + 1> 
		
	<cfelseif diff ge 7 and diff le 9.9999>
		<cfset rg7to9 = rg7to9 + 1> 
		
	<cfelseif diff ge 10>
		
		<cfset rg10ormore = rg10ormore + 1> 
	</cfif>

	<cfif diff le 0 and diff ge -3.9999>
		<cfset urg1to3 = urg1to3 + 1>
		
	<cfelseif diff le -4 and diff ge -6.9999>
		<cfset urg4to6 = urg4to6 + 1> 
		
	<cfelseif diff le -7 and diff ge -9.9999>
		<cfset urg7to9 = urg7to9 + 1> 
		
	<cfelseif diff le -10>
		<cfset urg10ormore = urg10ormore + 1> 
	</cfif>
	
	
	
	
	
</cfloop>
<hr>
<cfset myTO60 = false>


<cfif gamect neq 0>

<cfif (favcov/gamect)*100 ge 60 or (undcov/gamect)*100 ge 60>
	<cfset myTO60 = true>
</cfif>


<cfif (favcov/gamect)*100 gt 50>
	<cfset myTOAdv = '#fav#'>
<cfoutput>
=================================================> #Fav# predicted TO adv against #und# is #(favcov/gamect)*100# for #gamect# of games, Avg total pts is #numberformat(totpts/gamect,'999.9')#<br>
</cfoutput>

<cfelse>
	<cfset myTOAdv = '#und#'>
<cfoutput>
=================================================> #Und# predicted TO adv against #fav# is #(undcov/gamect)*100# for #gamect# of games, Avg total pts is #numberformat(totpts/gamect,'999.9')#<br>
</cfoutput>



<cfif Favcov gt Undcov>
<hr>
<cfoutput>
#Fav# better TO by (1-3) #(rg1to3/favcov)*100#<br>
#Fav# better TO by (4-6) #(rg4to6/favcov)*100#<br>
#Fav# better TO by (7-9) #(rg7to9/favcov)*100#<br>
#Fav# better TO by (10+) #(rg10ormore/favcov)*100#<br>

<cfset myBigTO = 100 - ((rg1to3/favcov)*100)>
</cfoutput>
<hr>
<cfelse>
<hr>
<cfoutput>
#und# better TO by (1-3) #(urg1to3/undcov)*100#<br>
#und# better TO by (4-6) #(urg4to6/undcov)*100#<br>
#und# better TO by (7-9) #(urg7to9/undcov)*100#<br>
#und# better TO by (10+) #(urg10ormore/undcov)*100#<br>

<cfset myBigTO = 100 - ((urg1to3/undcov)*100)>
</cfoutput>
<hr>
</cfif>


<cfquery datasource="nba" >
Update ImportantStatPreds
Set TOAdv   = '#myTOadv#',
TO60        = #myTO60#,
TOBig       = #myBigTO#
Where Fav      = '#fav#'
and   Gametime = '#mygametime#'
</cfquery>
</cfif>
</cfif>


</cfloop>

<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('jimtemp2.cfm')
</cfquery>



<cfcatch type="any">
<cfabort showerror="Error!....#cfcatch.Detail#">	
  #cfcatch.Detail#
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.Detail#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:jimtemp2.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>

</cfcatch>

</cftry>
