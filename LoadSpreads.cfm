<cfquery name="GetInfo" datasource="Spreads">
Select *
from Spreads
</cfquery>

<cfset row = 1>
<cfset myfav      = ''>
<cfset myspd      = 0>
<cfset myhaforfav = ''>
<cfset rownum = 1>

<cfoutput query="GetInfo">

	#Gametime#,#team#,#ha#,#spd#,#ou#<br>

	<cfif rownum neq 0 and Len(GetInfo.Gametime) gt 0>
		<cfset rownum = rownum + 1>
		
		<cfset mygametime1 = Tostring(GetInfo.GameTime)>
		
		<cfset myyear = trim(Left(mygametime1,4))>
		<cfset mymonth = Trim(mid(mygametime1,6,2))>
		<cfset myday = Trim(mid(mygametime1,9,2))>	
		<cfset mygametime = '#myyear#' & '#mymonth#' & '#myday#'>
		
		<cfif row lt 2>

			<!-- This guy is the favorite -->
			<cfif Val(GetInfo.spd) lt 0>
				<cfset myfav      = GetInfo.Team>
				<cfset myspd      = -1*(val(GetInfo.spd))>
				<cfset myhaforfav = GetInfo.ha>
			<cfelse>
				<cfset myund      = GetInfo.Team>
			</cfif> 
	
			xrow is:#row#....mygametime1=#mygametime1#====> #myyear#..#mymonth#..#myday#....Final:#mygametime#...#Team#<br>
			------------------------------------------------------------------------------------------------<br>
			<br>
			<cfset row = row + 1>
			
		<cfelse>

			<!-- This guy is the favorite -->
			<cfif Val(GetInfo.spd) lt 0>
				<cfset myfav      = GetInfo.Team>
				<cfset myspd      = -1*(val(GetInfo.spd))>
				<cfset myhaforfav = GetInfo.ha>
			<cfelse>
				<cfset myund      = GetInfo.Team>
			</cfif> 

			yrow is:#row#...Storing:mygametime1=#mygametime1#====> #myyear#..#mymonth#..#myday#....Final:#mygametime#...#Team#<br>
			------------------------------------------------------------------------------------------------<br>
			<br>
			<cfset myou               = val(Getinfo.ou)> 
		
			<cfquery  name="Addit" datasource="NBASchedule">
			Insert into NBASchedule
			(
			Gametime,
			Fav,
			ha,
			Und,
			ou,
			spd
			)
			Values
			(
			'#myGametime#',
			'#myFav#',
			'#myhaforfav#',
			'#myUnd#',
			#myou#,
			#myspd#
			) 
			</cfquery>

			<cfset row = 1>
		
		</cfif>
	
		
	</cfif>
	
	<cfset rownum = rownum + 1>

</cfoutput>
