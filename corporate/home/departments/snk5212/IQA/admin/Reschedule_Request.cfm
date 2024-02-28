<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Reschedule Request Completed">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfoutput>
<br />
<font color="red"><b>#url.msg#</b></font><br /><br />

<a href="auditdetails.cfm?id=#url.id#&year=#url.year#">Return to Audit Details</a><Br /><Br />
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->