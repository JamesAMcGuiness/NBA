<cfquery datasource="nba" name="Getit">
Select Avg(InsidePct) as InsPct,OffDef,team
from PbPPercents
where OffDef='O'
Group by Team,OffDef
order by 1 desc, Offdef
</cfquery>

<cfoutput query="Getit">
#Getit.Offdef#,#Getit.Team#,#Getit.InsPct#<br>


</cfoutput>

<hr>
<cfquery datasource="nba" name="Getit">
Select Avg(InsidePct) as InsPct,OffDef,team
from PbPPercents
where OffDef='D'
Group by Team,OffDef
order by 1, Offdef
</cfquery>

<cfoutput query="Getit">
#Getit.Offdef#,#Getit.Team#,#Getit.InsPct#<br>


</cfoutput>

<hr>

<p></p>



<cfquery datasource="nba" name="Getit">
Select Avg(FTAPct) as InsPct,OffDef,team
from PbPPercents
where OffDef='O'
Group by Team,OffDef
order by 1 desc, Offdef
</cfquery>

<cfoutput query="Getit">
#Getit.Offdef#,#Getit.Team#,#Getit.InsPct#<br>


</cfoutput>

<hr>
<cfquery datasource="nba" name="Getit">
Select Avg(FTAPct) as InsPct,OffDef,team
from PbPPercents
where OffDef='D'
Group by Team,OffDef
order by 1, Offdef
</cfquery>

<cfoutput query="Getit">
#Getit.Offdef#,#Getit.Team#,#Getit.InsPct#<br>


</cfoutput>



<hr>

<p></p>



<cfquery datasource="nba" name="Getit">
Select Avg(Opportunity) as InsPct,OffDef,team
from PbPPercents
where OffDef='O'
Group by Team,OffDef
order by 1 desc, Offdef
</cfquery>

<cfoutput query="Getit">
#Getit.Offdef#,#Getit.Team#,#Getit.InsPct#<br>


</cfoutput>

<hr>
<cfquery datasource="nba" name="Getit">
Select Avg(Opportunity) as InsPct,OffDef,team
from PbPPercents
where OffDef='D'
Group by Team,OffDef
order by 1, Offdef
</cfquery>

<cfoutput query="Getit">
#Getit.Offdef#,#Getit.Team#,#Getit.InsPct#<br>


</cfoutput>