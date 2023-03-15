<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>


<cfset StartNum = 0>
<cfset EndNum = 0>
<cfset myGameTime= Session.GameTime>

		
<cfinclude template="CreateAvgs.cfm">		
		
		
<cfquery datasource="nbaschedule" name="Getspds">
Select *
from nbaschedule
where GameTime = '#mygametime#'
 </cfquery>

<cfset TotalGames = Getspds.Recordcount> 
<cfset SystemId   = 'UltimateGameSimHA'>

<cfquery datasource="nbapicks" name="Addit">
	Delete from NBAPicks
	where SystemId = '#SystemId#'
	and Gametime = '#myGametime#'
</cfquery>

<cfloop query="GetSpds">

	<cfset fav           = '#GetSpds.Fav#'> 
	<cfset und           = '#GetSpds.Und#'>
	<cfset ha            = '#GetSpds.ha#'>
	<cfset Client.spread = #GetSpds.spd#>
	<cfset myou          = #GetSpds.ou#>  
	<cfset overct        = 0>
	
	<cfset UndHa = 'H'>
	<cfif ha is 'H'>
		<cfset UndHa = 'A'>
	</cfif>

<cfif ha is 'H'>
		
<cfquery datasource="nbapctsha" name="GetStats">
	Select 
		f.Team,
		
		<!--- Probabilities.. --->
		f.oFGA/(f.ofga     + u.dFGA)   as fFGA,
		f.oFGpct/(f.ofgpct + u.dFGpct) as fFGPCT,
		f.oTPA/(f.oTPA     + u.dTPA)   as fTPA,
		f.oTPpct/(f.oTPpct + u.dTPpct) as fTPPCT,
		f.oFTA/(f.ofTa     + u.dFTA)   as fFTA,

		favg.ohFGA                      as oavgfFGA,
		favg.ohFGpct                    as oavgfFGPCT,
		favg.ohTPA                      as oavgfTPA,
		favg.ohTPpct                    as oavgfTPPCT,
		favg.ohFTA                      as oavgfFTA,
		100*favg.oFTpct                 as oavgfFTpct,
		
		favg.dhFGA                      as davgfFGA,
		favg.dhFGpct                    as davgfFGPCT,
		favg.dhTPA                      as davgfTPA,
		favg.dhTPpct                    as davgfTPPCT,
		favg.dhFTA                      as davgfFTA,

		(favg.ohFGA   + uavg.daFGA)/2            as FPrdFGA,
		100*((favg.ohFGpct + uavg.daFGpct)/2)    as FPrdFGpct,	
		(favg.ohTPA   + uavg.daTPA)/2            as FPrdTPA,		
		100*((favg.ohTPpct + uavg.daTPpct)/2)    as FPrdTPpct,			
		(favg.ohFTA   + uavg.daFTA)/2            as FPrdFTA,
				
		u.oFGA/(u.ofga     + f.dFGA)   as uFGA,
		u.oFGpct/(u.ofgpct + f.dFGpct) as uFGPCT,
		u.oTPA/(u.oTPA     + f.dTPA)   as uTPA,
		u.oTPpct/(u.oTPpct + f.dTPpct) as uTPPCT,
		u.oFTA/(u.ofTa     + f.dFTA)   as uFTA,
				
		uavg.oaFGA                      as oavguFGA,
		uavg.oaFGpct                    as oavguFGPCT,
		uavg.oaTPA                      as oavguTPA,
		uavg.oaTPpct                    as oavguTPPCT,
		uavg.oaFTA                      as oavguFTA,
		100*uavg.oFTpct                 as oavguFTpct,	
				
		uavg.daFGA                      as davguFGA,
		uavg.daFGpct                    as davguFGPCT,
		uavg.daTPA                      as davguTPA,
		uavg.daTPpct                    as davguTPPCT,
		uavg.daFTA                      as davguFTA,
		
		(uavg.oaFGA   + favg.dhFGA)/2            as uPrdFGA,
		100*((uavg.oaFGpct + favg.dhFGpct)/2)    as uPrdFGpct,	
		(uavg.oaTPA   + favg.dhTPA)/2            as uPrdTPA,		
		100*((uavg.oaTPpct + favg.dhTPpct)/2)    as uPrdTPpct,			
		(uavg.oaFTA   + favg.dhFTA)/2            as uPrdFTA
						
				
	from 
		nbapctsha f, 
		nbapctsha u,
		NBAAvgs favg,
		NBAAvgs uavg
		Where f.Team    = '#fav#'
		and   u.Team    = '#Und#'
		and   favg.Team = '#Fav#'
		and   uavg.Team = '#Und#'

</cfquery>

