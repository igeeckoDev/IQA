<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href='CARSurvey_Distribution.cfm'>CAR Survey</a> - Survey Response List">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->
<cfoutput>
Survey Link used in GCAR "Closed Awaiting Verification" Emails<br><br>

<b>#request.serverProtocol##request.serverDomain#/departments/snk5212/QE/getEmpNo.cfm?page=CARSurvey</b><br><br>
</cfoutput>
This link can be copied into an email and sent to anyone.<br><br>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->