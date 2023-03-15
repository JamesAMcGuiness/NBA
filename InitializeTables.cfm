<cfset thedate ='20221018'>

<cfif 1 is 1>
<cfquery datasource="Nba" name="GetStatus">
DELETE from  NBAData	
Where Gametime <= '#thedate#'	
</cfquery>
</cfif>

<cfquery datasource="Nba" name="GetStatus">
DELETE from  NBADRivecharts	
Where Gametime <= '#thedate#'	
</cfquery>


<cfquery datasource="Nba" name="GetStatus">
DELETE from  Matrix	
Where Gametime <= '#thedate#'	
</cfquery>

<cfquery datasource="Nba" name="GetStatus">
DELETE from  MatrixDfgpct	
Where Gametime <= '#thedate#'	
</cfquery>

<cfquery datasource="Nba" name="GetStatus">
DELETE from  MatrixDftm	
Where Gametime <= '#thedate#'	
</cfquery>

<cfquery datasource="Nba" name="GetStatus">
DELETE from  MatrixDPIP	
Where Gametime <= '#thedate#'	
</cfquery>

<cfquery datasource="Nba" name="GetStatus">
DELETE from  MatrixDPs	
Where Gametime <= '#thedate#'	
</cfquery>

<cfquery datasource="Nba" name="GetStatus">
DELETE from  MatrixDReb	
Where Gametime <= '#thedate#'	
</cfquery>

<cfquery datasource="Nba" name="GetStatus">
DELETE from  MatrixDto	
Where Gametime <= '#thedate#'	
</cfquery>


<cfquery datasource="Nba" name="GetStatus">
DELETE from  MatrixDTpm	
Where Gametime <= '#thedate#'	
</cfquery>


<cfquery datasource="Nba" name="GetStatus">
DELETE from  MatrixFGPCT	
Where Gametime <= '#thedate#'	
</cfquery>

<cfquery datasource="Nba" name="GetStatus">
DELETE from  MatrixFTM	
Where Gametime <= '#thedate#'	
</cfquery>


<cfquery datasource="Nba" name="GetStatus">
DELETE from  MatrixPIP	
Where Gametime <= '#thedate#'	
</cfquery>


<cfquery datasource="Nba" name="GetStatus">
DELETE from  MatrixReb	
Where Gametime <= '#thedate#'	
</cfquery>


<cfquery datasource="Nba" name="GetStatus">
DELETE from  MatrixTo	
Where Gametime <= '#thedate#'	
</cfquery>


<cfquery datasource="Nba" name="GetStatus">
DELETE from  MatrixTPM	
Where Gametime <= '#thedate#'	
</cfquery>







