<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

<cfquery datasource="NBA" name="addit">
select distinct gametime,fav,und,spd,ha
from nbaschedule s
where gametime >= '20080101'
order by s.gametime
</cfquery>

<cfoutput query="Addit">

	<cfquery datasource="Nba" name="GetRunct">
	Update nbagametime
	set Gametime='#trim(Addit.gametime)#'
	</cfquery>

	<cfquery datasource="Nba" name="GetRunct">
	Select RunCt,Gametime
	from NBAGameTime
	</cfquery>

<!-- Create the GAPS for each team for that time period... -->

<cfset yyyy = left(GetRunCt.gametime,4)>
<cfset mm   = mid(GetRunCt.gametime,5,2)>
<cfset dd   = right(GetRunCt.gametime,2)>
<cfset mydate = #Dateformat(DateAdd("d",1,CreateDate(yyyy,mm,dd)),'yyyymmdd')#>


<cfset variables.gametime = '#GetRunCt.GameTime#'>

<cfoutput>
#variables.gametime#<br>
</cfoutput>

	
<cfloop index="ii" from="1" to="20">

<cfset myteamarr = arraynew(1)>	

<cfif ii is 1>
	<cfset mystat = 'Turnovers'>

	Turnovers<br>	
	<cfquery datasource="Nbastats" name="myquery">
	Select Team,Avg(dturnovers - oturnovers) stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by stat desc
	</cfquery>
	
</cfif>

<cfif ii is 2>
	<cfset mystat = 'Scoring'>
	
	Scoring<br>
	<cfquery datasource="Nbastats" name="myquery">
	Select Team,Avg(ps - dps) stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by stat desc
	</cfquery>
</cfif>
	
<cfif ii is 3>
	<cfset mystat = 'FGAtt'>
	
	FGAtt<br>
	<cfquery datasource="Nbastats" name="myquery">
	Select Team,Avg(ofga - dfga) stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by stat desc
	</cfquery>
</cfif>
	
<cfif ii is 4>
	<cfset mystat = 'FGPct'>
	
	FGpct....<br>
	<cfquery datasource="Nbastats" name="myquery">
	Select Team,Avg(ofgpct - dfgpct) stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by stat desc
	</cfquery>
</cfif>
	
<cfif ii is 5>
	<cfset mystat = 'Rebounding'>
	
	Rebounding...<br>
	<cfquery datasource="Nbastats" name="myquery">
	Select Team,Avg(otreb  - dtreb) stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by stat desc
	</cfquery>
</cfif>

<cfif ii is 6>
	<cfset mystat = 'FTAtt'>
	
	FTAtt...<br>
	<cfquery datasource="Nbastats" name="myquery">
	Select Team,Avg(ofta - dfta) stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by stat desc
	</cfquery>
</cfif>
	
<cfif ii is 7>
	<cfset mystat = 'TPAtt'>
	
	TPAtt...<br>
	<cfquery datasource="Nbastats" name="myquery">
	Select Team,Avg(otpm - dtpm) stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by stat desc
	</cfquery>
</cfif>


<cfif ii is 8>
	<cfset mystat = 'TPPct'>
	
	TPPct...<br>
	<cfquery datasource="Nbastats" name="myquery">
	Select Team,Avg(otppct - dtppct) stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by stat desc
	</cfquery>
</cfif>


<cfif ii is 9>
	<cfset mystat = 'ops'>
	
	
	<cfquery datasource="Nbastats" name="myquery">
	Select Team,Avg(ps) stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by stat desc
	</cfquery>
</cfif>
	
<cfif ii is 10>
	<cfset mystat = 'dps'>
		
	<cfquery datasource="Nbastats" name="myquery">
	Select Team,Avg(dps) stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by stat asc
	</cfquery>
</cfif>	
	
<cfif ii is 11>
	<cfset mystat = 'ofgpct'>
		
	<cfquery datasource="Nbastats" name="myquery">
	Select Team,Avg(ofgpct) stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by stat desc
	</cfquery>
</cfif>	
	
<cfif ii is 12>
	<cfset mystat = 'dfgpct'>
		
	<cfquery datasource="Nbastats" name="myquery">
	Select Team,Avg(dfgpct) stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by stat asc
	</cfquery>
</cfif>	
	
<cfif ii is 13>
	<cfset mystat = 'orebounding'>
		
	<cfquery datasource="Nbastats" name="myquery">
	Select Team,Avg(oReb) stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by stat desc
	</cfquery>
</cfif>	
	
<cfif ii is 14>
	<cfset mystat = 'drebounding'>
		
	<cfquery datasource="Nbastats" name="myquery">
	Select Team,Avg(dReb) stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by stat asc
	</cfquery>
