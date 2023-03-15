<cfif 1 is 1>

<cftry>

<cfquery datasource="Nba" name="GetOff">
	Select Team,Avg(oFga) - (Avg(oReb) + Avg(odreb) + Avg(dturnovers)) as baseFGA, (Avg(oReb) + Avg(odreb) + Avg(dturnovers)) as ExtraPoss,
	Avg(oreb) as OffReb, Avg(odreb) as OffDefReb,Avg(dreb) as DefReb, Avg(ddreb) as DefDefReb,
	Avg(oPIP) as oInsidePct,Avg(dPIP) as dInsidePct,
	Avg(oFTA) as oEasyPct,
	Avg(dFTA) as dEasyPct
	from NBAData
	Group By Team
</cfquery>

<cfquery datasource="Nba" name="GetDef">
	Select Team,Avg(dFga) - (Avg(dReb) + Avg(ddreb) + Avg(oturnovers)) as baseFGA, (Avg(dReb) + Avg(ddreb) + Avg(oturnovers)) as ExtraPoss
	from NBAData
	Group By Team
</cfquery>

<cfoutput query="GetOff">
<cfquery datasource="Nba" name="xGetDef">
	Update NBAAvgs
	Set obaseFGA = #GetOff.baseFGA#,
	oextraPoss = #GetOff.ExtraPoss#,
	oOreb = #GetOff.OffReb#,
	oDreb = #GetOff.OffDefReb#,
	dOreb = #GetOff.DefReb#,
	dDreb = #GetOff.DefDefReb#,
	oInsidePct = #GetOff.oInsidePct#,
	dInsidePct = #GetOff.dInsidePct#,
	oEasyPtPct = #GetOff.oEasyPct#,
	dEasyPtPct = #GetOff.dEasyPct#
	Where Team = '#GetOff.Team#'
</cfquery>
</cfoutput>

<cfoutput query="GetDef">
<cfquery datasource="Nba" name="xGetDef">
	Update NBAAvgs
	Set dbaseFGA = #GetDef.baseFGA#,
		dextraPoss = #GetDef.ExtraPoss#
	Where Team = '#GetDef.Team#'
</cfquery>
</cfoutput>



<cfquery datasource="Nba" name="GetRunct">
	Delete from PowerSD
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

<!--- Create the standard deviations for the values --->
<cfquery  datasource="nba" name="GetTeams">
Select Distinct Team
from NBAData
</cfquery>



