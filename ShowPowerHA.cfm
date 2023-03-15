<cfinclude template="CreateBetterThanAvgs.cfm">
Get Here1<br>



<cfinclude template="PowerPts.cfm">
Get Here2<br>


<cfinclude template="createpowerpcts.cfm">
Get Here3<br>


<cfquery datasource="Nba" name="GetRunct">
	Select RunCt,Gametime
	from NBAGameTime
</cfquery>

<cfset Gametime = '#GetRunCt.Gametime#'>


<cfquery datasource="Nba" name="GetRunct">
	Delete from Totals
	Where GameTime = '#gametime#'
</cfquery>


Get here4



<cfquery datasource="nba" name="GetIt">
Select Team,AVG(PS) + AVG(DPS) as Power
from Power
where gametime < '#gametime#'
Group by Team
order by AVG(PS) + AVG(DPS) desc
</cfquery>


<cfquery datasource="nba" name="Getspds">
Select *
from nbaschedule
where GameTime = '#GameTime#'
</cfquery>


<cfloop query="GetSpds">

    <cfset fav           = '#GetSpds.Fav#'>
    <cfset und           = '#GetSpds.Und#'>
    <cfset ha            = '#GetSpds.ha#'>
    <cfset spd           = Getspds.spd>

	
	<cfset PredFavTotPts = (GetSpds.ou / 2) + (val(spd)/2)>/2>
	<cfset PredUndTotPts = (GetSpds.ou / 2) - (val(spd)/2)>/2>
		
	<cfif ha is 'H'>
		<cfset FavHa = 'H'>
		<cfset UndHa = 'A'>
		
		<cfquery datasource="NBA" name="GetFavPowPct">
		Select hpsOver as PSOverPct, hdpsOver as DPSOverPct
		from PowerPcts 
		where team = '#fav#'
		</cfquery>

		<cfquery datasource="NBA" name="GetUndPowPct">
		Select apsOver as PSOverPct, adpsOver as DPSOverPct
		from PowerPcts 
		where team = '#und#'
		</cfquery>
		
	<cfelse>
		<cfset FavHa = 'A'>
		<cfset UndHa = 'H'>
		
		<cfquery datasource="NBA" name="GetFavPowPct">
		Select apsOver as PSOverPct, adpsOver as DPSOverPct
		from PowerPcts 
		where team = '#fav#'
		</cfquery>

		<cfquery datasource="NBA" name="GetUndPowPct">
		Select hpsOver as PSOverPct, hdpsOver as DPSOverPct
		from PowerPcts 
		where team = '#und#'
		</cfquery>
		
	</cfif>	
	

<cfquery datasource="NBA" name="GetUndHAPowDif">
Select hapowerdif
from HomeAwayPower 
where team = '#und#'
</cfquery>
	
	
<cfquery datasource="NBA" name="GetFavHAPowDif">
Select hapowerdif
from HomeAwayPower 
where team = '#fav#'
</cfquery>

<cfquery datasource="NBA" name="GetUndHAPowDif">
Select hapowerdif
from HomeAwayPower 
where team = '#und#'
</cfquery>
	
	
<cfquery datasource="NBA" name="GetFavPowT">
Select hpowertotal, apowertotal, ha
from Power 
where team = '#fav#'
</cfquery>






<cfif 1 is 2>

<cfquery datasource="NBA" name="GetUndPowT">
Select hpowertotal, apowertotal, ha
from Power 
where team = '#und#'
</cfquery>

	<cfset favhct = 0>
	<cfset favact = 0>
	<cfset undhct = 0>
	<cfset undact = 0>
	<cfset favoverct = 0>
	<cfset undoverct = 0>
	<cfset favunderct = 0>
	<cfset undunderct = 0>


