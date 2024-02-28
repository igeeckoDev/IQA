<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset SubTitle = "Audit Report - <cfoutput>#url.Year#-#url.ID#-#url.AuditedBy#</cfoutput>">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->
<CFSET ID=#url.ID#>
<CFSEt Year= #url.Year#>
<CFSET AuditedBy=#url.AuditedBy#> 

<CFSET H1= "Report_Output_AllNEW1.cfm?ID="& #ID#& "&Year="&#Year#&"&AuditedBy="&#AuditedBy#> 
<CFIF ID EQ #url.ID#>
<a href= "<CFoutPUT>#H1#</CFoutput>">Print</a> Report<br>
</CFIF>
<cfinclude template="qReport_Output_AllNEW.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->