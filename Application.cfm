<!--- Set Session Management s --->
<CFAPPLICATION
NAME                                 ="PSP"
SETCLIENTCOOKIES                     ="Yes"
CLIENTMANAGEMENT                     ="Yes"
SESSIONMANAGEMENT                    ="Yes"
SESSIONTIMEOUT                       ="#CreateTimeSpan(1,0,0,0)#" APPLICATIONTIMEOUT="#CreateTimeSpan(1,0,0,0)#">

<cferror type="exception" template="error.cfm">
<cferror type="request" template="error.cfm">

<CFSET Application.DSN               = "psp_psp" >
<cfset Variables.BrowserName 		 = FindNoCase("MSIE", #HTTP_USER_AGENT#, 1)>
	<cfset myyyyy = Year(now())>
	<cfset mymm   = Month(now())>
	<cfset mydd   = Day(now())>
		
	<cfif len(mymm) is 1>
		<cfset mymm = '0' & '#mymm#'>
	</cfif>	

	<cfif len(mydd) is 1>
		<cfset mydd = '0' & '#mydd#'>
	</cfif>	

<cfset Session.gametime =  '#myyyyy#' & '#mymm#' & '#mydd#'>


<!--- <cfcookie expires="now" name="email"> --->

