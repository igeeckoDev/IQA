<!--- April 29. 2009 
Tested for CF8/Oracle
replaced query that referenced stored query "ProgramRevLog"
--->

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Program List - Revision History Log by Revision Date">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfquery Datasource="Corporate" name="RHLog"> 
SELECT ProgDev.Program, ProgDev_RH.RevNo, ProgDev_RH.RevDate, ProgDev_RH.RevAuthor, ProgDev_RH.RevDetails
FROM ProgDev, ProgDev_RH
WHERE ProgDev.ID = ProgDev_RH.ProgID
ORDER BY RevDate DESC, Program, RevNo DESC
</CFQUERY>

<br>

<cfset date = "">
<cfoutput query="RHLog">
	<cfif date is NOT revdate>
		<b>#dateformat(RevDate, "mmmm dd, yyyy")#</b><br>
	</cfif>
<u>Program:</u> #Program#<br>
<u>Rev Number:</u> #revNo#<br>
<u>Author</u>: #RevAuthor#<br>
<u>Details:</u> #RevDetails#<br><br>
<cfset date = #revdate#>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->