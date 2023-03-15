<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

<cfquery datasource="NBA" name="addit">
Delete from nbadata
</cfquery>

<cfquery datasource='nbaschedule' name="getit">
Select * from nbaschedule
</cfquery>

<cfoutput query="Getit">

<cfquery datasource="NBA" name="addit">
Insert into Nbaschedule
(
gametime,
fav,
ha,
und,
ou,
spd
)
Values
(
'#Getit.Gametime#',
'#Getit.Fav#',
'#Getit.ha#',
'#Getit.Und#',
#Getit.ou#,
#Getit.spd#
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


</body>
</html>