<cfloop query="GetFavPowT">
		
	<cfif ha is 'H'>
		<cfset favhct = favhct + 1>
	
		<cfif GetFavPowT.hPowerTotal gte 5>
			<cfset favoverct = favoverct + 1>
		</cfif>

	<cfelse>
		<cfset favact = favact + 1>
	
		<cfif GetFavPowT.aPowerTotal lte -5>
			<cfset favunderct = favunderct + 1>
		</cfif>
	</cfif>	
		
</cfloop>		
		
	
<cfloop query="GetUndPowT">
		
	
		
	<cfif ha is 'H'>
		<cfset undhct = undhct + 1>
	
		<cfif GetUndPowT.hPowerTotal gte 5>
			<cfset undoverct = undoverct + 1>
		</cfif>

	<cfelse>
		<cfset undact = undact + 1>
	
		<cfif GetUndPowT.aPowerTotal lte -5>
			<cfset undunderct = undunderct + 1>
		</cfif>
	</cfif>	
		
</cfloop>		
	

<cfset OverFlag = 'N'>
<cfset UnderFlag = 'N'>


<cfif favha is 'H'>

	<cfif GetFavHAPowDif.hapowerdif lte 0>
		<cfset favweight = ((-1)*GetFavHAPowDif.hapowerdif) + GetUndHAPowDif.hapowerdif>
	<cfelse>
		<cfset favweight = ((1)*GetFavHAPowDif.hapowerdif) + GetUndHAPowDif.hapowerdif>
	</cfif>	

<cfoutput>
Favorite #fav# is HOME<br>
Fav weighted Power based on Home Vs Away Power is #favweight#<br>
#fav#..Over Rate = #favoverct/favhct#<br>
#fav#..Under Rate = #favunderct/favhct#<br>
#und#..Over Rate = #undoverct/undact#<br>
#und#..Under Rate = #undunderct/undact#<br>
</cfoutput>

<cfif favoverct/favhct gt .50>
	<cfif undoverct/undact gt .50>
		<cfset OverFlag = 'Y'>
	</cfif>
</cfif>

<cfif favunderct/favhct gt .50>
	<cfif undunderct/undact gt .50>
		<cfset UnderFlag = 'Y'>
	</cfif>
</cfif>

