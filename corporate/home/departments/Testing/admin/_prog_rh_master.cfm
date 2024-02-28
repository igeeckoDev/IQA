<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="Program List - Revision History Log - Application Changes">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfquery Datasource="Corporate" name="RH">
SELECT * from Prog_RH
ORDER BY Rev DESC
</CFQUERY>

<br>
<cfoutput query="RH">
<b>Revision Number</b> #Rev#<br>
<b>Revision Date</b> #DateFormat(Date_, 'mmmm dd, yyyy')#<br>
<b>Details</b> #History#<br><br>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->