<cfloop query="GetTeams">


	Running for.....#GetTeams.Team#<br>

	<cfquery  datasource="nba" name="GetHomeInfo">
	Select * from Power where team = '#GetTeams.Team#'
	and HA      = 'H'
	</cfquery>
	
	
	<cfdump var="#GetHomeInfo#">
	
	
	
	<!--- Create array of stats --->
	<cfset aofga      = arraynew(1)>
	<cfset adfga      = arraynew(1)>
	
	<cfset aoreb      = arraynew(1)>
	<cfset adreb      = arraynew(1)>
	
	<cfset aotpa      = arraynew(1)>
	<cfset adtpa      = arraynew(1)>
	
	<cfset aofta      = arraynew(1)>
	<cfset adfta      = arraynew(1)>
	
	<cfset aofgpct    = arraynew(1)>
	<cfset adfgpct    = arraynew(1)>

	<cfset aotppct    = arraynew(1)>
	<cfset adtppct    = arraynew(1)>
	
	<cfset aoturnover = arraynew(1)>
	<cfset adturnover = arraynew(1)>
	
	<cfset hiaofta    = arraynew(1)>
	<cfset loaofta    = arraynew(1)>

	<cfset hiadfta    = arraynew(1)>
	<cfset loadfta    = arraynew(1)>

	<cfset hiaotpa    = arraynew(1)>
	<cfset loaotpa    = arraynew(1)>

	<cfset hiadtpa    = arraynew(1)>
	<cfset loadtpa    = arraynew(1)>

	<cfset hiafga    = arraynew(1)>
	<cfset loafga    = arraynew(1)>

	<cfset hiadfga    = arraynew(1)>
	<cfset loadfga    = arraynew(1)>
	
	<cfset hiafgpct    = arraynew(1)>
	<cfset loafgpct    = arraynew(1)>

	<cfset hiadfgpct    = arraynew(1)>
	<cfset loadfgpct    = arraynew(1)>

	<cfset hiatppct    = arraynew(1)>
	<cfset loatppct    = arraynew(1)>

	<cfset hiadtppct    = arraynew(1)>
	<cfset loadtppct    = arraynew(1)>

	
	<cfset hiaoreb = arraynew(1)>
	<cfset loaoreb = arraynew(1)>
	
	<cfset hiadreb = arraynew(1)>
	<cfset loadreb = arraynew(1)>

	<cfset hiaturnover = arraynew(1)>
	<cfset loaturnover = arraynew(1)>
	
	<cfset hiadturnover = arraynew(1)>
	<cfset loadturnover = arraynew(1)>

	<cfset loaofgpct = arraynew(1)>
	<cfset HIAOTPPCT = arraynew(1)>
	<cfset HIAOFGA = arraynew(1)>

	<cfset loaoturnover = arraynew(1)>

	<cfset aofta    = ListToArray(Valuelist(GetHomeInfo.ofta))>
	<cfset adfta    = ListToArray(Valuelist(GetHomeInfo.dfta))>


	Free Throw

	<cfset hi = 0>
	<cfset lo = 0>
	<cfloop index="ii" from="1" to="#arraylen(aofta)#">
		<cfif aofta[ii] gt 0>
			<cfset hi = hi + 1>	
			<cfset hiaofta[hi] = aofta[ii]>
		<cfelseif aofta[ii] neq 0>
			<cfset lo = lo + 1>	
			<cfset loaofta[lo] = aofta[ii]>
		</cfif>
	</cfloop>	
	
	<cfif #arraylen(aofta)# neq 0>
		<cfset hifta = hi/ #arraylen(aofta)#>
		<cfset lofta = lo/ #arraylen(aofta)#>
	<cfelse>
		<cfset hifta = 0>
		<cfset lofta = 0>
	</cfif>

	<cfset hi = 0>
	<cfset lo = 0>
	<cfloop index="ii" from="1" to="#arraylen(adfta)#">
		<cfif adfta[ii] gt 0>
			<cfset hi = hi + 1>	
			<cfset hiadfta[hi] = adfta[ii]>
		<cfelseif adfta[ii] neq 0 >
			<cfset lo = lo + 1>	
			<cfset loadfta[lo] = adfta[ii]>
		</cfif>
	</cfloop>	
	
	<cfif #arraylen(adfta)# neq 0>
		<cfset hidfta = hi/ #arraylen(adfta)#>
		<cfset lodfta = lo/ #arraylen(adfta)#>
	</cfif>
	
	
	<cfoutput>
	#hidfta#<br>
	#lodfta#<br>
	
	</cfoutput>
	
	
	
	
	
	FGA

	<cfset aofga    = ListToArray(Valuelist(GetHomeInfo.ofga))>
	<cfset adfga    = ListToArray(Valuelist(GetHomeInfo.dfga))>	
	
	<cfset hi = 0>
	<cfset lo = 0>
	<cfloop index="ii" from="1" to="#arraylen(aofga)#">
		<cfif aofga[ii] gt 0>
			<cfset hi = hi + 1>	
			<cfset hiaofga[hi] = aofga[ii]>
		<cfelseif aofga[ii] neq 0 >
			<cfset lo = lo + 1>	
			<cfset loaofga[lo] = aofga[ii]>
		</cfif>
	</cfloop>
	<cfif #arraylen(adfta)# neq 0>	
		<cfset hifga = hi/ #arraylen(aofga)#>
		<cfset lofga = lo/ #arraylen(aofga)#>
	</cfif>

	<cfoutput>
	#hifga#<br>
	#lofga#<br>
	
	</cfoutput>
	
	




	<cfset hi = 0>
	<cfset lo = 0>
	<cfloop index="ii" from="1" to="#arraylen(adfga)#">
		<cfif adfga[ii] gt 0>
			<cfset hi = hi + 1>	
			<cfset hiadfga[hi] = adfga[ii]>
		<cfelseif adfga[ii] neq 0>
			<cfset lo = lo + 1>	
			<cfset loadfga[lo] = adfga[ii]>
		</cfif>
	</cfloop>	
	
	<cfif #arraylen(adfga)# neq 0>
		<cfset hidfga = hi/ #arraylen(adfga)#>
		<cfset lodfga = lo/ #arraylen(adfga)#>
		
	</cfif>

	Def FGA<br>
	<cfoutput>
	#hidfga#<br>
	#lodfga#<br>
	
	</cfoutput>

	
	Reb
	
	<cfset aoreb    = ListToArray(Valuelist(GetHomeInfo.offreb))>
	<cfset adreb    = ListToArray(Valuelist(GetHomeInfo.defreb))>

	<cfset hi = 0>
	<cfset lo = 0>
	<cfloop index="ii" from="1" to="#arraylen(aoreb)#">
		<cfif aoreb[ii] gt 0>
			<cfset hi = hi + 1>	
			<cfset hiaoreb[hi] = aoreb[ii]>
		<cfelseif aoreb[ii] neq 0>
			<cfset lo = lo + 1>	
			<cfset loaoreb[lo] = aoreb[ii]>
		</cfif>
	</cfloop>
	
	<cfif #arraylen(aoreb)# neq 0>	
		<cfset hireb = hi/ #arraylen(aoreb)#>
		<cfset loreb = lo/ #arraylen(aoreb)#>
	</cfif>

	Reb<br>
	<cfoutput>
	#hireb#<br>
	#loreb#<br>
	
	</cfoutput>


	<cfset hi = 0>
	<cfset lo = 0>
	<cfloop index="ii" from="1" to="#arraylen(adreb)#">
		<cfif adreb[ii] gt 0>
			<cfset hi = hi + 1>	
			<cfset hiadreb[hi] = adreb[ii]>
		<cfelseif adreb[ii] neq 0>
			<cfset lo = lo + 1>	
			<cfset loadreb[lo] = adreb[ii]>
		</cfif>
	</cfloop>	
	
	<cfif #arraylen(adreb)# neq 0>
		<cfset hidreb = hi/ #arraylen(adreb)#>
		<cfset lodreb = lo/ #arraylen(adreb)#>
	</cfif>

	Def FGA<br>
	<cfoutput>
	#hidfga#<br>
	#lodfga#<br>
	
	</cfoutput>



	TPA


	<cfset aotpa    = ListToArray(Valuelist(GetHomeInfo.otpa))>
	<cfset adtpa    = ListToArray(Valuelist(GetHomeInfo.dtpa))>

	<cfset hi = 0>
	<cfset lo = 0>
	<cfloop index="ii" from="1" to="#arraylen(aotpa)#">
		<cfif aotpa[ii] gt 0>
			<cfset hi = hi + 1>	
			<cfset hiaotpa[hi] = aotpa[ii]>
		<cfelseif aotpa[ii] neq 0>
			<cfset lo = lo + 1>	
			<cfset loaotpa[lo] = aotpa[ii]>
		</cfif>
	</cfloop>
	
	<cfif #arraylen(aotpa)# neq 0>	
		<cfset hitpa = hi/ #arraylen(aotpa)#>
		<cfset lotpa = lo/ #arraylen(aotpa)#>
	</cfif>

	
	<cfoutput>
	#hitpa#<br>
	#lotpa#<br>
	
	</cfoutput>



	<cfset hi = 0>
	<cfset lo = 0>
	<cfloop index="ii" from="1" to="#arraylen(adtpa)#">
		<cfif adtpa[ii] gt 0>
			<cfset hi = hi + 1>	
			<cfset hiadtpa[hi] = adtpa[ii]>
		<cfelseif adtpa[ii] neq 0 >
			<cfset lo = lo + 1>	
			<cfset loadtpa[lo] = adtpa[ii]>
		</cfif>
	</cfloop>
	
	<cfif #arraylen(adtpa)# neq 0>	
		<cfset hidtpa = hi/ #arraylen(adtpa)#>
		<cfset lodtpa = lo/ #arraylen(adtpa)#>
	</cfif>


	<cfoutput>
	#hidtpa#<br>
	#lodtpa#<br>
	
	</cfoutput>



	FGPCT


	<cfset aofgpct    = ListToArray(Valuelist(GetHomeInfo.ofgpct))>
	<cfset adfgpct    = ListToArray(Valuelist(GetHomeInfo.dfgpct))>

	<cfset hi = 0>
	<cfset lo = 0>
	<cfloop index="ii" from="1" to="#arraylen(aofgpct)#">
		<cfif aofgpct[ii] gt 0>
			<cfset hi = hi + 1>	
			<cfset hiaofgpct[hi] = aofgpct[ii]>
		<cfelseif aofgpct[ii] neq 0 >
			<cfset lo = lo + 1>	
			<cfset loaofgpct[lo] = aofgpct[ii]>
		</cfif>
	</cfloop>
	
	<cfif #arraylen(aofgpct)# neq 0>	
		<cfset hifgpct = hi/ #arraylen(aofgpct)#>
		<cfset lofgpct = lo/ #arraylen(aofgpct)#>
	</cfif>

	<cfoutput>
	#hifgpct#<br>
	#lofgpct#<br>
	
	</cfoutput>


	DFGPct

	<cfset hi = 0>
	<cfset lo = 0>
	<cfloop index="ii" from="1" to="#arraylen(adfgpct)#">
		<cfif adfgpct[ii] gt 0>
			<cfset hi = hi + 1>	
			<cfset hiadfgpct[hi] = adfgpct[ii]>
		<cfelseif adfgpct[ii] neq 0 >
			<cfset lo = lo + 1>	
			<cfset loadfgpct[lo] = adfgpct[ii]>
		</cfif>
	</cfloop>
	
	<cfif #arraylen(adfgpct)# neq 0>	
		<cfset hidfgpct = hi/ #arraylen(adfgpct)#>
		<cfset lodfgpct = lo/ #arraylen(adfgpct)#>
	</cfif>

	<cfoutput>
	#hidfgpct#<br>
	#lodfgpct#<br>
	
	</cfoutput>



	3pt Pct

	<cfset aotppct    = ListToArray(Valuelist(GetHomeInfo.otppct))>
	<cfset adtppct    = ListToArray(Valuelist(GetHomeInfo.dtppct))>

	<cfset hi = 0>
	<cfset lo = 0>
	<cfloop index="ii" from="1" to="#arraylen(aotppct)#">
		<cfif aotppct[ii] gt 0>
			<cfset hi = hi + 1>	
			<cfset hiaotppct[hi] = aotppct[ii]>
		<cfelseif aotppct[ii] neq 0>
			<cfset lo = lo + 1>	
			<cfset loaotppct[lo] = aotppct[ii]>
		</cfif>
	</cfloop>
	
	<cfif #arraylen(aotppct)# neq 0>	
		<cfset hitppct = hi/ #arraylen(aotppct)#>
		<cfset lotppct = lo/ #arraylen(aotppct)#>
	</cfif>

	<cfoutput>
	#hitppct#<br>
	#lotppct#<br>
	
	</cfoutput>




	<cfset hi = 0>
	<cfset lo = 0>
	<cfloop index="ii" from="1" to="#arraylen(adtppct)#">
		<cfif adtppct[ii] gt 0>
			<cfset hi = hi + 1>	
			<cfset hiadtppct[hi] = adtppct[ii]>
		<cfelseif adtppct[ii] neq 0>
			<cfset lo = lo + 1>	
			<cfset loadtppct[lo] = adtppct[ii]>
		</cfif>
	</cfloop>
	
	<cfif #arraylen(adtppct)# neq 0>	
		<cfset hidtppct = hi/ #arraylen(adtppct)#>
		<cfset lodtppct = lo/ #arraylen(adtppct)#>
	</cfif>

	def 3pt pct

	<cfoutput>
	#hidtppct#<br>
	#lodtppct#<br>
	
	</cfoutput>


	Turnovers

	<cfset aoturnover    = ListToArray(Valuelist(GetHomeInfo.oturnovers))>
	<cfset adturnover    = ListToArray(Valuelist(GetHomeInfo.dturnovers))>



	<cfset hi = 0>
	<cfset lo = 0>
	<cfloop index="ii" from="1" to="#arraylen(aoturnover)#">
		<cfif aoturnover[ii] gt 0>
			<cfset hi = hi + 1>	
			<cfset hiaoturnover[hi] = aoturnover[ii]>
		<cfelseif aoturnover[ii] neq 0 >
			<cfset lo = lo + 1>	
			<cfset loaoturnover[lo] = aoturnover[ii]>
		</cfif>
	</cfloop>


