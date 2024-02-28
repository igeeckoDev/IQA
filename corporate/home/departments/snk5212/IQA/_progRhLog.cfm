<!--- April 29. 2009 
Tested for CF8/Oracle
replaced query that referenced stored query "ProgramRevLog"
--->

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset title = "Program List - Revision History Log by Program">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfquery Datasource="Corporate" name="RHLog"> 
SELECT ProgDev.Program, ProgDev_RH.RevNo, ProgDev_RH.RevDate, ProgDev_RH.RevAuthor, ProgDev_RH.RevDetails
FROM ProgDev, ProgDev_RH
WHERE ProgDev.ID = ProgDev_RH.ProgID
ORDER BY Program, RevNo DESC
</CFQUERY>

<br>

<cfset prog = "">
<cfoutput query="RHLog">
	<cfif prog is NOT program>
		<b>#program#</b><br>
	</cfif>
<u>Rev Number:</u> #revNo#<br>
<u>Date:</u> #dateformat(RevDate, "mm/dd/yyyy")#<br>
<u>Author</u>: #RevAuthor#<br>
<u>Details:</u> #RevDetails#<br><br>
<cfset prog = #program#>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->