</cfif>	
	
	
<cfif ii is 15>
	<cfset mystat = 'ofta'>
		
	<cfquery datasource="Nbastats" name="myquery">
	Select Team,Avg(ofta) stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by stat desc
	</cfquery>
</cfif>	
	
<cfif ii is 16>
	<cfset mystat = 'dfta'>
		
	<cfquery datasource="Nbastats" name="myquery">
	Select Team,Avg(dfta) stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by stat asc
	</cfquery>
</cfif>	
	
<cfif ii is 17>
	<cfset mystat = 'otppct'>
		
	<cfquery datasource="Nbastats" name="myquery">
	Select Team,Avg(otppct) stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by stat desc
	</cfquery>
</cfif>	
	
<cfif ii is 18>
	<cfset mystat = 'dtppct'>
		
	<cfquery datasource="Nbastats" name="myquery">
	Select Team,Avg(dtppct) stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by stat asc
	</cfquery>
</cfif>	
	
<cfif ii is 19>
	<cfset mystat = 'oturnovers'>
		
	<cfquery datasource="Nbastats" name="myquery">
	Select Team,Avg(oturnovers) stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by stat asc
	</cfquery>
</cfif>	
	
<cfif ii is 20>
	<cfset mystat = 'dturnovers'>
		
	<cfquery datasource="Nbastats" name="myquery">
	Select Team,Avg(dturnovers) stat
	from NBAData
	where gametime < '#variables.gametime#'
	group by team
	order by stat desc
	</cfquery>
</cfif>	
	
	
	
	
<cfloop query="myquery">
	<cfset  arrayappend(myteamarr,'#team#')> 
</cfloop>


<cfloop query="myquery">
	<cfset myRat = gap(myteamarr,'#myquery.Team#',10,20,30)>
<!-- 	#Team#: #myrat#...#stat#<br> -->
	
	<cfquery datasource="Nba" name="checkit">
		Select * from gap
		Where Team = '#myquery.team#'
	</cfquery>

	<cfif checkit.recordcount is 0>
		<cfquery datasource="Nba" name="changeit">
		Insert into GAP
		(
		team ,
		#mystat#
		)
		Values
		(
		'#myquery.team#',
		'#myrat#'
		)
		</cfquery>
	<cfelse>

	
		
		<cfquery datasource="Nba" name="changeit">
			Update GAP
			Set #mystat# = '#myrat#'
			Where Team = '#myquery.team#'
		</cfquery>

	</cfif>
</cfloop>

</cfloop>


<!-- Now we can use the GAP values.... -->

<cfquery datasource="NBA" name="Favstuff">
select *
from nbaschedule s, gap g
where 
g.Team = s.fav 
and s.gametime='#variables.gametime#'
</cfquery>

<cfquery datasource="NBA" name="Undstuff">
select *
from nbaschedule s, gap g
where 
g.Team = s.und 
and s.gametime='#variables.gametime#'
</cfquery>

<cfquery datasource="NBA" name="addit3">
Insert into BlowoutPoss
(
gametime,
fav,
ha,
und,
spd,
Fscoring,
FRebound,
FTurnover,
FFGPct,
Uscoring,
URebound,
UTurnover,
UFGPct
)
Values
(
'#variables.gametime#',
'#Addit.Fav#',
'#Addit.ha#',
'#Addit.Und#',
#Addit.spd#,
'#FavStuff.scoring#',
'#FavStuff.Rebounding#',
'#FavStuff.Turnovers#',
'#FavStuff.FGPct#',
'#UndStuff.scoring#',
'#UndStuff.Rebounding#',
'#UndStuff.Turnovers#',
'#UndStuff.FGPct#'
)
</cfquery>

</cfoutput>


<!---  
<cfquery datasource='nbasata>
select 
from nbadata d, nbaschedule s , 
where s.gametime = d.gametime and (d.ps - d.dps > s.spd + 10) and (s.fav = d.team) 
</cfquery>


<cfquery datasource="NBA" name="Getinfo">


</cfquery>
--->
<cfscript>
function gap(myteamarr,myteam,gHigh,aHigh,pHigh)
{

var currentRow = 1;
for (; currentRow lte ArrayLen(myteamarr) ;)
	
	//WriteOutput(#myteamarr[currentRow]#);

	{

//	WriteOutput('....' & currentRow); 
		if (#trim(myteam)# is #trim(myteamarr[currentRow])#)
		{
		
			//WriteOutput('Yes....'); 
			if (currentRow lte gHigh)
			{
				return 'G';
			}
			
			if (currentRow lte aHigh)
			{
				return 'A';
			}
			
			if (currentRow lte pHigh)
			{
				return 'P';
			}
			
		}
		else
		{
				
		}
		currentRow = currentRow + 1;
	}	
	return 'N/A'; 
}
</cfscript>


</body>
</html>
