<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset SubTitle = "Audit Report - <cfoutput>#url.Year#-#url.ID#-#url.AuditedBy#</cfoutput>">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfinclude template="qReport_Output_All.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->