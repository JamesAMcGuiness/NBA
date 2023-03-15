<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>


<cfquery datasource="Nba" name="GetRunct">
	Delete from NBAPower
</cfquery>

<cfquery datasource="Nba" name="GetRunct">
	Delete from NBAPowerSD
</cfquery>


<cfquery datasource="Nba" name="GetRunct">
	Select RunCt,Gametime
	from NBAGameTime
</cfquery>

<cfset myGametime = GetRunct.gametime>

	
<cfquery  datasource="nba" name="GetTeams">	
select distinct team
from nbadata 
group by team
</cfquery>	

<cfloop query="getteams">
	
	<cfset Team = '#getteams.team#'>
		
	
			<!--- For each Team, see how they did versus the avgs of their opponent  --->
			<cfquery  datasource="nba" name="GetAdv">
			
			Select 
			  'O',
			  100*(f.ofgm - f.otpm)/f.ofga as twopt,
			  100*(f.otpm)/f.ofga as threept,
			  100 - (((f.ofgm - f.otpm)/f.ofga + (f.otpm)/f.ofga)*100) as other,
			  f.ofta as fta,
			  f.ofga,
			  100*(f.opip/f.ps) as pippct,
  			  'H', 
			  f.opp,
			  f.ps,
			  f.dps
	   
		 	from nbadata f
		  	where f.Team = '#Team#'
			and   f.GameTime < '#myGameTime#'
			and   f.ha = 'H'
			
			</cfquery>
	
			<cfoutput query="GetAdv">
	
			<cfquery  datasource="nba" name="addit">
			insert into NBAPower(Team,OffDef,twopt,threept,other,fta,HA,opp,ps,pippct,dps,fga)
			values
			(
			'#team#','O',#twopt#,#threept#,#other#,#fta#,'H','#opp#',#ps#,#pippct#,#dps#,#ofga#
			)
			</cfquery>
			</cfoutput>
	
	<cfquery  datasource="nba" name="GetAdv">
			
			Select 
			  'O',
			  100*(f.dfgm - f.dtpm)/f.dfga as twopt,
			  100*(f.dtpm)/f.ofga as threept,
			  100 - (((f.dfgm - f.dtpm)/f.ofga + (f.dtpm)/f.dfga)*100) as other,
			  100*(f.dftm/f.dps) as ftpct,
			  100*(f.dpip/f.dps) as pippct,
  			  'H', 
			  f.opp,
			  f.ps,
			  f.dps,
			  f.dfga,
			  f.dfta
	   
		 	from nbadata f
		  	where f.Team = '#Team#'
			and   f.GameTime < '#myGameTime#'
			and   f.ha = 'H'
			
			</cfquery>
	
			<cfoutput query="GetAdv">
	
			<cfquery  datasource="nba" name="addit">
			insert into NBAPower(Team,OffDef,twopt,threept,other,fta,HA,opp,ps,pippct,dps,fga)
			values
			(
			'#team#','D',#twopt#,#threept#,#other#,#dfta#,'H','#opp#',#ps#,#pippct#,#dps#,#dfga#
			)
			</cfquery>
			</cfoutput>
		







			<cfquery  datasource="nba" name="GetAdv">
			
			Select 
			  'O',
			  100*(f.ofgm - f.otpm)/f.ofga as twopt,
			  100*(f.otpm)/f.ofga as threept,
			  100 - (((f.ofgm - f.otpm)/f.ofga + (f.otpm)/f.ofga)*100) as other,
			  f.ofta as fta,
			  f.ofga,
			  100*(f.opip/f.ps) as pippct,
  			  'A', 
			  f.opp,
			  f.ps,
			  f.dps
	   
		 	from nbadata f
		  	where f.Team = '#Team#'
			and   f.GameTime < '#myGameTime#'
			and   f.ha = 'A'
			
			</cfquery>
	
			<cfoutput query="GetAdv">
	
			<cfquery  datasource="nba" name="addit">
			insert into NBAPower(Team,OffDef,twopt,threept,other,fta,HA,opp,ps,pippct,dps,fga)
			values
			(
			'#team#','O',#twopt#,#threept#,#other#,#fta#,'A','#opp#',#ps#,#pippct#,#dps#,#ofga#
			)
			</cfquery>
			</cfoutput>
	
	<cfquery  datasource="nba" name="GetAdv">
			
			Select 
			  'O',
			  100*(f.dfgm - f.dtpm)/f.dfga as twopt,
			  100*(f.dtpm)/f.ofga as threept,
			  100 - (((f.dfgm - f.dtpm)/f.ofga + (f.dtpm)/f.dfga)*100) as other,
			  100*(f.dftm/f.dps) as ftpct,
			  100*(f.dpip/f.dps) as pippct,
  			  'A', 
			  f.opp,
			  f.ps,
			  f.dps,
			  f.dfga,
			  f.dfta
	   
		 	from nbadata f
		  	where f.Team = '#Team#'
			and   f.GameTime < '#myGameTime#'
			and   f.ha = 'A'
			
			</cfquery>
	
			<cfoutput query="GetAdv">
	
			<cfquery  datasource="nba" name="addit">
			insert into NBAPower(Team,OffDef,twopt,threept,other,fta,HA,opp,ps,pippct,dps,fga)
			values
			(
			'#team#','D',#twopt#,#threept#,#other#,#dfta#,'A','#opp#',#ps#,#pippct#,#dps#,#dfga#
			)
			</cfquery>
			</cfoutput>