<cfelse>

		
<cfquery datasource="nbapctsha" name="GetStats">
	Select 
		f.Team,
		
		<!--- Probabilities.. --->
		f.oFGA/(f.ofga     + u.dFGA)   as fFGA,
		f.oFGpct/(f.ofgpct + u.dFGpct) as fFGPCT,
		f.oTPA/(f.oTPA     + u.dTPA)   as fTPA,
		f.oTPpct/(f.oTPpct + u.dTPpct) as fTPPCT,
		f.oFTA/(f.ofTa     + u.dFTA)   as fFTA,

		favg.oaFGA                      as oavgfFGA,
		favg.oaFGpct                    as oavgfFGPCT,
		favg.oaTPA                      as oavgfTPA,
		favg.oaTPpct                    as oavgfTPPCT,
		favg.oaFTA                      as oavgfFTA,
		100*favg.oFTpct                 as oavgfFTpct,
		
		favg.daFGA                      as davgfFGA,
		favg.daFGpct                    as davgfFGPCT,
		favg.daTPA                      as davgfTPA,
		favg.daTPpct                    as davgfTPPCT,
		favg.daFTA                      as davgfFTA,

		(favg.oaFGA   + uavg.dhFGA)/2            as FPrdFGA,
		100*((favg.oaFGpct + uavg.dhFGpct)/2)    as FPrdFGpct,	
		(favg.oaTPA   + uavg.dhTPA)/2            as FPrdTPA,		
		100*((favg.oaTPpct + uavg.dhTPpct)/2)    as FPrdTPpct,			
		(favg.oaFTA   + uavg.dhFTA)/2            as FPrdFTA,
				
		u.oFGA/(u.ofga     + f.dFGA)   as uFGA,
		u.oFGpct/(u.ofgpct + f.dFGpct) as uFGPCT,
		u.oTPA/(u.oTPA     + f.dTPA)   as uTPA,
		u.oTPpct/(u.oTPpct + f.dTPpct) as uTPPCT,
		u.oFTA/(u.ofTa     + f.dFTA)   as uFTA,
				
		uavg.ohFGA                      as oavguFGA,
		uavg.ohFGpct                    as oavguFGPCT,
		uavg.ohTPA                      as oavguTPA,
		uavg.ohTPpct                    as oavguTPPCT,
		uavg.ohFTA                      as oavguFTA,
		100*uavg.oFTpct                 as oavguFTpct,	
				
		uavg.dhFGA                      as davguFGA,
		uavg.dhFGpct                    as davguFGPCT,
		uavg.dhTPA                      as davguTPA,
		uavg.dhTPpct                    as davguTPPCT,
		uavg.dhFTA                      as davguFTA,
		
		(uavg.ohFGA   + favg.daFGA)/2            as uPrdFGA,
		100*((uavg.ohFGpct + favg.daFGpct)/2)    as uPrdFGpct,	
		(uavg.ohTPA   + favg.daTPA)/2            as uPrdTPA,		
		100*((uavg.ohTPpct + favg.daTPpct)/2)    as uPrdTPpct,			
		(uavg.ohFTA   + favg.daFTA)/2            as uPrdFTA
						
				
	from 
		nbapctsha f, 
		nbapctsha u,
		NBAAvgs favg,
		NBAAvgs uavg
		Where f.Team    = '#fav#'
		and   u.Team    = '#Und#'
		and   favg.Team = '#Fav#'
		and   uavg.Team = '#Und#'

</cfquery>

</cfif>



<cfset totFav = 0>
<cfset totund=0>
<cfset FavPredScore = arraynew(1)>
<cfset UndPredScore = arraynew(1)>
<cfset mydelta      = arraynew(2)>


<cfset UseOverFTAct = 0>
<cfset UseOverFGAct = 0>
<cfset UseOverFGpctct = 0>
<cfset UseOverTPAct = 0>
<cfset UseOverTPpctct = 0>

<cfloop index="gg" from="1" to="400">

<cfscript>
 Application.objRandom = CreateObject("Component", "Random");
</cfscript>


