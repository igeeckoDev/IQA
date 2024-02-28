<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "UL OSHA SNAP Sites - Revision History Log">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfquery Datasource="Corporate" name="SNAPLog"> 
SELECT SNAP_RH.*, IQAtblOffices.OfficeName
FROM SNAP_RH, IQAtblOffices
WHERE IQAtblOffices.ID = SNAP_RH.OfficeNameID
ORDER BY IQAtblOffices.OfficeName, RevNo DESC
</CFQUERY>

<br>

<cfset Office = "">
<cfoutput query="SNAPLog">
	<cfif Office is NOT OfficeName>
		<b>#OfficeName#</b><Br>
	</cfif>
		
		<u>Rev Number:</u> #revNo#<br>
<u>Date:</u> #dateformat(RevDate, "mm/dd/yyyy")#<br>
<u>Author</u>: #RevAuthor#<br>
	<cfset dump = #replace(RevDetails, "<p>", "", "All")#>
	<cfset dump1 = #replace(dump, "</p>", "", "All")#>
	<cfset dump2 = #replace(dump1, "<br /><br />", "", "All")#>
	<cfset dump3 = #replace(dump2, "<br><br>", "", "All")#>
<u>Details:</u> #dump3#<br><br>

<cfset Office = #OfficeName#>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->