
<cfset fav='MIA'>
<cfset und='LAC'>

		
<cfquery datasource="nba" name="GetStats">
	Select 
		f.Team,
		
		<!--- Probabilities.. --->
		f.oFGA/(f.ofga     + u.dFGA)   as fFGA,
		f.oFGpct/(f.ofgpct + u.dFGpct) as fFGPCT,
		f.oTPA/(f.oTPA     + u.dTPA)   as fTPA,
		f.oTPpct/(f.oTPpct + u.dTPpct) as fTPPCT,
		f.oFTA/(f.ofTa     + u.dFTA)   as fFTA,

		favg.oFGA                      as oavgfFGA,
		favg.oFGpct                    as oavgfFGPCT,
		favg.oTPA                      as oavgfTPA,
		favg.oTPpct                    as oavgfTPPCT,
		favg.oFTA                      as oavgfFTA,
		100*favg.oFTpct                 as oavgfFTpct,
		
		favg.dFGA                      as davgfFGA,
		favg.dFGpct                    as davgfFGPCT,
		favg.dTPA                      as davgfTPA,
		favg.dTPpct                    as davgfTPPCT,
		favg.dFTA                      as davgfFTA,

		(favg.oFGA   + uavg.dFGA)/2            as FPrdFGA,
		100*((favg.oFGpct + uavg.dFGpct)/2)    as FPrdFGpct,	
		(favg.oTPA   + uavg.dTPA)/2            as FPrdTPA,		
		100*((favg.oTPpct + uavg.dTPpct)/2)    as FPrdTPpct,			
		(favg.oFTA   + uavg.dFTA)/2            as FPrdFTA,
				
		u.oFGA/(u.ofga     + f.dFGA)   as uFGA,
		u.oFGpct/(u.ofgpct + f.dFGpct) as uFGPCT,
		u.oTPA/(u.oTPA     + f.dTPA)   as uTPA,
		u.oTPpct/(u.oTPpct + f.dTPpct) as uTPPCT,
		u.oFTA/(u.ofTa     + f.dFTA)   as uFTA,
				
		uavg.oFGA                      as oavguFGA,
		uavg.oFGpct                    as oavguFGPCT,
		uavg.oTPA                      as oavguTPA,
		uavg.oTPpct                    as oavguTPPCT,
		uavg.oFTA                      as oavguFTA,
		100*uavg.oFTpct                 as oavguFTpct,	
				
		uavg.dFGA                      as davguFGA,
		uavg.dFGpct                    as davguFGPCT,
		uavg.dTPA                      as davguTPA,
		uavg.dTPpct                    as davguTPPCT,
		uavg.dFTA                      as davguFTA,
		
		(uavg.oFGA   + favg.dFGA)/2            as uPrdFGA,
		100*((uavg.oFGpct + favg.dFGpct)/2)    as uPrdFGpct,	
		(uavg.oTPA   + favg.dTPA)/2            as uPrdTPA,		
		100*((uavg.oTPpct + favg.dTPpct)/2)    as uPrdTPpct,			
		(uavg.oFTA   + favg.dFTA)/2            as uPrdFTA
						
				
	from 
		NBAPcts f, 
		NBAPCTS u,
		NBAAvgs favg,
		NBAAvgs uavg
		Where f.Team    = '#fav#'
		and   u.Team    = '#Und#'
		and   favg.Team = '#Fav#'
		and   uavg.Team = '#Und#'

</cfquery>



<cfoutput query="GetStats">
		#fav#,fga:#100*fFGA#  fgpct:#100*fFGPCT#   tpa:#100*fTPA#  tppct:#100*fTPPCT#  fta:#100*fFTA#<br>
		#und#,fga:#100*uFGA#, fgpct:#100*uFGPCT#   tpa:#100*uTPA#  tppct:#100*uTPPCT#  fta:#100*uFTA#<br>
</cfoutput>


