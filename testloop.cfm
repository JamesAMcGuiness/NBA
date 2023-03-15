<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

<cfquery datasource="nba" name="getspds">
select * from nbaschedule where gametime='20090115'
</cfquery>

<cfloop query="getspds">
	<cfloop index="jj" from="1" to="10">
		<cfoutput>
		Testing #fav# vs #jj#<br>
		</cfoutput>
	</cfloop>
	<hr>
</cfloop>

---------------------------------------------------------------<br>

<cfloop query="getspds">
	<cfloop index="jj" from="1" to="10">
		<cfoutput>
		Testing #fav# vs #jj#<br>
		</cfoutput>
	</cfloop>
	<hr>
</cfloop>



</body>
</html>