<cfquery datasource="NBA" name="Addit">
Insert into Totals (Gametime,Fav,ha,Und,FavOverRate,FavUnderRate,UndOverRate,UndUnderRate,OverLikelyFlag,UnderLikelyFlag) values('#Gametime#','#fav#','#favha#','#und#',#favoverct/favhct#,#favunderct/favhct#,#undoverct/undact#,#undunderct/undact#,'#OverFlag#','#UnderFlag#')
</cfquery>

</cfif>


<cfif favha is 'A'>
	<cfset favweight = ((-1)*GetFavHAPowDif.hapowerdif) - GetUndHAPowDif.hapowerdif>

<cfif favoverct/favact gt .50>
	<cfif undoverct/undhct gt .50>
		<cfset OverFlag = 'Y'>
	</cfif>
</cfif>

<cfif favunderct/favact gt .50>
	<cfif undunderct/undhct gt .50>
		<cfset UnderFlag = 'Y'>
	</cfif>
</cfif>

<cfquery datasource="NBA" name="Addit">
Insert into Totals (Gametime,Fav,ha,Und,FavOverRate,FavUnderRate,UndOverRate,UndUnderRate,OverLikelyFlag,UnderLikelyFlag) values('#gametime#','#fav#','#favha#','#und#',#favoverct/favact#,#favunderct/favact#,#undoverct/undhct#,#undunderct/undhct#,'#OverFlag#','#UnderFlag#')
</cfquery>


</cfif>
	
</cfif>	
	






	

<cfquery datasource="NBA" name="GetFav">
Select AVG(PS) + AVG(DPS) as Power
from Power 
where team = '#fav#'
and ha = '#FavHa#'
</cfquery>

<cfquery datasource="NBA" name="GetUnd">
Select AVG(PS) + AVG(DPS) as Power
from Power 
where team = '#und#'
and ha = '#UndHa#'
</cfquery>


<cfquery datasource="NBA" name="GetFavPts">
Select AVG(PS) as aps, AVG(DPS) as adps
from NbaData 
where team = '#fav#'
and ha = '#favha#'
</cfquery>

<cfquery datasource="NBA" name="GetUndPts">
Select AVG(PS) as aps, AVG(DPS) as adps
from NbaData 
where team = '#und#'
and ha = '#undha#'
</cfquery>

<cfquery datasource="NBA" name="GetFavP">
Select *
from BetterThanAvg 
where team = '#fav#'
</cfquery>

<cfquery datasource="NBA" name="GetUndP">
Select *
from BetterThanAvg 
where team = '#und#'
</cfquery>


<cfoutput>

<cfif GetFavPowPct.psOverPct gte .50 >
	<cfset frate = GetFavPowPct.psOverPct>
	<cfset fdesc = 'OVER'>
<cfelse>
	<cfset fdesc = 'UNDER'>
	<cfset frate = 1 - GetFavPowPct.psOverPct>
</cfif>	

<cfif GetUndPowPct.dpsOverPct gte .50 >
	<cfset frate2 = GetUndPowPct.dpsOverPct>
	<cfset fdesc2 = 'OVER'>
<cfelse>
	<cfset fdesc2 = 'UNDER'>
	<cfset frate2 = 1 - GetUndPowPct.dpsOverPct>
</cfif>	


<cfif GetUndPowPct.psOverPct gte .50 >
	<cfset urate = GetUndPowPct.psOverPct>
	<cfset udesc = 'OVER'>
<cfelse>
	<cfset udesc = 'UNDER'>
	<cfset urate = 1 - GetUndPowPct.psOverPct>
</cfif>	

<cfif GetFavPowPct.dpsOverPct gte .50 >
	<cfset urate2 = GetFavPowPct.dpsOverPct>
	<cfset udesc2 = 'OVER'>
<cfelse>
	<cfset udesc2 = 'UNDER'>
	<cfset urate2 = 1 - GetFavPowPct.dpsOverPct>
</cfif>	


</cfoutput>

<cfset ptsdif = GetFavP.PowerPts - GetUndP.PowerPts>
<cfset rebdif = GetFavP.PowerReb - GetUndP.PowerReb>
<cfset Insidedif = GetFavP.PowerInside - GetUndP.PowerInside>
<cfset outsidedif = GetFavP.PowerOutside - GetUndP.PowerOutside>
<cfset todif = GetFavP.PowerTurnover - GetUndP.PowerTurnover>
<cfset fgdif = GetFavP.PowerFGPct - GetUndP.PowerFGPct>

<cfset favpow = #Getfav.Power#>
<cfset undpow = #GetUnd.Power#>

<cfif ha is 'H' >
	<cfset favpow = favpow + 0>
<cfelse>
	<cfset undpow = undpow + 0>
</cfif>

<cfset PredMOV = FavPow - UndPow>



<cfquery datasource="NBA" name="GetFavPY">
Select *
from FinalPicks 
where Fav = '#fav#'
and gametime = '#gametime#'
and FavPlayedYest = 'Y'
</cfquery>

<cfquery datasource="NBA" name="GetUndPY">
Select *
from FinalPicks 
where Fav = '#fav#'
and gametime = '#gametime#'
and UndPlayedYest = 'Y'
</cfquery>

<cfset Pick = 'N/A'>
<cfset PickRat = 0>

<cfif GetFavPY.recordcount gt 0 AND GetUndPY.recordcount gt 0>

<cfelse>

	<cfif GetFavPY.recordcount gt 0>
		<cfset PredMOV = PredMOV - 2.5>
	</cfif>

	<cfif GetUndPY.recordcount gt 0>
		<cfset PredMOV = PredMOV + 2.5>
	</cfif>
</cfif>

<cfif PredMov - spd gt 0>
	<cfset pick = fav>
	<cfset PickRat = PredMov - spd>
</cfif>

<cfif PredMov - spd lt 0>
	<cfset pick = und>
	<cfset PickRat = PredMov + spd>
</cfif>

<cfif PredMov lt spd>
	<cfset pick = und>
	<cfset PickRat = spd - PredMov>
</cfif>



<cfif PickRat gte 4.0>
	<cfset Pick = '#Pick#*'>
</cfif>

	<cfif 1 is 2>
	<cfquery datasource="NBA" name="GetUndPY">
	Update FinalPicks 
	SET SYS500 = '#Pick#'
	where Fav = '#fav#'
	and gametime = '#gametime#'
	</cfquery>
	</cfif>

</cfloop>

<cfquery datasource="NBA" name="GetFav">
Delete from HomeAwayPower
</cfquery>

<cfquery datasource="NBA" name="GetFav">
Select ph.Team,AVG(ph.PS) + AVG(ph.DPS) as Powerh,AVG(pa.PS) + AVG(pa.DPS) as PowerA, AVG(ph.PS) - AVG(ph.DPS) as hPowerTotal,AVG(pa.PS) - AVG(pa.DPS) as aPowerTotal 
from Power ph, Power pa 
where pa.Team = ph.Team
and ph.ha = 'H'
and pa.ha = 'A'
Group By ph.Team
</cfquery>

<cfoutput query="GetFav">
<cfquery datasource="NBA" name="Addit">
Insert Into HomeAwayPower(Team,HomePower,AwayPower,HAPowerDif,hPowerTotal,aPowerTotal) values('#Team#',#Powerh#,#Powera#,#powerh - powera#,#hpowertotal#,#aPowerTotal#)
</cfquery>
</cfoutput>

<cfquery datasource="NBA" name="Addit">
Update HomeAwayPower
set OverallPowerTotal = hpowertotal + aPowerTotal
</cfquery>


<cfquery datasource="NBA" name="xAddit">
Update HomeAwayPower
set TotalPower = (homepower + awaypower)/2
</cfquery>






<cfinclude template="PowerRatingPicks.cfm">





<cfquery datasource="NBA" name="Updateit">
Select p.*, fp.Whocovered as wc
from NBAPicks p, FinalPicks fp 
Where p.PickRating >= 1 
and p.Gametime = fp.gametime
and p.fav = fp.fav
and fp.WhoCovered <> 'PUSH'
and fp.WhoCovered <> ''
</cfquery>

<cfset win = 0>
<cfset totgames = Updateit.recordcount>
<cfloop query="UpdateIt">

	<cfif Updateit.Wc is Updateit.Pick>
		<cfset wl = 1>
		<cfset win = win + 1>
	<cfelse>
		<cfif Updateit.Wc neq 'PUSH'>
		<cfset wl = 0>
		</cfif>
	</cfif>

<cfquery datasource="NBA" name="Updateit2">
UPDATE NBAPicks 
SET Whocovered = '#UpdateIt.Wc#',
Won = #wl# 
Where PickRating >= 1 
and Gametime = '#UpdateIt.gametime#'
and fav = '#UpdateIt.fav#'
</cfquery>

</cfloop>
	
<cfquery datasource="NBA" name="Updateit2">
UPDATE SystemRecord 
SET W2012 = #win#,
	L2012 = #totgames - win#
Where SystemNum = 'SYS102' 
</cfquery>

<cfquery datasource="NBA" name="Updateit2">
UPDATE SystemRecord 
SET Pct2012 = w2012/(w2012+L2012)
Where SystemNum = 'SYS102' 
</cfquery>

<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('RanShowPowerHA.cfm')
</cfquery>

<cfquery datasource="Nba" name="UpdStatus">
	Insert into NBADataloadStatus(StepName) values('SuccessfulRunForPowerRatingWithHealth-SYS102.')
</cfquery>

