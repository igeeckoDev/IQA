<!--- Start of Page File --->
<cfset subTitle = "Add a CAR Trend Report - Custom CAR Grouping">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfinclude template="shared/incVariables_Report.cfm">

<cfoutput>
<b>Category</b><br />
#FunctionFieldName#<br /><br />

<b>Value</b><br />
#url.Function#<br /><br />

<b>Sort Field</b><br />
#sortFieldName#<br><br>

Do you want to create this CAR Trend Report?<br />

<a href="GroupReport_Submit.cfm?#CGI.Query_String#"><img align="absmiddle" src="#SiteDir#SiteImages/bullet_tick.png" border="0" alt="Create Report" /></a> <a href="GroupReport_Submit.cfm?#CGI.Query_String#">Create Report</a><br />

<a href="Report.cfm"><img align="absmiddle" src="#SiteDir#SiteImages/bullet_cross.png" border="0" alt="Cancel Report" /></a> <a href="Report.cfm">Cancel</a><br />
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->