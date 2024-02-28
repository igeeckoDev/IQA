<cfset subTitle = "View Audit Status Pages">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfoutput>
<u>Scope and Report Status</u><br>
:: <a href="Status.cfm?year=#curyear#">Scope Letter, Report, Pathnotes Status</a><br><Br>

<u>Scope and Report On Time Completion Status</u><br>
:: <a href="Status2.cfm?year=#curyear#&month=#curmonth#">by Month</a><br>
:: <a href="Status2year.cfm?year=#curyear#">by Year</a><br>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->