get gere <cfabort>
	

	<cfif #arraylen(aoturnover)# neq 0>	
		<cfset hiturnover = hi/ #arraylen(aoturnover)#>
		<cfset loturnover = lo/ #arraylen(aoturnover)#>
	</cfif>

	<cfoutput>
	#hiturnover#<br>
	#lotturnover#<br>
	
	</cfoutput>


	<cfset hi = 0>
	<cfset lo = 0>
	<cfloop index="ii" from="1" to="#arraylen(adturnover)#">
		<cfif adturnover[ii] gt 0>
			<cfset hi = hi + 1>	
			<cfset hiadturnover[hi] = adturnover[ii]>
		<cfelseif adturnover[ii] neq 0>
			<cfset lo = lo + 1>	
			<cfset loadturnover[lo] = adturnover[ii]>
		</cfif>
	</cfloop>
	
	
	
	
	<cfif #arraylen(adturnover)# neq 0>	
		<cfset hidturnover = hi/ #arraylen(adturnover)#>
		<cfset lodturnover = lo/ #arraylen(adturnover)#>
	</cfif>

	Def Turnovers
	<cfoutput>
	#hidturnover#<br>
	#lodturnover#<br>
	
	</cfoutput>

	
	
	<cfset hisdFGA = 0>
	
	<cfif arraylen(hiaofga) gt 0>
	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #hiaofga#	
	returnvariable  = "hisdFGA"			
	>
	</cfif>


	<cfset losdFGA = 0>
	<cfif arraylen(loaofga) gt 0>
	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #loaofga#	
	returnvariable  = "losdFGA"			
	>
	</cfif>

	<cfset hisddFGA = 0>
	<cfif arraylen(hiadfga) gt 0>
	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #hiadfga#	
	returnvariable  = "hisddFGA"			
	>
	</cfif>


	<cfset losddFGA = 0>
	<cfif arraylen(loadfga) gt 0>
	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #loadfga#	
	returnvariable  = "losddFGA"			
	>
	</cfif>


	<cfdump var="#hiaoTpa#">


	<cfset hisdTPA = 0>
	<cfif arraylen(hiaoTPA) gt 0>
	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #hiaoTpa#	
	returnvariable  = "hisdTPA"			
	>
	</cfif>

	<cfset losdTPA = 0>
	<cfif arraylen(loaoTPA) gt 0>
	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #loaoTpa#	
	returnvariable  = "losdTPA"			
	>
	</cfif>


	<cfset hisddTPA = 0>
	<cfif arraylen(hiadTPA) gt 0>
	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #hiadTpa#	
	returnvariable  = "hisddTPA"			
	>
	</cfif>


	<cfset losddTPA = 0>
	<cfif arraylen(loadTPA) gt 0>
	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #loadTpa#	
	returnvariable  = "losddTPA"			
	>
	</cfif>





	<cfset hisdFTA = 0>
	<cfif arraylen(hiaofta) gt 0>

	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #hiaofta#	
	returnvariable  = "hisdFtA"			
	>
	</cfif>


	<cfset losdFTA = 0>
	<cfif arraylen(loaofta) gt 0>

	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #loaofta#	
	returnvariable  = "losdFtA"			
	>
	</cfif>



	<cfset hisddFTA = 0>
	<cfif arraylen(hiadfta) gt 0>

	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #hiadfta#	
	returnvariable  = "hisddFtA"			
	>
	</cfif>



	<cfset losddFTA = 0>
	<cfif arraylen(loadfta) gt 0>

	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #loadfta#	
	returnvariable  = "losddFtA"			
	>
	</cfif>




	<cfset hisdturnover = 0>
	<cfif arraylen(hiaoturnover) gt 0>
	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #hiaoturnover#	
	returnvariable  = "hisdturnover"			
	>
	</cfif>

	<cfset losdturnover = 0>
	<cfif arraylen(loaoturnover) gt 0>
	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #loaoturnover#	
	returnvariable  = "losdturnover"			
	>
	</cfif>

	<cfset hisddturnover = 0>
	<cfif arraylen(hiadturnover) gt 0>

	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #hiadturnover#	
	returnvariable  = "hisddturnover"			
	>
	</cfif>

	<cfset losddturnover = 0>
	<cfif arraylen(loadturnover) gt 0>

	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #loadturnover#	
	returnvariable  = "losddturnover"			
	>
	</cfif>


	<cfset hisdfgpct = 0>
	<cfif arraylen(hiaofgpct) gt 0>

	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #hiaofgpct#	
	returnvariable  = "hisdFGpct"			
	>
	</cfif>


	<cfset losdfgpct = 0>
	<cfif arraylen(loaofgpct) gt 0>

	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #loaofgpct#	
	returnvariable  = "losdFGpct"			
	>
	</cfif>



	<cfset hisddfgpct = 0>
	<cfif arraylen(hiadfgpct) gt 0>

	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #hiadfgpct#	
	returnvariable  = "hisddFGpct"			
	>
	</cfif>


	<cfset losddfgpct = 0>
	<cfif arraylen(loadfgpct) gt 0>

	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #loadfgpct#	
	returnvariable  = "losddFGpct"			
	>
	</cfif>




	<cfset hisdOreb = 0>
	<cfif arraylen(hiaoreb) gt 0>

	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #hiaoreb#	
	returnvariable  = "hisdOreb"			
	>
	</cfif>


	<cfset losdOreb = 0>
	<cfif arraylen(loaoreb) gt 0>
	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #loaoreb#	
	returnvariable  = "losdOreb"			
	>
	</cfif>



	<cfset hisddReb = 0>
	<cfif arraylen(hiadreb) gt 0>

	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #hiadreb#	
	returnvariable  = "hisddReb"			
	>
	</cfif>

	<cfset losddReb = 0>
	<cfif arraylen(loadreb) gt 0>

	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #loadreb#	
	returnvariable  = "losddReb"			
	>
	</cfif>




	<cfset hisdTPpct = 0>
	<cfif arraylen(hiaotppct) gt 0>

	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #hiaotppct#	
	returnvariable  = "hisdTPpct"			
	>
	</cfif>

	<cfset losdTPpct = 0>
	<cfif arraylen(loaotppct) gt 0>

	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #loaotppct#	
	returnvariable  = "losdTPpct"			
	>
	</cfif>



	<cfset hisddTPpct = 0>
	<cfif arraylen(hiadtppct) gt 0>

	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #hiadtppct#	
	returnvariable  = "hisddTPpct"			
	>
	</cfif>


	<cfset losddTPpct = 0>
	<cfif arraylen(loadtppct) gt 0>

	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #loadtppct#	
	returnvariable  = "losddTPpct"			
	>
	</cfif>
	


	<cfquery  datasource="nba" name="addit">
			insert into PowerSD(Team,Ha,oreb,dreb,ofga,dfga,otpa,dtpa,ofta,dfta,ofgpct,dfgpct,otppct,dtppct,oturnovers,dturnovers,
			hireb,hidreb,hifga,hidfga,hitpa,hidtpa,hifta,hidfta,hifgpct,hidfgpct,hitppct,hidtppct,hiturnover,hidturnover,
			lo_oreb,lo_dreb,lo_ofga,lo_dfga,lo_otpa,lo_dtpa,lo_ofta,lo_dfta,lo_ofgpct,lo_dfgpct,lo_otppct,lo_dtppct,lo_oturnovers,lo_dturnovers,
			loreb,lodreb,lofga,lodfga,lotpa,lodtpa,lofta,lodfta,lofgpct,lodfgpct,lotppct,lodtppct,loturnover,lodturnover
			)
			values
			(
			'#GetTeams.Team#','H',#hisdoreb#,#hisddreb#,#hisdfga#,#hisddfga#,#hisdtpa#,#hisddtpa#,#hisdfta#,#hisddfta#,#hisdfgpct#,#hisddfgpct#,#hisdtppct#,#hisddtppct#,#hisdturnover#,#hisddturnover#,
			#hireb#,#hidreb#,#hifga#,#hidfga#,#hitpa#,#hidtpa#,#hifta#,#hidfta#,#hifgpct#,#hidfgpct#,#hitppct#,#hidtppct#,#hiturnover#,#hidturnover#,
			#losdoreb#,#losddreb#,#losdfga#,#losddfga#,#losdtpa#,#losddtpa#,#losdfta#,#losddfta#,#losdfgpct#,#losddfgpct#,#losdtppct#,#losddtppct#,#losdturnover#,#losddturnover#,
			#loreb#,#lodreb#,#lofga#,#lodfga#,#lotpa#,#lodtpa#,#lofta#,#lodfta#,#lofgpct#,#lodfgpct#,#lotppct#,#lodtppct#,#loturnover#,#lodturnover#
			)
			
	</cfquery>