<!--- Create the variables to use in the Game Simulation --->
<cfset UseOverFGA         = false>
<cfset PredFavFGAProb     = 100*GetStats.fFGA>
<cfset UseOverFGA         = setOverUnderFlags(#PredFavFGAProb#)>

<cfset UseOverFGpct       = false>
<cfset PredFavFGpctProb   = 100*GetStats.fFGpct>
<cfset UseOverFGpct       = setOverUnderFlags(#PredFavFGpctProb#)>

<cfset UseOverTPA         = false>
<cfset PredFavTPAProb     = 100*GetStats.fTPA>
<cfset UseOverTPA         = setOverUnderFlags(PredFavTPAProb)>

<cfset UseOverTPPct       = false>
<cfset PredFavTPpctProb   = 100*GetStats.fTPpct>
<cfset UseOverTPPct       = setOverUnderFlags(PredFavTPpctProb)>

<cfset UseOverFTA         = false>
<cfset PredFavFTAProb     = 100*GetStats.fFTA>
<cfset UseOverFTA         = setOverUnderFlags(PredFavFTAProb)>


<cfif UseOverFGA is true>
	<cfset UseOverFGAct = UseOverFGAct + 1>
</cfif>

<cfif UseOverFGpct is true>
	<cfset UseOverFGpctct = UseOverFGpctct + 1>
</cfif>

<cfif UseOverTPA is true>
	<cfset UseOverTPAct = UseOverTPAct + 1>
</cfif>

<cfif UseOverTPPct is true>
	<cfset UseOverTPPctct = UseOverTPPctct + 1>
</cfif>

<cfif UseOverFTA is true>
	<cfset UseOverFTAct = UseOverFTAct + 1>
</cfif>



<!--- Now based on whether to use OVER stats or UNDER stats, get the actual Over or Under % to apply --->
<cfif #UseOverFGA# is true>

	<cfquery datasource="nbapctsha" name="GetData" cachedWithin="#CreateTimeSpan(0,2,0,0)#">
		Select 
			ooFGAZ1                     as z1,
			ooFGAZ1 + ooFGAZ2           as z2,
			ooFGAZ1 + ooFGAZ2 + ooFGAZ3 as z3 
		from nbapctsha
		Where Team = '#fav#'
	</cfquery>

<cfelse>

	<cfquery datasource="nbapctsha" name="GetData" cachedWithin="#CreateTimeSpan(0,2,0,0)#">
		Select 
			ouFGAZ1                     as z1,
			ouFGAZ1 + ouFGAZ2           as z2,
			ouFGAZ1 + ouFGAZ2 + ouFGAZ3 as z3 
		from nbapctsha
		Where Team = '#fav#'
	</cfquery>

</cfif>


<cfset StartNum = setStartEndNum(#GetData.z1#,#GetData.z2#,#GetData.z3#,#UseOverFGa#)>
<cfset EndNum   = setEndNum(#StartNum#)>

 
<!-- Create the random percent -->
<cfset FavFGASimPct = setPcts(abs(StartNum),abs(EndNum))>
<cfif #UseOverFGA# is false> 
	<cfset FavFGASimPct = -1*FavFGASimPct>
</cfif>



<cfif #UseOverFGpct# is true>

	<cfquery datasource="nbapctsha" name="GetData" cachedWithin="#CreateTimeSpan(0,2,0,0)#">
		Select 
			ooFGpctZ1                     as z1,
			ooFGpctZ1 + ooFGpctZ2           as z2,
			ooFGpctZ1 + ooFGpctZ2 + ooFGpctZ3 as z3 
		from nbapctsha
		Where Team = '#fav#'
	</cfquery>

<cfelse>

	<cfquery datasource="nbapctsha" name="GetData" cachedWithin="#CreateTimeSpan(0,2,0,0)#">
		Select 
			ouFGpctZ1                     as z1,
			ouFGpctZ1 + ouFGpctZ2           as z2,
			ouFGpctZ1 + ouFGpctZ2 + ouFGpctZ3 as z3 
		from nbapctsha
		Where Team = '#fav#'
	</cfquery>

</cfif>

 
<cfset setStartEndNum(GetData.z1,GetData.z2,GetData.z3,UseOverFGpct)> 
<cfset EndNum   = setEndNum(#StartNum#)> 


<!-- Create the random percent -->
<cfset FavFGpctSimPct = setPcts(Abs(StartNum),Abs(EndNum))>
<cfif #UseOverFGpct# is false> 
	<cfset FavFGpctSimPct = -1*FavFGpctSimPct>
</cfif>







<!-- Now based on whether to use OVER stats or UNDER stats, get the actual Over or Under % to apply -->
<cfif #UseOverTPa# is true>

	<cfquery datasource="nbapctsha" name="GetData" cachedWithin="#CreateTimeSpan(0,2,0,0)#">
		Select 
			ooTPAZ1                     as z1,
			ooTPAZ1 + ooTPAZ2           as z2,
			ooTPAZ1 + ooTPAZ2 + ooTPAZ3 as z3 
		from nbapctsha
		Where Team = '#fav#'
	</cfquery>

<cfelse>

	<cfquery datasource="nbapctsha" name="GetData" cachedWithin="#CreateTimeSpan(0,2,0,0)#">
		Select 
			ouTPAZ1                     as z1,
			ouTPAZ1 + ouTPAZ2           as z2,
			ouTPAZ1 + ouTPAZ2 + ouTPAZ3 as z3 
		from nbapctsha
		Where Team = '#fav#'
	</cfquery>

</cfif>
		
<cfset setStartEndNum(GetData.z1,GetData.z2,GetData.z3,UseOverTPA)>
<cfset EndNum   = setEndNum(#StartNum#)> 
<cfset FavTPASimPct = setPcts(Abs(StartNum),Abs(EndNum))>
<cfif #UseOverTPA# is false> 
	<cfset FavTPASimPct = -1*FavTPASimPct>
</cfif>





<!-- Now based on whether to use OVER stats or UNDER stats, get the actual Over or Under % to apply -->
<cfif #UseOverTPpct# is true>

	<cfquery datasource="nbapctsha" name="GetData" cachedWithin="#CreateTimeSpan(0,2,0,0)#">
		Select 
			ooTPpctZ1                     as z1,
			ooTPpctZ1 + ooTPpctZ2           as z2,
			ooTPpctZ1 + ooTPpctZ2 + ooTPpctZ3 as z3 
		from nbapctsha
		Where Team = '#fav#'
	</cfquery>

<cfelse>
	
	<cfquery datasource="nbapctsha" name="GetData" cachedWithin="#CreateTimeSpan(0,2,0,0)#">
		Select 
			ouTPpctZ1                     as z1,
			ouTPpctZ1 + ouTPpctZ2           as z2,
			ouTPpctZ1 + ouTPpctZ2 + ouTPpctZ3 as z3 
		from nbapctsha
		Where Team = '#fav#'
	</cfquery>

</cfif>

<cfset setStartEndNum(GetData.z1,GetData.z2,GetData.z3,UseOverTPpct)>
<cfset EndNum   = setEndNum(#StartNum#)> 
<cfset FavTPpctSimPct = setPcts(Abs(StartNum),Abs(EndNum))>
<cfif #UseOverTPpct# is false> 
	<cfset FavTPpctSimPct = -1*FavTPpctSimPct>
</cfif>





<!-- Now based on whether to use OVER stats or UNDER stats, get the actual Over or Under % to apply -->
<cfif #UseOverFTa# is true>

	<cfquery datasource="nbapctsha" name="GetData" cachedWithin="#CreateTimeSpan(0,2,0,0)#">
		Select 
			ooFTAZ1                     as z1,
			ooFTAZ1 + ooFTAZ2           as z2,
			ooFTAZ1 + ooFTAZ2 + ooFTAZ3 as z3 
		from nbapctsha
		Where Team = '#fav#'
	</cfquery>

<cfelse>

	<cfquery datasource="nbapctsha" name="GetData" cachedWithin="#CreateTimeSpan(0,2,0,0)#">
		Select 
			ouFTAZ1                     as z1,
			ouFTAZ1 + ouFTAZ2           as z2,
			ouFTAZ1 + ouFTAZ2 + ouFTAZ3 as z3 
		from nbapctsha
		Where Team = '#fav#'
	</cfquery>

</cfif>

<cfset setStartEndNum(GetData.z1,GetData.z2,GetData.z3,UseOverFTA)>
<cfset EndNum   = setEndNum(#StartNum#)> 
<cfset FavFTASimPct = setPcts(Abs(StartNum),Abs(EndNum))>
<cfif #UseOverFTA# is false> 
	<cfset FavFTASimPct = -1*FavFTASimPct>
</cfif>



<!-- Create the variables to use in the Game Simulation -->
<cfset UseOverFGA         = false>
<cfset PredUNDFGAProb     = 100*GetStats.uFGA>
<cfset UseOverFGA         = setOverUnderFlags(PredUNDFGAProb)>


<cfset UseOverFGpct       = false>
<cfset PredUNDFGpctProb   = 100*GetStats.uFGpct>
<cfset UseOverFGpct       = setOverUnderFlags(PredUNDFGpctProb)>

<cfset UseOverTPA         = false>
<cfset PredUNDTPAProb     = 100*GetStats.uTPA>
<cfset UseOverTPA         = setOverUnderFlags(PredUNDTPAProb)>

<cfset UseOverTPPct       = false>
<cfset PredUNDTPpctProb   = 100*GetStats.uTPpct>
<cfset UseOverTPPct       = setOverUnderFlags(PredUNDTPpctProb)>

<cfset UseOverFTA         = false>
<cfset PredUNDFTAProb     = 100*GetStats.uFTA>
<cfset UseOverFTA         = setOverUnderFlags(PredUNDFTAProb)>


<!-- Now based on whether to use OVER stats or UNDER stats, get the actual Over or Under % to apply -->
<cfif #UseOverFGa# is true>

	<cfquery datasource="nbapctsha" name="GetData" cachedWithin="#CreateTimeSpan(0,2,0,0)#">
		Select 
			ooFGAZ1                     as z1,
			ooFGAZ1 + ooFGAZ2           as z2,
			ooFGAZ1 + ooFGAZ2 + ooFGAZ3 as z3 
		from nbapctsha
		Where Team = '#UND#'
	</cfquery>

<cfelse>

	<cfquery datasource="nbapctsha" name="GetData" cachedWithin="#CreateTimeSpan(0,2,0,0)#">
		Select 
			ouFGAZ1                     as z1,
			ouFGAZ1 + ouFGAZ2           as z2,
			ouFGAZ1 + ouFGAZ2 + ouFGAZ3 as z3 
		from nbapctsha
		Where Team = '#UND#'
	</cfquery>

</cfif>
 
<cfset setStartEndNum(GetData.z1,GetData.z2,GetData.z3,UseOverFGa)>
<cfset EndNum   = setEndNum(#StartNum#)> 
<cfset UNDFGASimPct = setPcts(abs(StartNum),abs(EndNum))>
<cfif #UseOverFGA# is false> 
	<cfset UndFGASimPct = -1*UndFGASimPct>
</cfif>


<!-- Now based on whether to use OVER stats or UNDER stats, get the actual Over or Under % to apply -->
<cfif #UseOverFGpct# is true>

	<cfquery datasource="nbapctsha" name="GetData" cachedWithin="#CreateTimeSpan(0,2,0,0)#">
		Select 
			ooFGpctZ1                     as z1,
			ooFGpctZ1 + ooFGpctZ2           as z2,
			ooFGpctZ1 + ooFGpctZ2 + ooFGpctZ3 as z3 
		from nbapctsha
		Where Team = '#UND#'
	</cfquery>

<cfelse>

	<cfquery datasource="nbapctsha" name="GetData" cachedWithin="#CreateTimeSpan(0,2,0,0)#">
		Select 
			ouFGpctZ1                     as z1,
			ouFGpctZ1 + ouFGpctZ2           as z2,
			ouFGpctZ1 + ouFGpctZ2 + ouFGpctZ3 as z3 
		from nbapctsha
		Where Team = '#UND#'
	</cfquery>

</cfif>
 
<cfset setStartEndNum(GetData.z1,GetData.z2,GetData.z3,UseOverFGpct)> 
<cfset EndNum   = setEndNum(#StartNum#)> 
<cfset UNDFGpctSimPct = setPcts(abs(StartNum),abs(EndNum))>
<cfif #UseOverFGpct# is false> 
	<cfset UndFGpctSimPct = -1*UndFGpctSimPct>
</cfif>


<!-- Now based on whether to use OVER stats or UNDER stats, get the actual Over or Under % to apply -->
<cfif #UseOverTPa# is true>

	<cfquery datasource="nbapctsha" name="GetData" cachedWithin="#CreateTimeSpan(0,2,0,0)#">
		Select 
			ooTPAZ1                     as z1,
			ooTPAZ1 + ooTPAZ2           as z2,
			ooTPAZ1 + ooTPAZ2 + ooTPAZ3 as z3 
		from nbapctsha
		Where Team = '#UND#'
	</cfquery>

<cfelse>

	<cfquery datasource="nbapctsha" name="GetData" cachedWithin="#CreateTimeSpan(0,2,0,0)#">
		Select 
			ouTPAZ1                     as z1,
			ouTPAZ1 + ouTPAZ2           as z2,
			ouTPAZ1 + ouTPAZ2 + ouTPAZ3 as z3 
		from nbapctsha
		Where Team = '#UND#'
	</cfquery>

</cfif>
		
<cfset setStartEndNum(GetData.z1,GetData.z2,GetData.z3,UseOverTPA)>
<cfset EndNum   = setEndNum(#StartNum#)> 
<cfset UNDTPASimPct = setPcts(abs(StartNum),abs(EndNum))>
<cfif #UseOverTPA# is false> 
	<cfset UndTPASimPct = -1*UndTPASimPct>
</cfif>


<!-- Now based on whether to use OVER stats or UNDER stats, get the actual Over or Under % to apply -->
<cfif #UseOverTPpct# is true>

	<cfquery datasource="nbapctsha" name="GetData" cachedWithin="#CreateTimeSpan(0,2,0,0)#">
		Select 
			ooTPpctZ1                     as z1,
			ooTPpctZ1 + ooTPpctZ2           as z2,
			ooTPpctZ1 + ooTPpctZ2 + ooTPpctZ3 as z3 
		from nbapctsha
		Where Team = '#UND#'
	</cfquery>

<cfelse>

	<cfquery datasource="nbapctsha" name="GetData" cachedWithin="#CreateTimeSpan(0,2,0,0)#">
		Select 
			ouTPpctZ1                     as z1,
			ouTPpctZ1 + ouTPpctZ2           as z2,
			ouTPpctZ1 + ouTPpctZ2 + ouTPpctZ3 as z3 
		from nbapctsha
		Where Team = '#UND#'
	</cfquery>

</cfif>

<cfset setStartEndNum(GetData.z1,GetData.z2,GetData.z3,UseOverTPpct)>
<cfset EndNum   = setEndNum(#StartNum#)> 
<cfset UNDTPpctSimPct = setPcts(abs(StartNum),abs(EndNum))>
<cfif #UseOverTPpct# is false> 
	<cfset UndTPpctSimPct = -1*UndTPpctSimPct>
</cfif>


<!-- Now based on whether to use OVER stats or UNDER stats, get the actual Over or Under % to apply -->
<cfif #UseOverFTa# is true>

	<cfquery datasource="nbapctsha" name="GetData" cachedWithin="#CreateTimeSpan(0,2,0,0)#">
		Select 
			ooFTAZ1                     as z1,
			ooFTAZ1 + ooFTAZ2           as z2,
			ooFTAZ1 + ooFTAZ2 + ooFTAZ3 as z3 
		from nbapctsha
		Where Team = '#UND#'
	</cfquery>

<cfelse>

	<cfquery datasource="nbapctsha" name="GetData" cachedWithin="#CreateTimeSpan(0,2,0,0)#">
		Select 
			ouFTAZ1                     as z1,
			ouFTAZ1 + ouFTAZ2           as z2,
			ouFTAZ1 + ouFTAZ2 + ouFTAZ3 as z3 
		from nbapctsha
		Where Team = '#UND#'
	</cfquery>

</cfif>

<cfset setStartEndNum(GetData.z1,GetData.z2,GetData.z3,UseOverFTA)>
<cfset EndNum   = setEndNum(#StartNum#)> 
<cfset UNDFTASimPct = setPcts(abs(StartNum),abs(EndNum))>
<cfif #UseOverFTA# is false> 
	<cfset UndFTASimPct = -1*UndFTASimPct>
</cfif>


<cfif FAVTPpctSimPct lt 0>
	<cfset FAVTPpctSimPct = 0>
</cfif>

<cfif UNDTPpctSimPct lt 0>
	<cfset UNDTPpctSimPct = 0>
</cfif>


<cfoutput>
<!--- Simulation Pcts To Use:<br>
Fav:<br>
FAVFGASimPct   = #FAVFGASimPct    + GetStats.FPrdFGA#<br>
FAVFGpctSimPct = #FAVFGpctSimPct  + GetStats.FPrdFGpct#<br>
FAVTPASimPct   = #FAVTPASimPct    + GetStats.FPrdTPA# <br>
FAVTPpctSimPct = #FAVTPpctSimPct  + GetStats.FPrdTPpct#<br>
FAVFTASimPct   = #FAVFTASimPct    + GetStats.FPrdFTA#<br>
#FAVFGASimPct#,#GetStats.FPrdFGA#,#FAVFGpctSimPct#,#GetStats.FPrdFGpct#<br> --->
<cfset Favscore1 =0>
<cfset Favscore2 =0>
<cfset Favscore3 =0>

<cfset Undscore1 =0>
<cfset Undscore2 =0>
<cfset Undscore3 =0>

<cfset Favscore1 = (2*  (FAVFGASimPct + GetStats.FPrdFGA) * ((FAVFGpctSimPct  + GetStats.FPrdFGpct))/100)>
<cfset Favscore2 = (3*(FAVTPASimPct + GetStats.FPrdTPA)*((FAVTPpctSimPct  + GetStats.FPrdTPpct))/100)>
<cfset Favscore3 = (1*(FAVFTASimPct + GetStats.FPrdFTA)*((GetStats.oavgfFTpct))/100)>
<cfset FavSc = Favscore1 + Favscore2 + Favscore3>

<!--- 
-----------------------------------------------<br>
Und:<br>
UndFGASimPct   = #UndFGASimPct    + GetStats.uPrdFGA#<br>
UndFGpctSimPct = #UndFGpctSimPct  + GetStats.uPrdFGpct#<br>
UndTPASimPct   = #UndTPASimPct    + GetStats.uPrdTPA#<br>
UndTPpctSimPct = #UndTPpctSimPct  + GetStats.uPrdTPpct#<br>
UndFTASimPct   = #UndFTASimPct    + GetStats.uPrdFTA#<br>
-----------------------------------------------<br>
 --->
<cfset Undscore1 = (2*(UndFGASimPct + GetStats.uPrdFGA)*((undFGpctSimPct  + GetStats.uPrdFGpct))/100)>
<cfset Undscore2 = (3*(UndTPASimPct + GetStats.uPrdTPA)*((undTPpctSimPct  + GetStats.uPrdTPpct))/100)>
<cfset Undscore3 = (1*(UndFTASimPct    + GetStats.uPrdFTA)*((GetStats.oavguFTpct))/100)>
<cfset UndSc = Undscore1 + Undscore2 + Undscore3>

<cfset FavPredScore[gg] = favsc>
<cfset UndPredScore[gg] = Undsc>

<cfif Ha is 'H' >
	<cfset FavPredScore[gg] = FavPredScore[gg] + 2.5>
<cfelse>
	<cfset UndPredScore[gg] = UndPredScore[gg] + 2.5>
</cfif>

<cfset totFav = totfav + FavPredScore[gg]>
<cfset totUnd = totund + UndPredScore[gg]>

</cfoutput>

</cfloop>


<cfset myAvg          = totFav/400 >
<cfset myfavhi = (.40*Myavg) + myavg>
<cfset myFavlo = myavg - (.40*Myavg)>

<cfset myAvg          = totUnd/400>
<cfset myUndhi = (.40*Myavg) + myavg>
<cfset myUndlo = myavg - (.40*Myavg)>

<cfoutput>
****************************************************<br><br>
#fav#: #totFav/400#<br>
#und#: #totUnd/400#<br>
Total Points: #(totFav/400) + (totUnd/400)#<br>  
****************************************************<br><br>
<!--- #fav# Hi is #myfavhi#<br>
#fav# Lo is #myFavlo#<br>
#und# Hi is #myUndhi#<br>
#und# Lo is #myUndlo#<br>
 --->
</cfoutput>


<cfset myctr = 0>
<cfset mysum = 0>
<cfset hict = 0>
<cfset loct = 0>

<!-- Loop through scores and create deltas -->
<cfloop index="ii" from="1" to="400">
	<cfloop index="jj" from="1" to="400">
		<cfset myctr = myctr + 1>
		<cfset mydelta[ii][jj] = FavPredScore[ii] - UndPredScore[jj]>  
		<cfif UndPredScore[ii] gt 130>
			<cfset hict = hict + 1>
		</cfif>
		
		<cfif UndPredScore[ii] lt 70>
			<cfset loct = loct + 1>
		</cfif>
		<cfif (FavPredScore[ii] + UndPredScore[jj]) gt myou>
		
			<cfset overct = overct + 1>
		</cfif>
		<cfset mysum = mysum + mydelta[ii][jj]>
	</cfloop>
</cfloop>

<cfset FavCovCt = 0>
<cfset UndCovCt = 0>
<cfset PushCt = 0>

<!--- <cfoutput>
Times gt 130... #hict/(1000*1000)#*100<br>
Times lt 70....  #loct/(1000*1000)#*100<br>
</cfoutput>
 --->

<!-- Loop through deltas and remove the Extremes to smooth out the predictions... -->
<!--- <cfloop index="ii" from="1" to="1000">
	<cfloop index="jj" from="1" to="1000">
		<cfif mydelta[ii][jj] le myloextreme or mydelta[ii][jj] ge myhiextreme>
			<cfset arraydeleteat(mydelta,ii*jj)>
		</cfif>
	</cfloop>
</cfloop> --->
<cfset GameCt = 0>
<!-- Now use the results to see what the average margin of victory was, and pct of time a team covered -->
<cfloop index="ii" from="1" to="#Arraylen(mydelta)/2#">
	<cfloop index="jj" from="1" to="#Arraylen(mydelta)/2#">
		<cfset GameCt = Gamect + 1>
		<cfif mydelta[ii][jj] gt spd>
			<cfset FavCovCt = FavCovCt + 1>
		<cfelse>
			<cfif mydelta[ii][jj] lt spd>	
				<cfset UndCovCt = UndCovCt + 1>
			<cfelse>
				<cfset PushCt = PushCt + 1>
			</cfif>
		</cfif>
	</cfloop>		
</cfloop>


<cfoutput>
<br>
*************************************************************<br>
Game Results Between #Fav#&nbsp;&nbsp;-#spd#&nbsp;&nbsp;#Und#<br>
*************************************************************<br>
#Fav# covered #Numberformat((FavCovct/GameCt)*100,'999.99')#<br>
#Und# covered #Numberformat((UndCovct/GameCt)*100,'999.99')#<br> 
Pushes occurred #Numberformat((Pushct/GameCt)*100,'999.99')#<br>
Over Win Rate was #Numberformat((Overct/(400*400))*100,'999.99')#<br>

<cfset pick = ''>
<cfset Rating = 0>
<cfif FavCovct gt UndCovct>
	<cfset pick = '#Fav#'>
	<cfset Rating = ((FavCovct/GameCt)*100)>
<cfelse>
	<cfset pick = '#Und#'>
	<cfset Rating = ((UndCovct/GameCt)*100)>
</cfif>


<cfset oupick = 'U'>
<cfset ourating = 100 - Numberformat((Overct/(400*400))*100,'999.99')>

<cfif (Overct/(400*400))*100 gt 50>
	<cfset oupick = 'O'>
	<cfset ourating = #Numberformat((Overct/(400*400))*100,'999.99')#>
</cfif>

<!--- Pct used UseOverFGAct   = #(UseOverFGAct/1000)*100#....#PredFavFGAProb#<br>
Pct used UseOverFGpctct = #(UseOverFGpctct/1000)*100#..#PredFavFGpctProb#<br>
Pct used UseOverTPAct   = #(UseOverTPAct/1000)*100#....#PredFavTPAProb#<br>
Pct used UseOverTPpctct = #(UseOverTPpctct/1000)*100#..#PredFavTPpctProb#<br>
Pct used UseOverFTAct   = #(UseOverFTAct/1000)*100#....#PredFavFTAProb#<br> --->
</cfoutput>

<cfquery datasource="nbaGameSim" name="gs">

Insert into NBAGameSim
(
GameTime,
Fav,
Spd,
Und,
Pick,
Rating,
OuPick,
OuRating
)
values
(
'#GameTime#',
'#Fav#',
#Spd#,
'#Und#',
'#Pick#',
#Rating#,
'#OuPick#',
#OuRating#
)

</cfquery>


<cfset arrayclear(FavPredScore)>
<cfset arrayclear(UndPredScore)>
<cfset arrayclear(mydelta)>

<cfset arrayclear(FavPredScore)>
<cfset arrayclear(UndPredScore)>
<cfset arrayclear(mydelta)>


<cfset Application.objRandom = "">
<cfset rn = "">
</cfloop>

<cfquery datasource="nbaschedule" name="Getspds">
Select *
from nbaschedule
where GameTime = '#mygametime#'
 </cfquery>

 <cfoutput query="Getspds">

<cfquery datasource="nbaGameSim" name="gsf">
Select gsf.Fav, Avg(gsf.Rating) as aRating, count(gsf.pick) as Wins
from nbagamesim gsf
Where GameTime = '#Session.Gametime#'
and gsf.Pick = gsf.Fav
and gsf.Fav = '#GetSpds.fav#'
Group by gsf.fav, gsf.und, gsf.pick
</cfquery>

<cfquery datasource="nbaGameSim" name="gsu">
Select gsu.Und, Avg(gsu.Rating) as aRating, count(gsu.pick) as Wins
from nbagamesim gsu
Where GameTime = '#Session.Gametime#'
and gsu.Pick = gsu.Und
and gsu.Und = '#GetSpds.und#'
Group by gsu.fav, gsu.und, gsu.pick
</cfquery>


<cfquery datasource="nbaGameSim" name="gsov">
Select Avg(gsov.ouRating) as aRating, count(gsov.oupick) as Wins
from nbagamesim gsov
Where GameTime = '#Session.Gametime#'
and gsov.ouPick = 'O'
and gsov.fav = '#Fav#'
Group by gsov.fav, gsov.und, gsov.oupick
</cfquery>

<cfquery datasource="nbaGameSim" name="gsun">
Select Avg(gsun.ouRating) as aRating, count(gsun.oupick) as Wins
from nbagamesim gsun
Where GameTime = '#Session.Gametime#'
and gsun.ouPick = 'U'
and gsun.fav = '#Fav#'
Group by gsun.fav, gsun.und, gsun.oupick
</cfquery>

------------------------------------------------------------------------<br>
#gsf.Fav#=====Wins:#gsf.wins#,=====#Numberformat(gsf.aRating,'999.99')#<br>
#gsu.Und#=====Wins:#gsu.wins#,=====#Numberformat(gsu.aRating,'999.99')#<br>
Over=====Wins:#gsov.wins#,=====#Numberformat(gsov.aRating,'999.99')#<br>
Under====Wins:#gsun.wins#,=====#Numberformat(gsun.aRating,'999.99')#<br>
------------------------------------------------------------------------<br>

</cfoutput>

</body>


<cfscript>
function setPcts(StartNum,EndNum)
{
Application.objRandom.setBounds(StartNum,EndNum);

Return Application.objRandom.next(); 

}
</cfscript>



<cfscript>
function setOverUnderFlags(pcttocheck)
{
Application.objRandom.setBounds(1,100);
rn = Application.objRandom.next();

if (rn le pcttocheck)
{
	return true;
}
return false;
}
</cfscript>


<cfscript>
function setEndNum(StartNum)
{
if (StartNum is 0)
{
	return 4;
}

if (StartNum is 5)
{
	return 10;
}

if (StartNum is 11)
{
	return 15;
}

if (StartNum is 16)
{
	return 20;
}


if (StartNum is -1)
{
	return -4;
}

if (StartNum is -5)
{
	return -10;
}

if (StartNum is -11)
{
	return -15;
}

if (StartNum is -16)
{
	return -20;
}
}

</cfscript>


<cfscript>
function setStartEndNum(z1,z2,z3,UseOver)
{
Application.objRandom.setBounds(1,100);
rn = Application.objRandom.next();
StartNum=0;
//WriteOutput("rn =" & #rn#); 
//WriteOutput("UseOver=" & #UseOver#);
if (rn le z1)
{
	if (UseOver is true)
	{	
		StartNum = 0;
		EndNum   = 4;
		return StartNum;
	}	
	else
	{
		StartNum = -1;
		EndNum   = -4;
		return StartNum;
	}	
}
		

if (rn le z2)
{
	if (UseOver is true)
	{
		StartNum = 5;
		return StartNum;
	}	
	else
	{
		StartNum = -5;
		EndNum   = -10;
		return StartNum;
	}
}

if (rn le z3)
{	
	if(UseOver is true)
	{
         StartNum = 11;
         EndNum   = 15;
		 return StartNum;
	}	 
	else
	{
		StartNum = -11;
		EndNum   = -15;
		return StartNum;
	}	
}
else
{
	if(UseOver is true)
	{
	    StartNum = 16;
	    EndNum   = 20;
		return StartNum;
	}	 
	else
	{
		StartNum = -16;
		EndNum   = -20;
		return StartNum;
	}
}

return StartNum;
}
</cfscript>
