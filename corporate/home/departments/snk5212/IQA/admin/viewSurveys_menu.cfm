<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Surveys - Menu">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<b>View</b>:<br>
:: <a href="CARSurvey_Distribution.cfm">CAR Survey Management</a><br>
<cfoutput>
:: <a href="AuditSurvey_Distribution.cfm?Year=#curYear#">Audit Survey Management</a><br><br>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->