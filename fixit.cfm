<cfquery datasource="NBA" Name="Fixit">
Select * from FinalPicks
where gametime='20181017'
</cfquery>

<cfloop query="Fixit">
<cfquery datasource="NBA" Name="Fixit2">
Insert into NBASchedule(Gametime,fav,spd,ha,und,ou) Values('#fixit.Gametime#','#fixit.fav#',#fixit.spd#,'#fixit.ha#','#fixit.und#',0)

</cfquery>

</cfloop>