</cfloop>





<cfloop query="GetTeams">

	<cfquery  datasource="nba" name="GetHomeInfo">
	Select * from Power where team = '#GetTeams.Team#'
	and HA      = 'A'
	</cfquery>
	
	<!--- Create array of stats --->
	<cfset aofga      = arraynew(1)>
	<cfset adfga      = arraynew(1)>
	
	<cfset aoreb      = arraynew(1)>
	<cfset adreb      = arraynew(1)>
	
	<cfset aotpa      = arraynew(1)>
	<cfset adtpa      = arraynew(1)>
	
	<cfset aofta      = arraynew(1)>
	<cfset adfta      = arraynew(1)>
	
	<cfset aofgpct    = arraynew(1)>
	<cfset adfgpct    = arraynew(1)>

	<cfset aotppct    = arraynew(1)>
	<cfset adtppct    = arraynew(1)>
	
	<cfset aoturnover = arraynew(1)>
	<cfset adturnover = arraynew(1)>
	
	<cfset aofta    = ListToArray(Valuelist(GetHomeInfo.ofta))>
	<cfset adfta    = ListToArray(Valuelist(GetHomeInfo.dfta))>


	Free Throw

	<cfset hi = 0>
	<cfset lo = 0>
	<cfloop index="ii" from="1" to="#arraylen(aofta)#">
		<cfif aofta[ii] gt 0>
			<cfset hi = hi + 1>	
		<cfelseif aofta[ii] neq 0 >
			<cfset lo = lo + 1>
		</cfif>
	</cfloop>	
	
	<cfif #arraylen(adfta)# neq 0>
		<cfset hifta = hi/ #arraylen(aofta)#>
		<cfset lofta = lo/ #arraylen(aofta)#>
	</cfif>
	
	<cfset lo = 0>
	<cfset hi = 0>
	<cfloop index="ii" from="1" to="#arraylen(adfta)#">
		<cfif adfta[ii] gt 0>
			<cfset hi = hi + 1>	
		<cfelseif adfta[ii] neq 0>
			<cfset lo = lo + 1>
		</cfif>
		
	</cfloop>
	
	<cfif #arraylen(adfta)# neq 0>	
		<cfset hidfta = hi/ #arraylen(adfta)#>
		<cfset lodfta = lo/ #arraylen(adfta)#>
	</cfif>
	
	
	FGA

	<cfset aofga    = ListToArray(Valuelist(GetHomeInfo.ofga))>
	<cfset adfga    = ListToArray(Valuelist(GetHomeInfo.dfga))>	
	
	<cfset lo = 0>
	<cfset hi = 0>
	<cfloop index="ii" from="1" to="#arraylen(aofga)#">
		<cfif aofga[ii] gt 0>
			<cfset hi = hi + 1>	
		<cfelseif aofga[ii] neq 0 >
			<cfset lo = lo + 1>
		</cfif>
		
	</cfloop>
	
	<cfif #arraylen(adfta)# neq 0>	
		<cfset hifga = hi/ #arraylen(aofga)#>
		<cfset lofga = lo/ #arraylen(aofga)#>
	</cfif>

	<cfset lo = 0>
	<cfset hi = 0>
	<cfloop index="ii" from="1" to="#arraylen(adfga)#">
		<cfif adfga[ii] gt 0>
			<cfset hi = hi + 1>	
		<cfelseif adfga[ii] neq 0 >
			<cfset lo = lo + 1>
		</cfif>
	</cfloop>
	
	<cfif #arraylen(adfta)# neq 0>	
		<cfset hidfga = hi/ #arraylen(adfga)#>
		<cfset lodfga = lo/ #arraylen(adfga)#>
	</cfif>




	Reb
	
	<cfset aoreb    = ListToArray(Valuelist(GetHomeInfo.offreb))>
	<cfset adreb    = ListToArray(Valuelist(GetHomeInfo.defreb))>

	<cfset lo = 0>
	<cfset hi = 0>
	<cfloop index="ii" from="1" to="#arraylen(aoreb)#">
		<cfif aoreb[ii] gt 0>
			<cfset hi = hi + 1>	
		<cfelseif aoreb[ii] neq 0 >
			<cfset lo = lo + 1>
		</cfif>
		
	</cfloop>
	
	<cfif #arraylen(adfta)# neq 0>	
		<cfset hireb = hi/ #arraylen(aoReb)#>
		<cfset loreb = lo/ #arraylen(aoReb)#>
	</cfif>

	<cfset hi = 0>
	<cfset lo = 0>
	<cfloop index="ii" from="1" to="#arraylen(adReb)#">
		<cfif adReb[ii] gt 0>
			<cfset hi = hi + 1>	
		<cfelseif adReb[ii] neq 0 >
			<cfset lo = lo + 1>
		</cfif>
	</cfloop>
	
	<cfif #arraylen(adfta)# neq 0>	
		<cfset hidReb = hi/ #arraylen(adReb)#>
		<cfset lodReb = lo/ #arraylen(adReb)#>
	</cfif>


	TPA


	<cfset aotpa    = ListToArray(Valuelist(GetHomeInfo.otpa))>
	<cfset adtpa    = ListToArray(Valuelist(GetHomeInfo.dtpa))>


	<cfset hi = 0>
	<cfset lo = 0>
	
	<cfloop index="ii" from="1" to="#arraylen(aotpa)#">
		<cfif aotpa[ii] gt 0>
			<cfset hi = hi + 1>	
		<cfelseif aotpa[ii] neq 0>
			<cfset lo = lo + 1>
		</cfif>
		
	</cfloop>
	
	<cfif #arraylen(adfta)# neq 0>	
		<cfset hitpa = hi/ #arraylen(aoTpa)#>
		<cfset lotpa = lo/ #arraylen(aoTpa)#>
	</cfif>

	<cfset hi = 0>
	<cfset lo = 0>
	<cfloop index="ii" from="1" to="#arraylen(adTpa)#">
		<cfif adTpa[ii] gt 0>
			<cfset hi = hi + 1>	
		<cfelseif adTpa[ii] neq 0>
			<cfset lo = lo + 1>
		</cfif>
	</cfloop>
	
	<cfif #arraylen(adfta)# neq 0>	
		<cfset hidTpa = hi/ #arraylen(adTpa)#>
		<cfset lodTpa = lo/ #arraylen(adTpa)#>
	</cfif>
	
	FGPCT


	<cfset aofgpct    = ListToArray(Valuelist(GetHomeInfo.ofgpct))>
	<cfset adfgpct    = ListToArray(Valuelist(GetHomeInfo.dfgpct))>

	<cfset hi = 0>
	<cfset lo = 0>
		
	<cfloop index="ii" from="1" to="#arraylen(aofgpct)#">
		<cfif aofgpct[ii] gt 0>
			<cfset hi = hi + 1>	
		<cfelseif aofgpct[ii] neq 0>
			<cfset lo = lo + 1>
		</cfif>
	</cfloop>	
	
	<cfif #arraylen(aoFGPct)# neq 0>
		<cfset hifgpct = hi/ #arraylen(aoFGPct)#>
		<cfset lofgpct = lo/ #arraylen(aoFGPct)#>
	</cfif>

	<cfset hi = 0>
	<cfset lo = 0>
	
	<cfloop index="ii" from="1" to="#arraylen(adFgpct)#">
		<cfif adFgpct[ii] gt 0>
			<cfset hi = hi + 1>	
		<cfelseif adFgpct[ii] neq 0>
			<cfset lo = lo + 1>
		</cfif>
	</cfloop>	
	
	<cfif #arraylen(adFgpct)# neq 0>
		<cfset hidFGpct = hi/ #arraylen(adFgpct)#>
		<cfset lodFGpct = lo/ #arraylen(adFgpct)#>
	</cfif>

	3pt Pct

	<cfset aotppct    = ListToArray(Valuelist(GetHomeInfo.otppct))>
	<cfset adtppct    = ListToArray(Valuelist(GetHomeInfo.dtppct))>

	<cfset hi = 0>
	<cfset lo = 0>
	
	<cfloop index="ii" from="1" to="#arraylen(aotppct)#">
		<cfif aotppct[ii] gt 0>
			<cfset hi = hi + 1>	
		<cfelseif aotppct[ii] neq 0>
			<cfset lo = lo + 1>
		</cfif>
	</cfloop>
	
	<cfif #arraylen(aoTPPct)# neq 0>	
		<cfset hitppct = hi/ #arraylen(aoTPPct)#>
		<cfset lotppct = lo/ #arraylen(aoTPPct)#>
	</cfif>

	<cfset hi = 0>
	<cfset lo = 0>
	<cfloop index="ii" from="1" to="#arraylen(adTPpct)#">
		<cfif adTPpct[ii] gt 0>
			<cfset hi = hi + 1>	
		<cfelseif adTPpct[ii] neq 0 >
			<cfset lo = lo + 1>
		</cfif>
	</cfloop>
	
	<cfif #arraylen(adTppct)# neq 0>	
		<cfset hidTppct = hi/ #arraylen(adTppct)#>
		<cfset lodTppct = lo/ #arraylen(adTppct)#>
	</cfif>

	Turnovers

	<cfset aoturnover    = ListToArray(Valuelist(GetHomeInfo.oturnovers))>
	<cfset adturnover    = ListToArray(Valuelist(GetHomeInfo.dturnovers))>


	<cfset hi = 0>
	<cfset lo = 0>
	<cfloop index="ii" from="1" to="#arraylen(aoturnover)#">
		<cfif aoturnover[ii] gt 0>
			<cfset hi = hi + 1>	
		<cfelseif aoturnover[ii] neq 0>
			<cfset lo = lo + 1>
		</cfif>
	</cfloop>
	
	<cfif #arraylen(aoTurnover)# neq 0>	
		<cfset hiturnover = hi/ #arraylen(aoTurnover)#>
		<cfset loturnover = lo/ #arraylen(aoTurnover)#>
	</cfif>

	<cfset hi = 0>
	<cfset lo = 0>
		
	<cfloop index="ii" from="1" to="#arraylen(adTurnover)#">
		<cfif adTurnover[ii] gt 0>
			<cfset hi = hi + 1>	
		<cfelseif adTurnover[ii] neq 0>
			<cfset lo = lo + 1>
		</cfif>
	</cfloop>	
	
	<cfif #arraylen(adTurnover)# neq 0>
		<cfset hidTurnover = hi/ #arraylen(adTurnover)#>
		<cfset lodTurnover = lo/ #arraylen(adTurnover)#>
	</cfif>

	
	
	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #aofga#	
	returnvariable  = "sdFGA"			
	>


	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #adfga#	
	returnvariable  = "sddFGA"			
	>


	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #aoTpa#	
	returnvariable  = "sdTPA"			
	>


	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #adTpa#	
	returnvariable  = "sddTPA"			
	>



	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #aofta#	
	returnvariable  = "sdFtA"			
	>


	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #adfta#	
	returnvariable  = "sddFtA"			
	>

	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #aoturnover#	
	returnvariable  = "sdturnover"			
	>


	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #adturnover#	
	returnvariable  = "sddturnover"			
	>


	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #aofgpct#	
	returnvariable  = "sdFGpct"			
	>


	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #adfgpct#	
	returnvariable  = "sddFGpct"			
	>



	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #aoreb#	
	returnvariable  = "sdOreb"			
	>


	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #adreb#	
	returnvariable  = "sddReb"			
	>


	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #aotppct#	
	returnvariable  = "sdTPpct"			
	>


	<!--- Get Standard Deviations --->
	<cfinvoke method="stndDeviation" 
	component       = "NumericFunctions"	
	arryOfNumbers   = #adtppct#	
	returnvariable  = "sddTPpct"			
	>





	<cfquery  datasource="nba" name="addit">
			insert into PowerSD(Team,Ha,oreb,dreb,ofga,dfga,otpa,dtpa,ofta,dfta,ofgpct,dfgpct,otppct,dtppct,oturnovers,dturnovers,
			hireb,hidreb,hifga,hidfga,hitpa,hidtpa,hifta,hidfta,hifgpct,hidfgpct,hitppct,hidtppct,hiturnover,hidturnover,
			loreb,lodreb,lofga,lodfga,lotpa,lodtpa,lofta,lodfta,lofgpct,lodfgpct,lotppct,lodtppct,loturnover,lodturnover
			)
			values
			(
			'#GetTeams.Team#','A',#sdoreb#,#sddreb#,#sdfga#,#sddfga#,#sdtpa#,#sddtpa#,#sdfta#,#sddfta#,#sdfgpct#,#sddfgpct#,#sdtppct#,#sddtppct#,#sdturnover#,#sddturnover#,
			#hireb#,#hidreb#,#hifga#,#hidfga#,#hitpa#,#hidtpa#,#hifta#,#hidfta#,#hifgpct#,#hidfgpct#,#hitppct#,#hidtppct#,#hiturnover#,#hidturnover#,
			#loreb#,#lodreb#,#lofga#,#lodfga#,#lotpa#,#lodtpa#,#lofta#,#lodfta#,#lofgpct#,#lodfgpct#,#lotppct#,#lodtppct#,#loturnover#,#lodturnover#
			
			)
			
	</cfquery>
	

</cfloop>



<cfcatch type="any">
  
	<cfhttp method='post'
		url='http://www.pointspreadpros.com/NBACode/EmailAlert.cfm'>
		<cfhttpparam name='myBody'    type='FormField' value='#cfcatch.Detail#'>
		<cfhttpparam name='mySubject' type='FormField' value="Error:CreateSDForPower.cfm">
		<cfhttpparam name='myCC'      type='FormField' value="jmcguin1@nycap.rr.com">
	</cfhttp>

</cfcatch>

</cftry>

</cfif>

