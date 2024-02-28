<cfquery Datasource="Corporate" name="FUS"> 
SELECT * from FUSAreas, FUSLocations
WHERE FUSLocations.ID <> 0
AND FUSAreas.LocationID = FUSLocations.ID
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "UL Inspection Center Locations">
<cfinclude template="SOP.cfm">

<!--- / --->
						  
<cfset LocHolder=""> 

<CFOUTPUT Query="FUS"> 
<cfif LocHolder IS NOT Location> 
<cfIf LocHolder is NOT ""><br></cfif>
<b>#Location#</b><br> 
</cfif>
&nbsp;&nbsp; - #Area#<br>
<cfset LocHolder = Location> 
</CFOUTPUT>
<br><br>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->