</cfloop>


<!--- Create the standard deviations for the values --->
<cfquery  datasource="nba" name="GetTeams">
Select Distinct Team
from NBAPower
</cfquery>

<cfloop query="GetTeams">

	<cfquery  datasource="nba" name="GetHomeInfo">
	Select * from NBAPower where team = '#GetTeams.Team#'
	and HA      = 'H'
	and OffDef  ='O'
	</cfquery>
	
	<!--- Create array of stats --->
	<cfset atwopt   = arraynew(1)>
	<cfset athreept = arraynew(1)>
	<cfset afga     = arraynew(1)>
	<cfset afta     = arraynew(1)>
	<cfset aother   = arraynew(1)>
	
	<cfset atwopt   = ListToArray(Valuelist(GetHomeInfo.twopt))>
	<cfset athreept = ListToArray(Valuelist(GetHomeInfo.threept))>
	<cfset afga     = ListToArray(Valuelist(GetHomeInfo.fga))>
	<cfset afta     = ListToArray(Valuelist(GetHomeInfo.fta))>
	<cfset aother   = ListToArray(Valuelist(GetHomeInfo.other))>
	
	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #afga#	
	returnvariable  = "sdFGA"			
	>
	
	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #atwopt#	
	returnvariable  = "sdtwopt"			
	>
	
	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #athreept#	
	returnvariable  = "sdthreept"			
	>

	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #afta#	
	returnvariable  = "sdfta"			
	>

	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #aother#	
	returnvariable  = "sdother"			
	>


	<cfquery  datasource="nba" name="addit">
			insert into NBAPowerSD(Team,OffDef,twopt,threept,other,fta,HA,fga)
			values
			(
			'#GetTeams.Team#','O',#sdtwopt#,#sdthreept#,#sdother#,#sdfta#,'H',#sdfga#)
			
	</cfquery>
	

</cfloop>




























<cfloop query="GetTeams">

	<cfquery  datasource="nba" name="GetHomeInfo">
	Select * from NBAPower where team = '#GetTeams.Team#'
	and HA      = 'A'
	and OffDef  ='O'
	</cfquery>
	
	<!--- Create array of stats --->
	<cfset atwopt   = arraynew(1)>
	<cfset athreept = arraynew(1)>
	<cfset afga     = arraynew(1)>
	<cfset afta     = arraynew(1)>
	<cfset aother   = arraynew(1)>
	
	<cfset atwopt   = ListToArray(Valuelist(GetHomeInfo.twopt))>
	<cfset athreept = ListToArray(Valuelist(GetHomeInfo.threept))>
	<cfset afga     = ListToArray(Valuelist(GetHomeInfo.fga))>
	<cfset afta     = ListToArray(Valuelist(GetHomeInfo.fta))>
	<cfset aother   = ListToArray(Valuelist(GetHomeInfo.other))>
	
	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #afga#	
	returnvariable  = "sdFGA"			
	>
	
	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #atwopt#	
	returnvariable  = "sdtwopt"			
	>
	
	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #athreept#	
	returnvariable  = "sdthreept"			
	>

	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #afta#	
	returnvariable  = "sdfta"			
	>

	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #aother#	
	returnvariable  = "sdother"			
	>


	<cfquery  datasource="nba" name="addit">
			insert into NBAPowerSD(Team,OffDef,twopt,threept,other,fta,HA,fga)
			values
			(
			'#GetTeams.Team#','O',#sdtwopt#,#sdthreept#,#sdother#,#sdfta#,'A',#sdfga#)
			
	</cfquery>
	

</cfloop>































<cfloop query="GetTeams">

	<cfquery  datasource="nba" name="GetHomeInfo">
	Select * from NBAPower where team = '#GetTeams.Team#'
	and HA      = 'H'
	and OffDef  ='D'
	</cfquery>
	
	<!--- Create array of stats --->
	<cfset atwopt   = arraynew(1)>
	<cfset athreept = arraynew(1)>
	<cfset afga     = arraynew(1)>
	<cfset afta     = arraynew(1)>
	<cfset aother   = arraynew(1)>
	
	<cfset atwopt   = ListToArray(Valuelist(GetHomeInfo.twopt))>
	<cfset athreept = ListToArray(Valuelist(GetHomeInfo.threept))>
	<cfset afga     = ListToArray(Valuelist(GetHomeInfo.fga))>
	<cfset afta     = ListToArray(Valuelist(GetHomeInfo.fta))>
	<cfset aother   = ListToArray(Valuelist(GetHomeInfo.other))>
	
	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #afga#	
	returnvariable  = "sdFGA"			
	>
	
	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #atwopt#	
	returnvariable  = "sdtwopt"			
	>
	
	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #athreept#	
	returnvariable  = "sdthreept"			
	>

	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #afta#	
	returnvariable  = "sdfta"			
	>

	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #aother#	
	returnvariable  = "sdother"			
	>


	<cfquery  datasource="nba" name="addit">
			insert into NBAPowerSD(Team,OffDef,twopt,threept,other,fta,HA,fga)
			values
			(
			'#GetTeams.Team#','D',#sdtwopt#,#sdthreept#,#sdother#,#sdfta#,'H',#sdfga#)
			
	</cfquery>
	

</cfloop>




























<cfloop query="GetTeams">

	<cfquery  datasource="nba" name="GetHomeInfo">
	Select * from NBAPower where team = '#GetTeams.Team#'
	and HA      = 'A'
	and OffDef  ='D'
	</cfquery>
	
	<!--- Create array of stats --->
	<cfset atwopt   = arraynew(1)>
	<cfset athreept = arraynew(1)>
	<cfset afga     = arraynew(1)>
	<cfset afta     = arraynew(1)>
	<cfset aother   = arraynew(1)>
	
	<cfset atwopt   = ListToArray(Valuelist(GetHomeInfo.twopt))>
	<cfset athreept = ListToArray(Valuelist(GetHomeInfo.threept))>
	<cfset afga     = ListToArray(Valuelist(GetHomeInfo.fga))>
	<cfset afta     = ListToArray(Valuelist(GetHomeInfo.fta))>
	<cfset aother   = ListToArray(Valuelist(GetHomeInfo.other))>
	
	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #afga#	
	returnvariable  = "sdFGA"			
	>
	
	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #atwopt#	
	returnvariable  = "sdtwopt"			
	>
	
	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #athreept#	
	returnvariable  = "sdthreept"			
	>

	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #afta#	
	returnvariable  = "sdfta"			
	>

	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #aother#	
	returnvariable  = "sdother"			
	>


	<cfquery  datasource="nba" name="addit">
			insert into NBAPowerSD(Team,OffDef,twopt,threept,other,fta,HA,fga)
			values
			(
			'#GetTeams.Team#','D',#sdtwopt#,#sdthreept#,#sdother#,#sdfta#,'A',#sdfga#)
			
	</cfquery>
	

</cfloop>

<!--- Create Hi/Med/Lo values using Trimmed Mean and SD's --->
<cfloop query="GetTeams">

	<cfquery  datasource="nba" name="GetHomeInfo">
	Select * from NBAPower where team = '#GetTeams.Team#'
	and HA      = 'H'
	and OffDef  ='O'
	</cfquery>
	
	<!--- Create array of stats --->
	<cfset atwopt   = arraynew(1)>
	<cfset athreept = arraynew(1)>
	<cfset afga     = arraynew(1)>
	<cfset afta     = arraynew(1)>
	<cfset aother   = arraynew(1)>
	
	<cfset atwopt   = ListToArray(Valuelist(GetHomeInfo.twopt))>
	<cfset athreept = ListToArray(Valuelist(GetHomeInfo.threept))>
	<cfset afga     = ListToArray(Valuelist(GetHomeInfo.fga))>
	<cfset afta     = ListToArray(Valuelist(GetHomeInfo.fta))>
	<cfset aother   = ListToArray(Valuelist(GetHomeInfo.other))>
	
	
	<cfquery  datasource="nba" name="GetHomeInfoSD">
	Select * from NBAPowerSD where team = '#GetTeams.Team#'
	and HA      = 'H'
	and OffDef  ='O'
	</cfquery>
	
	
	<!--- Get Standard Deviations --->
	<cfinvoke method="getTrimmedMean" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #afga#	
	returnvariable  = "trimmedMeanFGA"			
	>
	<cfset lofga  = trimmedMeanFGA - GetHomeInfoSD.fga>
	<cfset hifga  = trimmedMeanFGA + GetHomeInfoSD.fga>
	<cfset medfga = (lofga + hifga)/2>

	<!--- Get Standard Deviations --->
	<cfinvoke method="getTrimmedMean" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #atwopt#	
	returnvariable  = "trimmedMean2pt"			
	>
	<cfset lo2pt  = trimmedMean2pt - GetHomeInfoSD.twopt>
	<cfset hi2pt  = trimmedMean2pt + GetHomeInfoSD.twopt>
	<cfset med2pt = (lo2pt + hi2pt)/2>

	<!--- Get Standard Deviations --->
	<cfinvoke method="getTrimmedMean" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #athreept#	
	returnvariable  = "trimmedMean3pt"			
	>
	<cfset lo3pt  = trimmedMean3pt - GetHomeInfoSD.threept>
	<cfset hi3pt  = trimmedMean3pt + GetHomeInfoSD.threept>
	<cfset med3pt = (lo3pt + hi3pt)/2>

	<!--- Get Standard Deviations --->
	<cfinvoke method="getTrimmedMean" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #afta#	
	returnvariable  = "trimmedMeanfta"			
	>
	<cfset lofta  = trimmedMeanfta - GetHomeInfoSD.fta>
	<cfset hifta  = trimmedMeanfta + GetHomeInfoSD.fta>
	<cfset medfta = (lofta + hifta)/2>

	<!--- Get Standard Deviations --->
	<cfinvoke method="getTrimmedMean" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #aother#	
	returnvariable  = "trimmedMeanother"			
	>
	<cfset loother  = trimmedMeanother - GetHomeInfoSD.other>
	<cfset hiother  = trimmedMeanother + GetHomeInfoSD.other>
	<cfset medother = (loother + hiother)/2>

	<cfquery  datasource="nba" name="Updateit">
	Update NBAPowerSD
	Set LoFGA  = #loFGA#,
	    MedFGA = #medFGA#,
	    HiFGA  = #hiFGA#,
		LoThreept  = #lo3pt#,
	    MedThreept = #med3pt#,
	    HiThreept  = #hi3pt#,
		Lotwopt  = #lo2pt#,
	    Medtwopt = #med2pt#,
	    Hitwopt  = #hi2pt#,
		Loother  = #loother#,
	    Medother = #medother#,
	    Hiother  = #hiother#,
		LoFTA  = #loFTA#,
	    MedFTA = #medFTA#,
	    HiFTA  = #hiFTA#
	    
	where team = '#GetTeams.Team#'
	and HA      = 'H'
	and OffDef  ='O' 
	</cfquery>    
	    
</cfloop>	    













<!--- Create Hi/Med/Lo values using Trimmed Mean and SD's --->
<cfloop query="GetTeams">

	<cfquery  datasource="nba" name="GetHomeInfo">
	Select * from NBAPower where team = '#GetTeams.Team#'
	and HA      = 'A'
	and OffDef  ='O'
	</cfquery>
	
	<!--- Create array of stats --->
	<cfset atwopt   = arraynew(1)>
	<cfset athreept = arraynew(1)>
	<cfset afga     = arraynew(1)>
	<cfset afta     = arraynew(1)>
	<cfset aother   = arraynew(1)>
	
	<cfset atwopt   = ListToArray(Valuelist(GetHomeInfo.twopt))>
	<cfset athreept = ListToArray(Valuelist(GetHomeInfo.threept))>
	<cfset afga     = ListToArray(Valuelist(GetHomeInfo.fga))>
	<cfset afta     = ListToArray(Valuelist(GetHomeInfo.fta))>
	<cfset aother   = ListToArray(Valuelist(GetHomeInfo.other))>
	
	
	<cfquery  datasource="nba" name="GetHomeInfoSD">
	Select * from NBAPowerSD where team = '#GetTeams.Team#'
	and HA      = 'A'
	and OffDef  ='O'
	</cfquery>
	
	
	<!--- Get Standard Deviations --->
	<cfinvoke method="getTrimmedMean" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #afga#	
	returnvariable  = "trimmedMeanFGA"			
	>
	<cfset lofga  = trimmedMeanFGA - GetHomeInfoSD.fga>
	<cfset hifga  = trimmedMeanFGA + GetHomeInfoSD.fga>
	<cfset medfga = (lofga + hifga)/2>

	<!--- Get Standard Deviations --->
	<cfinvoke method="getTrimmedMean" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #atwopt#	
	returnvariable  = "trimmedMean2pt"			
	>
	<cfset lo2pt  = trimmedMean2pt - GetHomeInfoSD.twopt>
	<cfset hi2pt  = trimmedMean2pt + GetHomeInfoSD.twopt>
	<cfset med2pt = (lo2pt + hi2pt)/2>

	<!--- Get Standard Deviations --->
	<cfinvoke method="getTrimmedMean" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #athreept#	
	returnvariable  = "trimmedMean3pt"			
	>
	<cfset lo3pt  = trimmedMean3pt - GetHomeInfoSD.threept>
	<cfset hi3pt  = trimmedMean3pt + GetHomeInfoSD.threept>
	<cfset med3pt = (lo3pt + hi3pt)/2>

	<!--- Get Standard Deviations --->
	<cfinvoke method="getTrimmedMean" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #afta#	
	returnvariable  = "trimmedMeanfta"			
	>
	<cfset lofta  = trimmedMeanfta - GetHomeInfoSD.fta>
	<cfset hifta  = trimmedMeanfta + GetHomeInfoSD.fta>
	<cfset medfta = (lofta + hifta)/2>

	<!--- Get Standard Deviations --->
	<cfinvoke method="getTrimmedMean" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #aother#	
	returnvariable  = "trimmedMeanother"			
	>
	<cfset loother  = trimmedMeanother - GetHomeInfoSD.other>
	<cfset hiother  = trimmedMeanother + GetHomeInfoSD.other>
	<cfset medother = (loother + hiother)/2>

	<cfquery  datasource="nba" name="Updateit">
	Update NBAPowerSD
	Set LoFGA  = #loFGA#,
	    MedFGA = #medFGA#,
	    HiFGA  = #hiFGA#,
		LoThreept  = #lo3pt#,
	    MedThreept = #med3pt#,
	    HiThreept  = #hi3pt#,
		Lotwopt  = #lo2pt#,
	    Medtwopt = #med2pt#,
	    Hitwopt  = #hi2pt#,
		Loother  = #loother#,
	    Medother = #medother#,
	    Hiother  = #hiother#,
		LoFTA  = #loFTA#,
	    MedFTA = #medFTA#,
	    HiFTA  = #hiFTA#
	    
	where team = '#GetTeams.Team#'
	and HA      = 'A'
	and OffDef  ='O' 
	</cfquery>    
	    
</cfloop>	    
































<!--- Create Hi/Med/Lo values using Trimmed Mean and SD's --->
<cfloop query="GetTeams">

	<cfquery  datasource="nba" name="GetHomeInfo">
	Select * from NBAPower where team = '#GetTeams.Team#'
	and HA      = 'H'
	and OffDef  ='D'
	</cfquery>
	
	<!--- Create array of stats --->
	<cfset atwopt   = arraynew(1)>
	<cfset athreept = arraynew(1)>
	<cfset afga     = arraynew(1)>
	<cfset afta     = arraynew(1)>
	<cfset aother   = arraynew(1)>
	
	<cfset atwopt   = ListToArray(Valuelist(GetHomeInfo.twopt))>
	<cfset athreept = ListToArray(Valuelist(GetHomeInfo.threept))>
	<cfset afga     = ListToArray(Valuelist(GetHomeInfo.fga))>
	<cfset afta     = ListToArray(Valuelist(GetHomeInfo.fta))>
	<cfset aother   = ListToArray(Valuelist(GetHomeInfo.other))>
	
	
	<cfquery  datasource="nba" name="GetHomeInfoSD">
	Select * from NBAPowerSD where team = '#GetTeams.Team#'
	and HA      = 'H'
	and OffDef  ='D'
	</cfquery>
	
	
	<!--- Get Standard Deviations --->
	<cfinvoke method="getTrimmedMean" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #afga#	
	returnvariable  = "trimmedMeanFGA"			
	>
	<cfset lofga  = trimmedMeanFGA - GetHomeInfoSD.fga>
	<cfset hifga  = trimmedMeanFGA + GetHomeInfoSD.fga>
	<cfset medfga = (lofga + hifga)/2>

	<!--- Get Standard Deviations --->
	<cfinvoke method="getTrimmedMean" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #atwopt#	
	returnvariable  = "trimmedMean2pt"			
	>
	<cfset lo2pt  = trimmedMean2pt - GetHomeInfoSD.twopt>
	<cfset hi2pt  = trimmedMean2pt + GetHomeInfoSD.twopt>
	<cfset med2pt = (lo2pt + hi2pt)/2>

	<!--- Get Standard Deviations --->
	<cfinvoke method="getTrimmedMean" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #athreept#	
	returnvariable  = "trimmedMean3pt"			
	>
	<cfset lo3pt  = trimmedMean3pt - GetHomeInfoSD.threept>
	<cfset hi3pt  = trimmedMean3pt + GetHomeInfoSD.threept>
	<cfset med3pt = (lo3pt + hi3pt)/2>

	<!--- Get Standard Deviations --->
	<cfinvoke method="getTrimmedMean" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #afta#	
	returnvariable  = "trimmedMeanfta"			
	>
	<cfset lofta  = trimmedMeanfta - GetHomeInfoSD.fta>
	<cfset hifta  = trimmedMeanfta + GetHomeInfoSD.fta>
	<cfset medfta = (lofta + hifta)/2>

	<!--- Get Standard Deviations --->
	<cfinvoke method="getTrimmedMean" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #aother#	
	returnvariable  = "trimmedMeanother"			
	>
	<cfset loother  = trimmedMeanother - GetHomeInfoSD.other>
	<cfset hiother  = trimmedMeanother + GetHomeInfoSD.other>
	<cfset medother = (loother + hiother)/2>

	<cfquery  datasource="nba" name="Updateit">
	Update NBAPowerSD
	Set LoFGA  = #loFGA#,
	    MedFGA = #medFGA#,
	    HiFGA  = #hiFGA#,
		LoThreept  = #lo3pt#,
	    MedThreept = #med3pt#,
	    HiThreept  = #hi3pt#,
		Lotwopt  = #lo2pt#,
	    Medtwopt = #med2pt#,
	    Hitwopt  = #hi2pt#,
		Loother  = #loother#,
	    Medother = #medother#,
	    Hiother  = #hiother#,
		LoFTA  = #loFTA#,
	    MedFTA = #medFTA#,
	    HiFTA  = #hiFTA#
	    
	where team = '#GetTeams.Team#'
	and HA      = 'H'
	and OffDef  ='D' 
	</cfquery>    
	    
</cfloop>	    













<!--- Create Hi/Med/Lo values using Trimmed Mean and SD's --->
<cfloop query="GetTeams">

	<cfquery  datasource="nba" name="GetHomeInfo">
	Select * from NBAPower where team = '#GetTeams.Team#'
	and HA      = 'A'
	and OffDef  ='D'
	</cfquery>
	
	<!--- Create array of stats --->
	<cfset atwopt   = arraynew(1)>
	<cfset athreept = arraynew(1)>
	<cfset afga     = arraynew(1)>
	<cfset afta     = arraynew(1)>
	<cfset aother   = arraynew(1)>
	
	<cfset atwopt   = ListToArray(Valuelist(GetHomeInfo.twopt))>
	<cfset athreept = ListToArray(Valuelist(GetHomeInfo.threept))>
	<cfset afga     = ListToArray(Valuelist(GetHomeInfo.fga))>
	<cfset afta     = ListToArray(Valuelist(GetHomeInfo.fta))>
	<cfset aother   = ListToArray(Valuelist(GetHomeInfo.other))>
	
	
	<cfquery  datasource="nba" name="GetHomeInfoSD">
	Select * from NBAPowerSD where team = '#GetTeams.Team#'
	and HA      = 'A'
	and OffDef  ='D'
	</cfquery>
	
	
	<!--- Get Standard Deviations --->
	<cfinvoke method="getTrimmedMean" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #afga#	
	returnvariable  = "trimmedMeanFGA"			
	>
	<cfset lofga  = trimmedMeanFGA - GetHomeInfoSD.fga>
	<cfset hifga  = trimmedMeanFGA + GetHomeInfoSD.fga>
	<cfset medfga = (lofga + hifga)/2>

	<!--- Get Standard Deviations --->
	<cfinvoke method="getTrimmedMean" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #atwopt#	
	returnvariable  = "trimmedMean2pt"			
	>
	<cfset lo2pt  = trimmedMean2pt - GetHomeInfoSD.twopt>
	<cfset hi2pt  = trimmedMean2pt + GetHomeInfoSD.twopt>
	<cfset med2pt = (lo2pt + hi2pt)/2>

	<!--- Get Standard Deviations --->
	<cfinvoke method="getTrimmedMean" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #athreept#	
	returnvariable  = "trimmedMean3pt"			
	>
	<cfset lo3pt  = trimmedMean3pt - GetHomeInfoSD.threept>
	<cfset hi3pt  = trimmedMean3pt + GetHomeInfoSD.threept>
	<cfset med3pt = (lo3pt + hi3pt)/2>

	<!--- Get Standard Deviations --->
	<cfinvoke method="getTrimmedMean" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #afta#	
	returnvariable  = "trimmedMeanfta"			
	>
	<cfset lofta  = trimmedMeanfta - GetHomeInfoSD.fta>
	<cfset hifta  = trimmedMeanfta + GetHomeInfoSD.fta>
	<cfset medfta = (lofta + hifta)/2>

	<!--- Get Standard Deviations --->
	<cfinvoke method="getTrimmedMean" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #aother#	
	returnvariable  = "trimmedMeanother"			
	>
	<cfset loother  = trimmedMeanother - GetHomeInfoSD.other>
	<cfset hiother  = trimmedMeanother + GetHomeInfoSD.other>
	<cfset medother = (loother + hiother)/2>

	<cfquery  datasource="nba" name="Updateit">
	Update NBAPowerSD
	Set LoFGA  = #loFGA#,
	    MedFGA = #medFGA#,
	    HiFGA  = #hiFGA#,
		LoThreept  = #lo3pt#,
	    MedThreept = #med3pt#,
	    HiThreept  = #hi3pt#,
		Lotwopt  = #lo2pt#,
	    Medtwopt = #med2pt#,
	    Hitwopt  = #hi2pt#,
		Loother  = #loother#,
	    Medother = #medother#,
	    Hiother  = #hiother#,
		LoFTA  = #loFTA#,
	    MedFTA = #medFTA#,
	    HiFTA  = #hiFTA#
	    
	where team = '#GetTeams.Team#'
	and HA      = 'A'
	and OffDef  ='D' 
	</cfquery>    
	    
</cfloop>	    
	

<cfquery datasource="nba" name="Getspds">
Select *
from nbaschedule
where GameTime = '#mygametime#'
 </cfquery>

<cfoutput query="GetSpds">

	<cfset fav           = '#GetSpds.Fav#'> 
	<cfset und           = '#GetSpds.Und#'>
	<cfset ha            = '#GetSpds.ha#'>
	<cfset Client.spread = #GetSpds.spd#>
	<cfset myou          = #GetSpds.ou#>  
	<cfset overct        = 0>

<cfif ha is 'H'>
<cfset undha = 'A'>
<cfelse>
<cfset undha = 'H'>
</cfif>


<cfquery datasource="Nba" name="GetFavDef">
	Select *  from NBAPowerSD
	where team = '#fav#'
	and OffDef = 'D'
	and ha = '#ha#'
</cfquery>

<cfquery datasource="Nba" name="GetUndOff">
	Select *  from NBAPowerSD
	where team = '#Und#'
	and OffDef = 'O'
	and ha = '#undha#'
</cfquery>


<cfset UndFGA    = (GetFavDef.MedFGA + GetUndOff.MedFGA)/2>
<cfset Und2ptPct = (GetFavDef.MedTwoPt + GetUndOff.MedTwoPt)/2>
<cfset Und3ptPct = (GetFavDef.MedThreePt + GetUndOff.MedThreePt)/2>
<cfset UndFTA    = (GetFavDef.MedFTA + GetUndOff.MedFTA)/2>



<cfquery datasource="Nba" name="GetFavOff">
	Select *  from NBAPowerSD
	where team = '#fav#'
	and OffDef = 'O'
	and ha = '#ha#'
</cfquery>

<cfquery datasource="Nba" name="GetUndDef">
	Select *  from NBAPowerSD
	where team = '#Und#'
	and OffDef = 'D'
	and ha = '#undha#'
</cfquery>


<cfquery datasource="Nba" name="GetFTPct">
	Select Avg(df.oftpct)/100 as fftpct,Avg(du.oftpct)/100 as uftpct
	from NBAData df, NBAData du
	where du.team = '#Und#'
	and df.team = '#fav#'
</cfquery>




<cfset FavFGA    = (GetUndDef.MedFGA + GetFavOff.MedFGA)/2>
<cfset Fav2ptPct = (GetUndDef.MedTwoPt + GetFavOff.MedTwoPt)/2>
<cfset Fav3ptPct = (GetUndDef.MedThreePt + GetFavOff.MedThreePt)/2>
<cfset FavFTA    = (GetUndDef.MedFTA + GetFavOff.MedFTA)/2>

<cfset FavPred2pt = 2*(FavFGA*(Fav2ptPct/100))>
<cfset FavPred3pt = 3*(FavFGA*(Fav3ptPct/100))>
<cfset FavPredFT  = 1*(FavFTA*GetFTPct.fftpct)>
<cfset FavFinal = FavPred2pt + FavPred3pt + FavPredFT >

<cfset UndPred2pt = 2*(UndFGA*(Und2ptPct/100))>
<cfset UndPred3pt = 3*(UndFGA*(Und3ptPct/100))>
<cfset UndPredFT  = 1*(UndFTA*GetFtPct.Uftpct)>
<cfset UndFinal = UndPred2pt + UndPred3pt + UndPredFT >

<hr>

#fav#: #FavFinal#<br>
#Und# #UndFinal#<br>
#favfinal - undfinal#....#spd#<br>
#favfinal + undfinal#<br>
<cfif abs(GetSpds.spd - (favfinal - undfinal)) ge 4>
****** Potential Play<br>
</cfif>

<cfif abs(GetSpds.spd - (favfinal - undfinal)) ge 6>
****** Super Potential Play<br>
</cfif>

<hr>
</cfoutput>

