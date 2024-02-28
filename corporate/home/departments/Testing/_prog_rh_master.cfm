<!--- April 29. 2009
Added alias "Date" for new field "date_" due to Oracle conversion
Tested for CF8/Oracle
--->

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Program List - Revision History Log - Application Changes">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfquery Datasource="Corporate" name="RH">
SELECT Rev, History, Date_ AS "Date"
FROM Prog_RH
ORDER BY Rev DESC
</CFQUERY>

<br>
<cfoutput query="RH">
<b>Revision Number</b> #Rev#<br>
<b>Revision Date</b> #dateformat(Date, "mm/dd/yyyy")#<br>
<b>Details</b> #History#<br><br>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->